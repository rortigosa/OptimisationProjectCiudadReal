function str                            =  MeshCGC(str)

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
% Mesh for F
%--------------------------------------------------------------------------
[nodes,connectivity]                   =  MeshGenerator(str,str.fem.degree.C,str.fem.degree.C_continuity,str.fem.surface.nodes.C.DN_chi);
str.mesh.volume.C.nodes                =  nodes;
str.mesh.volume.C.connectivity         =  connectivity;
str.mesh.volume.C.n_nodes              =  size(nodes,2);
str.mesh.volume.C.n_node_elem          =  size(connectivity,1);
%--------------------------------------------------------------------------
% Mesh for H
%--------------------------------------------------------------------------
[nodes,connectivity]                   =  MeshGenerator(str,str.fem.degree.G,str.fem.degree.G_continuity,str.fem.surface.nodes.G.DN_chi);
str.mesh.volume.G.nodes                =  nodes;
str.mesh.volume.G.connectivity         =  connectivity;
str.mesh.volume.G.n_nodes              =  size(nodes,2);
str.mesh.volume.G.n_node_elem          =  size(connectivity,1);
%--------------------------------------------------------------------------
% Mesh for J
%--------------------------------------------------------------------------
[nodes,connectivity]                   =  MeshGenerator(str,str.fem.degree.c,str.fem.degree.c_continuity,str.fem.surface.nodes.c.DN_chi);
str.mesh.volume.c.nodes                =  nodes;
str.mesh.volume.c.connectivity         =  connectivity;
str.mesh.volume.c.n_nodes              =  size(nodes,2);
str.mesh.volume.c.n_node_elem          =  size(connectivity,1);
