function mat_info        =  UserDefinedModel

%--------------------------------------------------------------------------
% Material properties of the solid 
%--------------------------------------------------------------------------
E0                             =  1;
nu0                            =  0.3;
mu0                            =  0.5*E0/(1 + nu0);
lambda0                        =  E0*nu0/((1 + nu0)*(1 - 2*nu0));
mat_info.density               =  1;
%--------------------------------------------------------------------------
% Chose material parameters for the different models
%--------------------------------------------------------------------------
mat_info.model                 =  'MooneyRivlin';
%mat_info.model                 =  'MooneyRivlinTITension';
switch mat_info.model
    case 'MooneyRivlin'
        %------------------------------------------------------------------
        %  mu0  =  mu1 + mu2;   lambda0  =  lambda + 2*mu2;
        %------------------------------------------------------------------
        mat_info.mu1           =  (mu0);
        mat_info.mu2           =  (mu0/2)*0;
        mat_info.lambda        =  (lambda0 - 2*mat_info.mu2);
    case 'NeoHookean'
        %------------------------------------------------------------------
        %  mu0  =  mu1 + mu2;   lambda0  =  lambda + 2*mu2;
        %------------------------------------------------------------------
        mat_info.mu            =  mu0;
        mat_info.lambda        =  lambda0;
    case 'IsochoricMooneyRivlin'
        mat_info.mu1           =  1;
        mat_info.mu2           =  1;
        mat_info.lambda        =  0;
    case 'ArrudaBoyce'
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
    case 'MooneyRivlinTITension'
        %------------------------------------------------------------------
        %  mu0  =  mu1 + mu2;   lambda0  =  lambda + 2*mu2;
        %------------------------------------------------------------------
        mat_info.mu1           =  (mu0);
        mat_info.mu2           =  (mu0/2)*0;
        mat_info.muani         =  mu0*10;
        mat_info.lambda        =  (lambda0 - 2*mat_info.mu2);
        mat_info.N0           =  [1;1]/norm([1;1]);
%         mat_info.N0            =  [1;0]/norm([1;0]);
%         mat_info.N0            =  [0;1]/norm([0;1]);
end



