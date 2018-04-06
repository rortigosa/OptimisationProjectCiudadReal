%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes:
% The first derivative of the internal energy for electromechanical
% problems in terms of F, H, J, D0 and d
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function  material_information   =  FirstDerivativeComputationMechanicsC(ielem,n_gauss,C,G,c,material_information)    
%--------------------------------------------------------------------------
% Different models
%--------------------------------------------------------------------------
switch material_information.material_model{material_information.material_identifier(ielem)}
    %----------------------------------------------------------------------
    % Simplified ideal dielectric elastomer
    %----------------------------------------------------------------------
    case 'compressible_Mooney_Rivlin'
        material_information     =  FirstDerivativesCompressibleMooneyRivlinC(ielem,n_gauss,...
                                                                  C,G,c,material_information);
end        
        
        