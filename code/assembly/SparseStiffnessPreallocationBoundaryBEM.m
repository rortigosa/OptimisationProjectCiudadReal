function [Kindexi,Kindexj,Kdata,...
Tindexi,Tindexj,Tdata,...
BIKindexi,BIKindexj,BIKdata,...
BITindexi,BITindexj,BITdata]    =  SparseStiffnessPreallocationBoundaryBEM(dim,mesh,formulation)

n_q_nodes                       =  mesh.surface.q.n_nodes;
n_edges                         =  size(mesh.surface.x.boundary_edges,2);
switch formulation
    case {'electro_BEM_FEM'}
         n_dofs_elem_phi        =  size(mesh.surface.phi.boundary_edges,1);
         n_dofs_elem_phi_prime  =  size(mesh.surface.phi.boundary_edges,1);
         n_dofs_elem_q          =  mesh.surface.q.n_node_elem;         
         total_dofs             =  1;
         
         n_dofs_Kqphi           =  1*n_dofs_elem_phi;         
         n_dofs_Kqphiprime      =  1*n_dofs_elem_phi_prime;         
         n_dofs_Kqq             =  1*n_dofs_elem_q;         
         n_dofs_elem            =  n_dofs_Kqphi + n_dofs_Kqq + n_dofs_Kqphiprime;
    case {'electro_mechanics_BEM_FEM','electro_mechanics_Helmholtz_BEM_FEM',...
          'electro_mechanics_incompressible_BEM_FEM',...
          'electro_mechanics_Helmholtz_incompressible_BEM_FEM',...
          'electro_mechanics_mixed_incompressible_BEM_FEM'}
         n_dofs_elem_x          =  dim*size(mesh.surface.x.boundary_edges,1);
         n_dofs_elem_phi        =  size(mesh.surface.phi.boundary_edges,1);
         n_dofs_elem_phi_prime  =  size(mesh.surface.phi.boundary_edges,1);
         n_dofs_elem_q          =  mesh.surface.q.n_node_elem;
         total_dofs             =  1;
         
         n_dofs_Kqx             =  1*n_dofs_elem_x;
         n_dofs_Kqphi           =  1*n_dofs_elem_phi;         
         n_dofs_Kqphiprime      =  1*n_dofs_elem_phi_prime;         
         n_dofs_Kqq             =  1*n_dofs_elem_q;         
         n_dofs_elem            =  n_dofs_Kqx + n_dofs_Kqphi + n_dofs_Kqphiprime + n_dofs_Kqq;
end

Kindexi                         =  zeros(n_dofs_elem*n_edges,n_q_nodes);
Kindexj                         =  zeros(n_dofs_elem*n_edges,n_q_nodes);
Kdata                           =  zeros(n_dofs_elem*n_edges,n_q_nodes);
Tindexi                         =  zeros(total_dofs*n_edges,n_q_nodes);
Tindexj                         =  zeros(total_dofs*n_edges,n_q_nodes);
Tdata                           =  zeros(total_dofs*n_edges,n_q_nodes);

BIKindexi                       =  zeros(n_dofs_elem,n_edges);
BIKindexj                       =  zeros(n_dofs_elem,n_edges);
BIKdata                         =  zeros(n_dofs_elem,n_edges);
BITindexi                       =  zeros(total_dofs,n_edges);
BITindexj                       =  zeros(total_dofs,n_edges);
BITdata                         =  zeros(total_dofs,n_edges);

