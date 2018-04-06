function str                            =  MeshElectroMixedIncompressible(str)

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
%--------------------------------------------------------------------------
% Mesh for F
%--------------------------------------------------------------------------
[nodes,connectivity]                   =  MeshGenerator(str,str.fem.degree.F,str.fem.degree.F_continuity,str.fem.surface.nodes.F.DN_chi);
str.mesh.volume.F.nodes                =  nodes;
str.mesh.volume.F.connectivity         =  connectivity;
str.mesh.volume.F.n_nodes              =  size(nodes,2);
str.mesh.volume.F.n_node_elem          =  size(connectivity,1);
%--------------------------------------------------------------------------
% Mesh for H
%--------------------------------------------------------------------------
[nodes,connectivity]                   =  MeshGenerator(str,str.fem.degree.H,str.fem.degree.H_continuity,str.fem.surface.nodes.H.DN_chi);
str.mesh.volume.H.nodes                =  nodes;
str.mesh.volume.H.connectivity         =  connectivity;
str.mesh.volume.H.n_nodes              =  size(nodes,2);
str.mesh.volume.H.n_node_elem          =  size(connectivity,1);
%--------------------------------------------------------------------------
% Mesh for J
%--------------------------------------------------------------------------
[nodes,connectivity]                   =  MeshGenerator(str,str.fem.degree.J,str.fem.degree.J_continuity,str.fem.surface.nodes.J.DN_chi);
str.mesh.volume.J.nodes                =  nodes;
str.mesh.volume.J.connectivity         =  connectivity;
str.mesh.volume.J.n_nodes              =  size(nodes,2);
str.mesh.volume.J.n_node_elem          =  size(connectivity,1);
%--------------------------------------------------------------------------
% Mesh for D0
%--------------------------------------------------------------------------
[nodes,connectivity]                   =  MeshGenerator(str,str.fem.degree.D0,str.fem.degree.D0_continuity,str.fem.surface.nodes.D0.DN_chi);
str.mesh.volume.D0.nodes               =  nodes;
str.mesh.volume.D0.connectivity        =  connectivity;
str.mesh.volume.D0.n_nodes             =  size(nodes,2);
str.mesh.volume.D0.n_node_elem         =  size(connectivity,1);
%--------------------------------------------------------------------------
% Mesh for d
%--------------------------------------------------------------------------
[nodes,connectivity]                   =  MeshGenerator(str,str.fem.degree.d,str.fem.degree.d_continuity,str.fem.surface.nodes.d.DN_chi);
str.mesh.volume.d.nodes                =  nodes;
str.mesh.volume.d.connectivity         =  connectivity;
str.mesh.volume.d.n_nodes              =  size(nodes,2);
str.mesh.volume.d.n_node_elem          =  size(connectivity,1);
