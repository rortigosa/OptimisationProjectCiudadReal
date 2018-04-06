%--------------------------------------------------------------------------
% Store the material parameters
%--------------------------------------------------------------------------

function mat_info                      =  MaterialParametersDefinition(model,imat,mat_info,MaterialParametes,void_region)

%--------------------------------------------------------------------------
% Called the user defined routine
%--------------------------------------------------------------------------
parameters                             =  MaterialParameters(void_region);
%--------------------------------------------------------------------------
% Store material parameters for the different models
%--------------------------------------------------------------------------
switch model
    case 'Mooney_Rivlin'
        %------------------------------------------------------------------
        %  mu0  =  mu1 + mu2;   lambda0  =  lambda + 2*mu2;
        %------------------------------------------------------------------
        mat_info.MRivlin.mu1(imat)     =  parameters.mu1;
        mat_info.MRivlin.mu2(imat)     =  parameters.mu2;
        mat_info.MRivlin.kappa(imat)   =  parameters.lambda;
    case 'Neo_Hookean'
        %------------------------------------------------------------------
        %  mu0  =  mu1 + mu2;   lambda0  =  lambda + 2*mu2;
        %------------------------------------------------------------------
        mat_info.NHookean.mu(imat)     =  parameters.mu;
        mat_info.NHookean.kappa(imat)  =  parameters.lambda;
    case 'isochoric_Mooney_Rivlin'
        mat_info.IMRivlin.mu1(imat)    =  parameters.mu1;
        mat_info.IMRivlin.mu2(imat)    =  parameters.mu2;
        mat_info.IMRivlin.kappa(imat)  =  parameters.lambda;
    case 'Arruda_Boyce'
        %------------------------------------------------------------------
        %  mu0  =  mu1 + mu2;   lambda0  =  lambda + (2*(2*m/10 + 198*m^2/525))*mu;
        %------------------------------------------------------------------
        mat_info.ABoyce.mu(imat)       =  parameters.mu;
        mat_info.ABoyce.m(imat)        =  parameters.m;
        mat_info.ABoyce.kappa(imat)    =  parameters.lambda;
    case 'Gent'
        %------------------------------------------------------------------
        %  mu0  =  mu;   lambda0  =  lambda + (2/(Imax-3))*mu;
        %------------------------------------------------------------------
        mat_info.Gent.mu(imat)         =  parameters.mu;
        mat_info.Gent.Imax(imat)       =  parameters.Imax;
        mat_info.Gent.kappa(imat)      =  parameters.lambda;
    case 'Yeoh'
        %------------------------------------------------------------------
        %  mu0  =  mu;   lambda0  =  lambda + (4*k1)*mu;
        %------------------------------------------------------------------
        mat_info.mu(imat)         =  parameters.mu;
        mat_info.k1(imat)         =  parameters.k1;
        mat_info.k2(imat)         =  parameters.k2;
        mat_info.kappa(imat)      =  parameters.lambda;
end
