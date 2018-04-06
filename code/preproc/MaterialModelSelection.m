%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function selects the constitutive model used for the material.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str                      =  MaterialModelSelection(str,model,model_void)

str.mat_info.n_material_models    =  1;
material_model{1}                 =  model;
material_model_void               =  model_void;

if size(material_model,2)==str.mat_info.n_material_models
else
   fprintf('\n Incorrect definition of the material model. Go to function "material_model_selection.m" \n')   
end

str.mat_info.material_model       =  material_model;
str.mat_info.material_model_void  =  material_model_void;

str.mat_info.material_identifier  =  ones(str.mesh.volume.n_elem,1);

if max(str.mat_info.material_identifier)==str.mat_info.n_material_models
else
   fprintf('\n Incorrect definition of the material model. Go to function "material_model_selection.m" \n')
end
