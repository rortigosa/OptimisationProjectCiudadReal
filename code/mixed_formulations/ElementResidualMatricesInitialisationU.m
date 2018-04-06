
function element_assembly  =  ElementResidualMatricesInitialisationU(geom,mesh)

ndof_x                     =  geom.dim*mesh.volume.x.n_node_elem;
%--------------------------------------------------------------------------
% Residual vectors per element
%--------------------------------------------------------------------------
element_assembly.Tx        =  zeros(ndof_x,1);
%--------------------------------------------------------------------------
% Stiffness matrices per element
%--------------------------------------------------------------------------
element_assembly.Kxx       =  zeros(ndof_x,ndof_x);
