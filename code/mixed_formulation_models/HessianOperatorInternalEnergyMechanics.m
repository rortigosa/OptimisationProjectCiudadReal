%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes:
% The components of the Hessian operator of the internal energy 
% for electromechanical problems in terms of F, H, J, D0 and d
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function  mat_info  =  HessianOperatorInternalEnergyMechanics(ielem,dim,n_gauss,F,H,J,mat_info,model)  
%--------------------------------------------------------------------------
% Different models
%--------------------------------------------------------------------------
switch model
    %----------------------------------------------------------------------
    % Simplified ideal dielectric elastomer
    %----------------------------------------------------------------------
    case 'Neo_Hookean'
        mat_info    =  HessianCompressibleNeoHookean(ielem,dim,n_gauss,...
                                                                 J,mat_info);
    case 'Mooney_Rivlin'
        mat_info    =  HessianCompressibleMooneyRivlin(ielem,dim,n_gauss,...
                                                                 J,mat_info);
    case 'Arruda_Boyce'
        mat_info    =  HessianCompressibleArrudaBoyce(ielem,dim,n_gauss,...
                                                                 F,J,mat_info);
    case 'Gent'
        mat_info    =  HessianCompressibleGent(ielem,dim,n_gauss,...
                                                                 F,J,mat_info);
    case 'Yeoh'
        mat_info    =  HessianCompressibleYeoh(ielem,dim,n_gauss,...
                                                                 F,J,mat_info);
end        
        
