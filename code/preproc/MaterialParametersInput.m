
function str                         =  MaterialParametersInput(str,model,...
                                              model_void,MaterialParameters)

%--------------------------------------------------------------------------
% The model
%--------------------------------------------------------------------------
str.mat_info.material_model       =  model;
str.mat_info.material_model_void  =  model_void;
str.mat_info.material_identifier  =  ones(str.mesh.volume.n_elem,1);

                                          
%--------------------------------------------------------------------------
% Material parameters of the solid region
%--------------------------------------------------------------------------                                          
str.mat_info.parameters              =  [];
str.mat_info.optimisation.density(1) =  1e3;
str.mat_info.n_material_models       =  1;
[parameters,q]                       =  MaterialParameters(str.mat_info.material_model{1},0);
str.mat_info.parameters              =  MaterialParametersDefinition(str.mat_info.material_model{1},...
                                                                 str.mat_info.parameters,parameters);str.mat_info.optimisation.penal      =  q;

%--------------------------------------------------------------------------
% Material parameters of the void region
%--------------------------------------------------------------------------                                          
material_model_void                  =  str.mat_info.material_model_void;
str.mat_info                         =  rmfield(str.mat_info,'material_model_void');

str.mat_info_void                    =  str.mat_info;
str.mat_info_void                    =  rmfield(str.mat_info_void,'parameters');
str.mat_info_void.parameters         =  [];
str.mat_info_void.material_model     =  material_model_void;
parameters                           =  MaterialParameters(str.mat_info.material_model{1},1);
str.mat_info_void.parameters         =  MaterialParametersDefinition(str.mat_info.material_model{1},...
                                                                 str.mat_info.parameters,parameters);
