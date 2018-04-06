%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes:
% The first derivative of the internal energy for electromechanical
% problems in terms of F, H, J, D0 and d
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function  material_information   =  FirstDerivativeComputationHelmholtz(ielem,dim,ngauss,F,H,J,E0,material_information)    
%--------------------------------------------------------------------------
% Different models
%--------------------------------------------------------------------------
switch material_information.material_model{material_information.material_identifier(ielem)}
    %----------------------------------------------------------------------
    % 3D simplified ideal dielectric elastomer
    %----------------------------------------------------------------------
    case 'ideal_dielectric_elastomer'
        material_information     =  FirstDerivativesThreeDDielectricElastomerHelmholtz(ielem,dim,ngauss,...
                                                                      F,H,J,E0,material_information);
end        
        
        