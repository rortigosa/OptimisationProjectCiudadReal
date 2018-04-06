%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes:
% The first derivative of the internal energy for electromechanical
% problems in terms of F, H, J, D0 and d
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function  mat_info   =  FirstDerivativeComputationMechanics(ielem,dim,ngauss,F,H,J,mat_info,model)    
%--------------------------------------------------------------------------
% Different models
%--------------------------------------------------------------------------
switch model
    %----------------------------------------------------------------------
    % Simplified ideal dielectric elastomer
    %----------------------------------------------------------------------
    case 'Neo_Hookean'
        mat_info     =  FirstDerivativesCompressibleNeoHookean(ielem,dim,...
                                                                  F,J,mat_info);
    case 'Mooney_Rivlin'
        mat_info     =  FirstDerivativesCompressibleMooneyRivlin(ielem,dim,...
                                                                  F,H,J,mat_info);
    case 'Arruda_Boyce'
        mat_info     =  FirstDerivativesCompressibleArrudaBoyce(ielem,ngauss,dim,...
                                                                  F,J,mat_info);
    case 'Gent'
        mat_info     =  FirstDerivativesCompressibleGent(ielem,ngauss,dim,...
                                                                  F,J,mat_info);
    case 'Yeoh'
        mat_info     =  FirstDerivativesCompressibleYeoh(ielem,ngauss,dim,...
                                                                  F,J,mat_info);
end        
        
        