%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes:
% The first derivative of the internal energy for electromechanical
% problems in terms of F, H, J, D0 and d
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function  material_information   =  FirstDerivativeComputation(ielem,ngauss,F,H,J,D0,d,material_information)    
%--------------------------------------------------------------------------
% Different models
%--------------------------------------------------------------------------
switch material_information.material_model{material_information.material_identifier(ielem)}
    %----------------------------------------------------------------------
    % Simplified ideal dielectric elastomer
    %----------------------------------------------------------------------
    case 'simplified_ideal_dielectric_elastomer'
        material_information     =  FirstDerivativesSimplifiedIdealDielectricElastomer(ielem,ngauss,...
                                                                                   F,H,J,D0,d,material_information);
end        
        
        