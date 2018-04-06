%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes:
% The first derivative of the internal energy for electromechanical
% problems in terms of F, H, J, D0 and d
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function  mat_info   =  FirstDerivativeComputationOnlyElectro(ielem,ngauss,D0,mat_info)    
%--------------------------------------------------------------------------
% Different models
%--------------------------------------------------------------------------
switch mat_info.material_model{mat_info.material_identifier(ielem)}
    %----------------------------------------------------------------------
    % Simplified ideal dielectric elastomer
    %----------------------------------------------------------------------
    case 'simplified_ideal_dielectric_elastomer'
        mat_info     =  FirstDerivativesSimplifiedIdealDielectricElastomerOnlyElectro(ielem,...
                                                                           D0,mat_info);
end        
        
        