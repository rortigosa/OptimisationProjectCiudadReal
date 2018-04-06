%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes:
% The components of the Hessian operator of the internal energy 
% for electromechanical problems in terms of F, H, J, D0 and d
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function mat_info =  HessianOperatorInternalEnergyOnlyElectro(ielem,dim,ngauss,D0,mat_info)  
%--------------------------------------------------------------------------
% Different models
%--------------------------------------------------------------------------
switch mat_info.material_model{mat_info.material_identifier(ielem)}
    %----------------------------------------------------------------------
    % Simplified ideal dielectric elastomer
    %----------------------------------------------------------------------
    case 'simplified_ideal_dielectric_elastomer'
        mat_info  =  HessianSimplifiedIdealDielectricElastomerOnlyElectro(ielem,dim,ngauss,mat_info);
end        
        
