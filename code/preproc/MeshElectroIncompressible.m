function str                           =  MeshElectroIncompressible(str)

%--------------------------------------------------------------------------
% Mesh for x
%--------------------------------------------------------------------------
[nodes,connectivity]                   =  MeshGenerator(str,str.fem.degree.x,'continuous',str.fem.surface.nodes.x.DN_chi);
str.mesh.volume.n_elem                 =  size(connectivity,2);
str.mesh.volume.x.nodes                =  nodes;
str.mesh.volume.x.connectivity         =  connectivity;
str.mesh.volume.x.n_nodes              =  size(nodes,2);
str.mesh.volume.x.n_node_elem          =  size(connectivity,1);
%--------------------------------------------------------------------------
% Mesh for phi
%--------------------------------------------------------------------------
[nodes,connectivity]                   =  MeshGenerator(str,str.fem.degree.phi,'continuous',str.fem.surface.nodes.phi.DN_chi);
str.mesh.volume.n_elem                 =  size(connectivity,2);
str.mesh.volume.phi.nodes              =  nodes;
str.mesh.volume.phi.connectivity       =  connectivity;
str.mesh.volume.phi.n_nodes            =  size(nodes,2);
str.mesh.volume.phi.n_node_elem        =  size(connectivity,1);
%--------------------------------------------------------------------------
% Mesh for pressure field
%--------------------------------------------------------------------------
[nodes,connectivity]                   =  MeshGenerator(str,str.fem.degree.pressure,'continuous',str.fem.surface.nodes.pressure.DN_chi);
str.mesh.volume.pressure.nodes         =  nodes;
str.mesh.volume.pressure.connectivity  =  connectivity;
str.mesh.volume.pressure.n_nodes       =  size(nodes,2);
str.mesh.volume.pressure.n_node_elem   =  size(connectivity,1);
