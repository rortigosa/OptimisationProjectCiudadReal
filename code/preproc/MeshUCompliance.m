function str                           =  MeshUCompliance(str)

%--------------------------------------------------------------------------
% Mesh for x
%--------------------------------------------------------------------------
[nodes,connectivity]                   =  MeshGenerator(str,str.fem.degree.x,'continuous',str.fem.surface.nodes.x.DN_chi);
str.mesh.volume.n_elem                 =  size(connectivity,2);
str.mesh.volume.x.nodes                =  nodes;
str.mesh.volume.x.connectivity         =  connectivity;
str.mesh.volume.x.n_nodes              =  size(nodes,2);
str.mesh.volume.x.n_node_elem          =  size(connectivity,1);
