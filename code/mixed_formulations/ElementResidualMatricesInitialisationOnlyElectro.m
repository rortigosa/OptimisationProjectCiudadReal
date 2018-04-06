function element_assembly  =  ElementResidualMatricesInitialisationOnlyElectro(mesh)

ndof_phi                   =  mesh.volume.phi.n_node_elem;
%--------------------------------------------------------------------------
% Residual vectors per element
%--------------------------------------------------------------------------
element_assembly.Tphi      =  zeros(ndof_phi,1);  
%--------------------------------------------------------------------------
% Stiffness matrices per element
%--------------------------------------------------------------------------
element_assembly.Kphiphi   =  zeros(ndof_phi,ndof_phi);
