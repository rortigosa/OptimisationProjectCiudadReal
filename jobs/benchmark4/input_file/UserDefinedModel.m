function [mat_info,...
    penalty,void_scaling_factor,...
  stiffness_scaling_factor,...
  instability_penalty,...
  alpha,dalpha_drho,...
  gamma,dgamma]                =  UserDefinedModel(model,void_region)

%--------------------------------------------------------------------------
% Penalty used in the optimisation (penalty over the density)
%--------------------------------------------------------------------------
penalty                        =  3;
%--------------------------------------------------------------------------
% Scaling factor for the void regions
%--------------------------------------------------------------------------
void_scaling_factor            =  1e-6;
alpha_max                      =  1e-6; 
alpha_min                      =  1e-6;
% alpha_cr                       =  095*alpha_max;
% rho_cr                         =  0.8;
% beta                           =  [[1 1];[rho_cr^2  rho_cr]]\[alpha_max - alpha_min;alpha_cr - alpha_min];
% beta(3)                        =  alpha_min;
% alpha                          =  @(rho) beta(1)*rho.^2 + beta(2)*rho + beta(3);
% dalpha_drho                    =  @(rho) 2*beta(1)*rho + beta(2);
% alpha                          =  @(rho) alpha_max - (alpha_max - alpha_min)*rho;
% dalpha_drho                    =  @(rho) -(alpha_max - alpha_min)*ones(length(rho),1);
% alpha                          =  @(rho) alpha_min*ones(length(rho),1);
% dalpha_drho                    =  @(rho) 0*ones(length(rho),1);
alpha                          =  @(rho) alpha_max - (alpha_max - alpha_min)*rho.^(penalty);
dalpha_drho                    =  @(rho) -penalty*(alpha_max - alpha_min)*rho.^(penalty-1);

%gamma                          =  @(rho) rho.^6;
%dgamma                         =  @(rho) 6*rho.^5;
% gamma                          =  @(rho) rho;
% dgamma                         =  @(rho) ones(length(rho),1);
% gamma                          =  @(rho) ones(length(rho),1);
% dgamma                         =  @(rho) zeros(length(rho),1);
gamma                          =  @(n_elem,value) value*ones(n_elem,1);
dgamma                         =  @(n_elem) zeros(n_elem,1);

%--------------------------------------------------------------------------
% Factor that scales the stiffness matrix in case of instabilities when:
% str.data.nonlinearity = 'nonlinear' and str.data.instability.solver = 'linearised'
%--------------------------------------------------------------------------
stiffness_scaling_factor       =  1;
%--------------------------------------------------------------------------
% Penalty term to penalise unstable solutions were the applied load is
% smaller than the total load
%--------------------------------------------------------------------------
instability_penalty            =  10;
%--------------------------------------------------------------------------
% Material properties of the solid
%--------------------------------------------------------------------------
if void_region
   E0                          =  1*void_scaling_factor;
else
   E0                          =  1;
end    
nu0                            =  0.3;
mu0                            =  0.5*E0/(1 + nu0);
lambda0                        =  E0*nu0/((1 + nu0)*(1 - 2*nu0));
%--------------------------------------------------------------------------
% Chose material parameters for the different models
%--------------------------------------------------------------------------
switch model
    case 'Mooney_Rivlin'
        %------------------------------------------------------------------
        %  mu0  =  mu1 + mu2;   lambda0  =  lambda + 2*mu2;
        %------------------------------------------------------------------
        mat_info.mu1           =  (mu0/2);
        mat_info.mu2           =  (mu0/2)*0;
        mat_info.lambda        =  (lambda0 - 2*mat_info.mu2);
    case 'Neo_Hookean'
        %------------------------------------------------------------------
        %  mu0  =  mu1 + mu2;   lambda0  =  lambda + 2*mu2;
        %------------------------------------------------------------------
        mat_info.mu            =  mu0;
        mat_info.lambda        =  lambda0;
    case 'isochoric_Mooney_Rivlin'
        mat_info.mu1           =  1;
        mat_info.mu2           =  1;
        mat_info.lambda        =  0;
    case 'Arruda_Boyce'
        %------------------------------------------------------------------
        %  mu0  =  mu1 + mu2;   lambda0  =  lambda + (2*(2*m/10 + 198*m^2/525))*mu;
        %------------------------------------------------------------------
        mat_info.m             =  1;
        mat_info.alpha         =  1 + 6*m/10 + 297*m^2/525;
        mat_info.beta          =  2*(2*m/10 + 198*m^2/525);
        mat_info.mu            =  (mu0/mat_info.alpha);
        mat_info.lambda        =  (lambda0 - mat_info.beta*mat_info.mu);
    case 'Gent'
        %------------------------------------------------------------------
        %  mu0  =  mu;   lambda0  =  lambda + (2/(Imax-3))*mu;
        %------------------------------------------------------------------
        mat_info.mu            =  mu0;
        mat_info.Imax          =  6;
        mat_info.beta          =  2/(mat_info.Imax - 3);
        mat_info.lambda        =  lambda0 - mat_info.beta*mat_info.mu;
    case 'Yeoh'
        %------------------------------------------------------------------
        %  mu0  =  mu;   lambda0  =  lambda + (4*k1)*mu;
        %------------------------------------------------------------------
        mat_info.mu            =  mu0;        
        mat_info.k1            =  0.1;
        mat_info.k2            =  0.1;
        mat_info.beta          =  4*mat_info.k1;
        mat_info.lambda        =  lambda0 - mat_info.beta*mat_info.mu;
end
