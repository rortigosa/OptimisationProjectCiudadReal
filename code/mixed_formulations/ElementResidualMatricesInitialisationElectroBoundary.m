function element_assembly  =  ElementResidualMatricesInitialisationElectroBoundary(dim,mesh)

ndof_x                     =  dim*size(mesh.surface.x.boundary_edges,1);
ndof_phi                   =  size(mesh.surface.x.boundary_edges,1);
ndof_q                     =  mesh.surface.q.n_node_elem;
%--------------------------------------------------------------------------
% Residual vectors per element
%--------------------------------------------------------------------------
element_assembly.Tx        =  zeros(ndof_x,1);
element_assembly.Tphi      =  zeros(ndof_phi,1);  
%--------------------------------------------------------------------------
% Stiffness matrices per element
%--------------------------------------------------------------------------
element_assembly.Kxx       =  zeros(ndof_x,ndof_x);
element_assembly.Kxphi     =  zeros(ndof_x,ndof_phi);
element_assembly.Kxq       =  zeros(ndof_x,ndof_q);

element_assembly.Kphix     =  zeros(ndof_phi,ndof_x);
element_assembly.Kphiq     =  zeros(ndof_phi,ndof_q);

