function [Kindexi,Kindexj,Kdata,...
Tindexi,Tindexj,Tdata]    =  SparseStiffnessPreallocation(geom,mesh,formulation)

switch formulation
    case {'u','FHJ','CGC','CGCCascade'}
         n_dofs_elem_x    =  geom.dim*size(mesh.volume.x.connectivity,1);         
         total_dofs       =  n_dofs_elem_x;

         n_dofs_Kxx       =  n_dofs_elem_x*n_dofs_elem_x;
         n_dofs_elem      =  n_dofs_Kxx;
    case 'up'         
         n_dofs_elem_x    =  geom.dim*size(mesh.volume.x.connectivity,1);
         n_dofs_elem_p    =  size(mesh.volume.pressure.connectivity,1);
         total_dofs       =  n_dofs_elem_x + n_dofs_elem_p;
         
         n_dofs_Kxx       =  n_dofs_elem_x*n_dofs_elem_x;
         n_dofs_Kxp       =  n_dofs_elem_x*n_dofs_elem_p;
         n_dofs_Kpx       =  n_dofs_elem_p*n_dofs_elem_x;         
         n_dofs_Kpp       =  n_dofs_elem_p*n_dofs_elem_p;         
         n_dofs_elem      =  n_dofs_Kxx + n_dofs_Kxp + n_dofs_Kpx + n_dofs_Kpp;         
    case {'electro_mechanics','electro_mechanics_BEM',...
          'electro_mechanics_Helmholtz','electro_mechanics_Helmholtz_BEM_FEM'}
         n_dofs_elem_x    =  geom.dim*size(mesh.volume.x.connectivity,1);
         n_dofs_elem_phi  =  size(mesh.volume.phi.connectivity,1);
         total_dofs       =  n_dofs_elem_x + n_dofs_elem_phi;
         
         n_dofs_Kxx       =  n_dofs_elem_x*n_dofs_elem_x;
         n_dofs_Kxphi     =  n_dofs_elem_x*n_dofs_elem_phi;
         n_dofs_Kphix     =  n_dofs_elem_phi*n_dofs_elem_x;
         n_dofs_Kphiphi   =  n_dofs_elem_phi*n_dofs_elem_phi;         
         n_dofs_elem      =  n_dofs_Kxx + n_dofs_Kxphi + n_dofs_Kphix + n_dofs_Kphiphi;
    case {'electro_mechanics_incompressible','electro_mechanics_mixed_incompressible',...
          'electro_mechanics_incompressible_BEM_FEM','electro_mechanics_mixed_incompressible_BEM_FEM',...
          'electro_mechanics_Helmholtz_incompressible','electro_mechanics_Helmholtz_incompressible_BEM_FEM'}
         n_dofs_elem_x    =  geom.dim*size(mesh.volume.x.connectivity,1);
         n_dofs_elem_phi  =  size(mesh.volume.phi.connectivity,1);
         n_dofs_elem_p    =  size(mesh.volume.pressure.connectivity,1);
         total_dofs       =  n_dofs_elem_x + n_dofs_elem_phi + n_dofs_elem_p;

         n_dofs_Kxx       =  n_dofs_elem_x*n_dofs_elem_x;
         n_dofs_Kxphi     =  n_dofs_elem_x*n_dofs_elem_phi;
         n_dofs_Kxp       =  n_dofs_elem_x*n_dofs_elem_p;
         n_dofs_Kphix     =  n_dofs_elem_phi*n_dofs_elem_x;
         n_dofs_Kphiphi   =  n_dofs_elem_phi*n_dofs_elem_phi;
         n_dofs_Kpx       =  n_dofs_elem_p*n_dofs_elem_x;         
         n_dofs_Kpp       =  n_dofs_elem_p*n_dofs_elem_p;                  
         n_dofs_elem      =  n_dofs_Kxx + n_dofs_Kxphi + n_dofs_Kxp + n_dofs_Kphix + n_dofs_Kphiphi + n_dofs_Kpx + n_dofs_Kpp;
    case {'electro_BEM_FEM','electro'}
         n_dofs_elem_phi  =  size(mesh.volume.phi.connectivity,1);
         total_dofs       =  n_dofs_elem_phi;
         
         n_dofs_Kphiphi   =  n_dofs_elem_phi*n_dofs_elem_phi;
         n_dofs_elem      =  n_dofs_Kphiphi;
end

Kindexi                   =  zeros(n_dofs_elem,mesh.volume.n_elem);
Kindexj                   =  zeros(n_dofs_elem,mesh.volume.n_elem);
Kdata                     =  zeros(n_dofs_elem,mesh.volume.n_elem);
Tindexi                   =  zeros(total_dofs,mesh.volume.n_elem);
Tindexj                   =  zeros(total_dofs,mesh.volume.n_elem);
Tdata                     =  zeros(total_dofs,mesh.volume.n_elem);

