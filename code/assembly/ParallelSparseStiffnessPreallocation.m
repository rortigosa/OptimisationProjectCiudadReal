function sparse           =  ParallelSparseStiffnessPreallocation(geom,mesh,formulation)

switch formulation
    case {'u','FHJ','CGC'}
         n_dofs_elem_x    =  geom.dim*size(mesh.volume.x.connectivity,1);
         n_dofs_elem      =  n_dofs_elem_x^2;
         sparse           =  struct('indexi', mat2cell(zeros(mesh.volume.n_elem,n_dofs_elem),ones(mesh.volume.n_elem,1)),...
                                      'indexj', mat2cell(zeros(mesh.volume.n_elem,n_dofs_elem),ones(mesh.volume.n_elem,1)),...
                                      'data',mat2cell(zeros(mesh.volume.n_elem,n_dofs_elem),ones(mesh.volume.n_elem,1)));         
        
    case {'electro','electro_BEM'}
         n_dofs_elem_x     =  geom.dim*size(mesh.volume.x.connectivity,1);
         n_dofs_elem_phi   =  size(mesh.volume.phi.connectivity,1);
         
         n_dofs_Kxx        =  n_dofs_elem_x*n_dofs_elem_x;
         n_dofs_Kxphi      =  n_dofs_elem_x*n_dofs_elem_phi;
         n_dofs_Kphix      =  n_dofs_elem_phi*n_dofs_elem_x;
         n_dofs_Kphiphi    =  n_dofs_elem_phi*n_dofs_elem_phi;
         
         n_dofs_elem       =  n_dofs_Kxx + n_dofs_Kxphi + n_dofs_Kphix + n_dofs_Kphiphi;
         n_dofs            =  n_dofs_elem*mesh.volume.n_elem;
         indexi            =  zeros(n_dofs,1);
         indexj            =  zeros(n_dofs,1);
         data              =  zeros(n_dofs,1);
    case {'electro_incompressible','electro_mixed_incompressible',...
          'electro_incompressible_BEM_FEM','electro_mixed_incompressible_BEM_FEM'}
         %sparse           =  struct('indexi', mat2cell(zeros(mesh.volume.n_elem,n_dofs_elem),ones(mesh.volume.n_elem,1)),...
         %                             'indexj', mat2cell(zeros(mesh.volume.n_elem,n_dofs_elem),ones(mesh.volume.n_elem,1)),...
         %                             'data',mat2cell(zeros(mesh.volume.n_elem,n_dofs_elem),ones(mesh.volume.n_elem,1)));         

                                 
         
end
        
