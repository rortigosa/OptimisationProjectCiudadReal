%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Residual arising from the BEM integral
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function assembly          =  VectorsAssemblyBoundaryBEM(iedge,mesh,element_assembly,assembly)

global_q_dof               =  mesh.surface.q.connectivity(:,iedge);
assembly.Tq(global_q_dof)  =  assembly.Tq0(global_q_dof,1) + element_assembly.Tq;         

