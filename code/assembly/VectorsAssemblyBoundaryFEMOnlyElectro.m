function [INDEXI,INDEXJ,...
    DATA]        =  VectorsAssemblyBoundaryFEMOnlyElectro(iedge,mesh,element_assembly)

%--------------------------------------------------------------------------
%  dofs
%--------------------------------------------------------------------------
global_phi_dof   =  mesh.surface.phi.boundary_edges(:,iedge);
%--------------------------------------------------------------------------
% INDEXI, INDEXJ, DATA
%--------------------------------------------------------------------------
INDEXI           =  global_phi_dof;
INDEXJ           =  ones(size(INDEXI,1),1);
DATA             =  element_assembly.Tphi;
