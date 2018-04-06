

function str  =  BoundaryPreprocessingFinal(str)

 
%--------------------------------------------------------------------------
% Determine the boundary edges (boundary_edges) and what element (on the volume mesh) they
% belong to (volume_elements). Also, determination of the nodes in the boundary (boujndary_nodes)
%--------------------------------------------------------------------------
[boundary_edges,volume_elements,... 
    boundary_nodes]                   =  BoundaryElementsNodesDefinition(str.fem.degree.x,str.mesh.volume.x.connectivity,str.fem.shape,str.geometry.dim);  
str.mesh.surface.x.boundary_edges     =  boundary_edges;
str.mesh.surface.x.volume_elements    =  volume_elements;
str.mesh.surface.x.boundary_nodes     =  boundary_nodes;
%--------------------------------------------------------------------------
% Determine the boundary edges (boundary_edges) and what element (on the volume mesh) they
% belong to (volume_elements). Also, determination of the nodes in the boundary (boujndary_nodes)
%--------------------------------------------------------------------------
switch str.data.formulation
    case {'electro_mechanics','electro_mechanics_incompressible','electro_mechanics_mixed_incompressible',...
          'electro_mechanics_BEM_FEM','electro_mechanics_incompressible_BEM_FEM','electro_mechanics_mixed_incompressible_BEM_FEM',...
          'electro_mechanics_Helmholtz','electro_mechanics_Helmholtz_BEM_FEM',...
          'electro_mechanics_Helmholtz_incompressible','electro_mechanics_Helmholtz_incompressible_BEM_FEM',...
          'electro_BEM_FEM','electro'}
[boundary_edges,volume_elements,...
    boundary_nodes]                   =  BoundaryElementsNodesDefinition(str.fem.degree.phi,str.mesh.volume.phi.connectivity,str.fem.shape,str.geometry.dim);  
str.mesh.surface.phi.boundary_edges   =  boundary_edges;
str.mesh.surface.phi.volume_elements  =  volume_elements;
str.mesh.surface.phi.boundary_nodes   =  boundary_nodes;
end
%--------------------------------------------------------------------------
% Division of the boundary for contact problems
%--------------------------------------------------------------------------
str                                   =  SpecificBoundaryDivision(str);  
%--------------------------------------------------------------------------
% Definition of a surface mesh for BEM/FEM formulations
%--------------------------------------------------------------------------
switch str.data.formulation
    case {'electro_mechanics_BEM_FEM','electro_mechanics_incompressible_BEM_FEM','electro_mechanics_mixed_incompressible_BEM_FEM',...
           'electro_mechanics_Helmholtz_BEM_FEM','electro_mechanics_Helmholtz_incompressible_BEM_FEM',...
           'electro_BEM_FEM'}
        switch  str.fem.degree.q
            case 0
                 boundary_nodes                           =  ConstantInterpolationSurfaceMeshing(str.geometry.dim,str.mesh.surface.phi.boundary_edges,...
                                                                                                 str.mesh.volume.phi.nodes);         
                 str.mesh.surface.q.nodes                 =  boundary_nodes;
                 str.mesh.surface.q.connectivity          =  1:length(boundary_nodes);
                 str.mesh.surface.q.n_nodes               =  size(str.mesh.surface.q.nodes,2);
                 str.mesh.surface.q.n_node_elem           =  size(str.mesh.surface.q.connectivity,1);
            otherwise
                 [boundary_edges,volume_elements,... 
                  boundary_nodes]                         =  BoundaryElementsNodesDefinition(str.fem.degree.q,str.mesh.volume.q.connectivity,str.fem.shape,str.geometry.dim);         
                  new_nodes                               =  zeros(max(boundary_nodes),1);
                  new_nodes(boundary_nodes)               =  (1:length(boundary_nodes));
                  boundary_edges                          =  new_nodes(boundary_edges);
                  switch str.fem.surface.BEM_FEM.continuity
                      case 0
                          q_nodes_continuous               =  str.mesh.volume.q.nodes;
                          q_connectivity_continuous        =  boundary_edges;
                          [nodes,connectivity]             =  DiscontinuousMeshing(q_nodes_continuous,q_connectivity_continuous);
                          str.mesh.surface.q.nodes         =  nodes;
                          str.mesh.surface.q.connectivity  =  connectivity;
                          str.mesh.surface.q.n_nodes       =  size(str.mesh.surface.q.nodes,2);
                          str.mesh.surface.q.n_node_elem   =  size(str.mesh.surface.q.connectivity,1);
                      case 1
                          str.mesh.surface.q.nodes         =  str.mesh.volume.q.nodes(:,boundary_nodes);
                          str.mesh.surface.q.connectivity  =  boundary_edges;
                          str.mesh.surface.q.n_nodes       =  size(str.mesh.surface.q.nodes,2);
                          str.mesh.surface.q.n_node_elem   =  size(str.mesh.surface.q.connectivity,1);
                  end
        end
end



