function str                           =  MeshUP(str,geometry)

%--------------------------------------------------------------------------
% Mesh for x
%--------------------------------------------------------------------------
[nodes,connectivity]                   =  MeshGenerator(str.fem.degree.x,geometry,'continuous');
str.mesh.volume.n_elem                 =  size(connectivity,2);
str.mesh.volume.x.nodes                =  nodes;
str.mesh.volume.x.connectivity         =  connectivity;
str.mesh.volume.x.n_nodes              =  size(nodes,2);
str.mesh.volume.x.n_node_elem          =  size(connectivity,1);
%--------------------------------------------------------------------------
% Mesh for pressure field
%--------------------------------------------------------------------------
[nodes,connectivity]                   =  MeshGenerator(str.fem.degree.pressure,geometry,'continuous');
str.mesh.volume.pressure.nodes         =  nodes;
str.mesh.volume.pressure.connectivity  =  connectivity;
str.mesh.volume.pressure.n_nodes       =  size(nodes,2);
str.mesh.volume.pressure.n_node_elem   =  size(connectivity,1);
