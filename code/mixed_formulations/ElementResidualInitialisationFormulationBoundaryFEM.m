function str                            =  ElementResidualInitialisationFormulationBoundaryFEM(gem,mesh)

ndof_x                                  =  geom.dim*mesh.volume.x.n_node_elem;
ndof_phi                                =  mesh.volume.phi.n_node_elem;
ndof_q0                                 =  mesh.surface.q0.n_node_elem;
%--------------------------------------------------------------------------
% Residual vectors per element
%--------------------------------------------------------------------------
str.assembly.element_assembly.Tx        =  zeros(ndof_x,1);
str.assembly.element_assembly.Tphi      =  zeros(ndof_phi,1);  
%--------------------------------------------------------------------------
% Stiffness matrices per element
%--------------------------------------------------------------------------
str.assembly.element_assembly.Kxx       =  zeros(ndof_x,ndof_x);
str.assembly.element_assembly.Kxphi     =  zeros(ndof_x,ndof_phi);
str.assembly.element_assembly.Kxq0      =  zeros(ndof_x,ndof_q0);

str.assembly.element_assembly.Kphix     =  zeros(ndof_phi,ndof_x);
str.assembly.element_assembly.Kphiphi   =  zeros(ndof_phi,ndof_phi);
str.assembly.element_assembly.Kphiq0    =  zeros(ndof_phi,ndof_q0);

