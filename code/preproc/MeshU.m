function Mesh                           =  MeshU(FEM,Geometry)

%--------------------------------------------------------------------------
% Mesh for x
%--------------------------------------------------------------------------
[nodes,connectivity]               =  MeshGenerator(FEM.degree.x,Geometry,'continuous');
Mesh.volume.n_elem                 =  size(connectivity,2);
Mesh.volume.x.nodes                =  nodes;
Mesh.volume.x.connectivity         =  connectivity;
Mesh.volume.x.n_nodes              =  size(nodes,2);
Mesh.volume.x.n_node_elem          =  size(connectivity,1);
