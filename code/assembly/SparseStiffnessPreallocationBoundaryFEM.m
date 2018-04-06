function [Kindexi,Kindexj,Kdata,...
Tindexi,Tindexj,Tdata]    =  SparseStiffnessPreallocationBoundaryFEM(dim,mesh,formulation)

n_edges                   =  size(mesh.surface.x.boundary_edges,2);
switch formulation
    case {'electro_BEM_FEM'}
         n_dofs_elem_phi  =  size(mesh.surface.phi.boundary_edges,1);
         n_dofs_elem_q    =  mesh.surface.q.n_node_elem;
         total_dofs       =  n_dofs_elem_phi;
         
         n_dofs_Kphiq     =  n_dofs_elem_phi*n_dofs_elem_q;         
         n_dofs_elem      =  n_dofs_Kphiq;
    case {'electro_mechanics_BEM_FEM','electro_mechanics_Helmholtz_BEM_FEM',...
          'electro_mechanics_incompressible_BEM_FEM',...
          'electro_mechanics_Helmholtz_incompressible_BEM_FEM',...
          'electro_mechanics_mixed_incompressible_BEM_FEM'}
         n_dofs_elem_x    =  dim*size(mesh.surface.x.boundary_edges,1);
         n_dofs_elem_phi  =  size(mesh.surface.phi.boundary_edges,1);
         n_dofs_elem_q    =  mesh.surface.q.n_node_elem;
         total_dofs       =  n_dofs_elem_x + n_dofs_elem_phi;
         
         n_dofs_Kxx       =  n_dofs_elem_x*n_dofs_elem_x;
         n_dofs_Kxphi     =  n_dofs_elem_x*n_dofs_elem_phi;
         n_dofs_Kxq       =  n_dofs_elem_x*n_dofs_elem_q;
         n_dofs_Kphiq     =  n_dofs_elem_phi*n_dofs_elem_q;         
         n_dofs_elem      =  n_dofs_Kxx + n_dofs_Kxphi + n_dofs_Kxq + ...
                             n_dofs_Kphiq;
end

Kindexi                   =  zeros(n_dofs_elem,n_edges);
Kindexj                   =  zeros(n_dofs_elem,n_edges);
Kdata                     =  zeros(n_dofs_elem,n_edges);
Tindexi                   =  zeros(total_dofs,n_edges);
Tindexj                   =  zeros(total_dofs,n_edges);
Tdata                     =  zeros(total_dofs,n_edges);

