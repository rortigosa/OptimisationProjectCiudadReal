%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  This function performs the assembly of the orce vectors associated to
%  the internal terms of the equations of:
%  1. Linear momentum.
%  2. Gauss equation
%  Both force vectors are assembled separately. The assembly of both in the
%  same force vector will be carried out in a separated function.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function assembly                         =  InternalVectorsAssembly(ielement,dim,mesh,assembly,formulation)

switch formulation
    case {'electro','electro_BEM_FEM'}
        assembly                          =  InternalVectorsAssemblyElectro(ielement,dim,mesh,assembly);
    case {'electro_incompressible','electro_mixed_incompressible',...
          'electro_incompressible_BEM_FEM','electro_mixed_incompressible_BEM_FEM'}
        assembly                          =  InternalVectorsAssemblyElectroIncompressible(ielement,dim,mesh,assembly);
end
