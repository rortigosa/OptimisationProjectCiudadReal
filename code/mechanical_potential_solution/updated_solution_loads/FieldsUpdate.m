%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% The fields of a specific formulation are updated here
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Solution             =  FieldsUpdate(Data,Geometry,Mesh,Solution,TimeIntegrator,Contact)

switch Data.formulation
    case 'u'
         Solution         =  UpdatedIncrementalVariablesU(Geometry.dim,Mesh,Solution,TimeIntegrator,Contact);
    case 'up'
         Solution         =  UpdatedIncrementalVariablesUP(Geometry.dim,Mesh,Solution,TimeIntegrator,Contact);
end
