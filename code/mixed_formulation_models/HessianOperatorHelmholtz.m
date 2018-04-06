%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes:
% The components of the Hessian operator of the internal energy 
% for electromechanical problems in terms of F, H, J, D0 and d
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function  material_information  =  HessianOperatorHelmholtz(ielem,dim,n_gauss,F,H,J,E0,material_information,vectorisation)  

%--------------------------------------------------------------------------
% Different models
%--------------------------------------------------------------------------
switch material_information.material_model{material_information.material_identifier(ielem)}
    %----------------------------------------------------------------------
    % Simplified ideal dielectric elastomer
    %----------------------------------------------------------------------
    case 'ideal_dielectric_elastomer'
        material_information    =  HessianIdealDielectricElastomerHelmholtz(ielem,dim,n_gauss,...
                                                          H,J,E0,material_information,vectorisation);
end        
        
