function element_assembly    =  ElementResidualInitialisationFormulationBoundaryBEM(dim,mesh)

ndof_x                       =  dim*size(mesh.surface.x.boundary_edges,1);
ndof_phi                     =  size(mesh.surface.phi.boundary_edges,1);
ndof_q                       =  mesh.surface.q.n_node_elem;
%--------------------------------------------------------------------------
% Residual vectors per element
%--------------------------------------------------------------------------
element_assembly.Tq          =  zeros(1,1);  
%--------------------------------------------------------------------------
% Stiffness matrices per element
%--------------------------------------------------------------------------
element_assembly.Kqx         =  zeros(1,ndof_x);
element_assembly.Kqphi       =  zeros(1,ndof_phi);
element_assembly.Kqq         =  zeros(1,ndof_q);
element_assembly.Kqphiprime  =  zeros(1,ndof_phi);
