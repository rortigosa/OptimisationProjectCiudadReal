function element_assembly  =  ElementResidualMatricesInitialisationElectro(geom,mesh)

ndof_x                     =  geom.dim*mesh.volume.x.n_node_elem;
ndof_phi                   =  mesh.volume.phi.n_node_elem;
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

element_assembly.Kphix     =  zeros(ndof_phi,ndof_x);
element_assembly.Kphiphi   =  zeros(ndof_phi,ndof_phi);
