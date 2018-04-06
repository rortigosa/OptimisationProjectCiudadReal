
function element_assembly  =  ElementResidualMatricesInitialisationUP(geom,mesh)

ndof_x                     =  geom.dim*mesh.volume.x.n_node_elem;
ndof_p                     =  mesh.volume.pressure.n_node_elem;
%--------------------------------------------------------------------------
% Residual vectors per element
%--------------------------------------------------------------------------
element_assembly.Tx        =  zeros(ndof_x,1);
element_assembly.Tp        =  zeros(ndof_p,1);  
%--------------------------------------------------------------------------
% Stiffness matrices per element
%--------------------------------------------------------------------------
element_assembly.Kxx       =  zeros(ndof_x,ndof_x);
element_assembly.Kxp       =  zeros(ndof_x,ndof_p);

element_assembly.Kpx       =  zeros(ndof_p,ndof_x);
element_assembly.Kpp       =  zeros(ndof_p,ndof_p);

