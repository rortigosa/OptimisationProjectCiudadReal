function element_assembly  =  ElementResidualMatricesInitialisationOnlyElectroBoundary(mesh)

ndof_phi                   =  size(mesh.surface.x.boundary_edges,1);
ndof_q                     =  mesh.surface.q.n_node_elem;
%--------------------------------------------------------------------------
% Residual vectors per element
%--------------------------------------------------------------------------
element_assembly.Tphi      =  zeros(ndof_phi,1);  
%--------------------------------------------------------------------------
% Stiffness matrices per element
%--------------------------------------------------------------------------
element_assembly.Kphiq     =  zeros(ndof_phi,ndof_q);

