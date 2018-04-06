
function str                         =  MaterialParametersPreprocessor(str,model,...
                                              model_void)

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
[parameters,q,void_scaling_factor,...
stiffness_scaling_factor,instability_penalty,...
alpha,dalpha_drho,gamma,dgamma,...
inf_density_penalty,sup_density_penalty,...
viscosity,diff_viscosity,...
weakening_linear_model]              =  str.UserDefinedFuncs.MaterialParameters(str.mat_info.material_model,0);
str.mat_info.parameters              =  struct;
str.mat_info.parameters              =  setfield(str.mat_info.parameters,str.mat_info.material_model,parameters);
%--------------------------------------------------------------------------
% Parameters required for the optimisation: 
% 1. Penalty on the density (q)
% 2. Scaling factor for the void region
% 3. Penalty term for unstable solutions
%--------------------------------------------------------------------------                                          
str.mat_info.optimisation.penal             =  q;
str.mat_info.void_scaling_factor            =  void_scaling_factor; %  scaling factor for the void region
str.mat_info.instability_penalty            =  instability_penalty;
str.mat_info.optimisation.void_factor       =  alpha;
str.mat_info.optimisation.diff_void_factor  =  dalpha_drho;
str.mat_info.optimisation.rho_linear        =  gamma;
str.mat_info.optimisation.diff_rho_linear   =  dgamma;
str.mat_info.optimisation.inf_density_penalty  =  inf_density_penalty;
str.mat_info.optimisation.sup_density_penalty  =  sup_density_penalty;
str.mat_info.optimisation.viscosity            =  viscosity;
str.mat_info.optimisation.diff_viscosity       =  diff_viscosity;
str.mat_info.optimisation.weakening_linear_model  =  weakening_linear_model;
%--------------------------------------------------------------------------
% Parameters required for the optimisation that scales the initial
% stiffness in case of instabilities
%--------------------------------------------------------------------------                                          
str.mat_info.parameters.stiffness_scaling_factor  =  stiffness_scaling_factor;
%--------------------------------------------------------------------------
% Material parameters of the void region
%--------------------------------------------------------------------------                                          
material_model_void                  =  str.mat_info.material_model_void;
str.mat_info                         =  rmfield(str.mat_info,'material_model_void');

str.mat_info_void                    =  str.mat_info;
str.mat_info_void                    =  rmfield(str.mat_info_void,'parameters');
str.mat_info_void.parameters         =  [];
str.mat_info_void.material_model     =  material_model_void;
parameters                           =  str.UserDefinedFuncs.MaterialParameters(str.mat_info.material_model,1);
str.mat_info_void.parameters         =  struct;
str.mat_info_void.parameters         =  setfield(str.mat_info_void.parameters,str.mat_info_void.material_model,parameters);
                                     


