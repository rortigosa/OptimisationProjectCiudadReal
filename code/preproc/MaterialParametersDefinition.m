%--------------------------------------------------------------------------
% Store the material parameters
%--------------------------------------------------------------------------

function mat_info   =  MaterialParametersDefinition(model,parameters)

mat_info  =  struct;
mat_info  =  setfield(mat_info,model,parameters);


