%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Shape functions.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function str                             =  ShapeFunctionsNodesCGC(str)

%--------------------------------------------------------------------------
% Shape functions for x0 in the nodes. 
%--------------------------------------------------------------------------
iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.x,str.geometry.dim);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,str.geometry.dim,new_str.quadrature);
str.fem.volume.nodes.x.N                 =  N;
str.fem.volume.nodes.x.DN_chi            =  DN_chi;

iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.x,str.geometry.dim-1);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,str.geometry.dim-1,new_str.quadrature);
str.fem.surface.nodes.x.N                =  N;
str.fem.surface.nodes.x.DN_chi           =  DN_chi;
%--------------------------------------------------------------------------
% Shape functions for phi in the nodes.
%--------------------------------------------------------------------------
iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.phi,str.geometry.dim);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.phi,str.geometry.dim,new_str.quadrature);
str.fem.volume.nodes.phi.N               =  N;
str.fem.volume.nodes.phi.DN_chi          =  DN_chi;

iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.phi,str.geometry.dim-1);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.phi,str.geometry.dim-1,new_str.quadrature);
str.fem.surface.nodes.phi.N              =  N;
str.fem.surface.nodes.phi.DN_chi         =  DN_chi;
%--------------------------------------------------------------------------
% Shape functions for pressure in the nodes.
%--------------------------------------------------------------------------
iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.pressure,str.geometry.dim);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.pressure,str.geometry.dim,new_str.quadrature);
str.fem.volume.nodes.pressure.N          =  N;
str.fem.volume.nodes.pressure.DN_chi     =  DN_chi;

iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.pressure,str.geometry.dim-1);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.pressure,str.geometry.dim-1,new_str.quadrature);
str.fem.surface.nodes.pressure.N         =  N;
str.fem.surface.nodes.pressure.DN_chi    =  DN_chi;
%--------------------------------------------------------------------------
% Shape functions for C in the nodes. 
%--------------------------------------------------------------------------
iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.C,str.geometry.dim);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.C,str.geometry.dim,new_str.quadrature);
str.fem.volume.nodes.C.N                 =  N;
str.fem.volume.nodes.C.DN_chi            =  DN_chi;

iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.C,str.geometry.dim-1);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.C,str.geometry.dim-1,new_str.quadrature);
str.fem.surface.nodes.C.N                =  N;
str.fem.surface.nodes.C.DN_chi           =  DN_chi;
%--------------------------------------------------------------------------
% Shape functions for G in the nodes. 
%--------------------------------------------------------------------------
iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.G,str.geometry.dim);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.G,str.geometry.dim,new_str.quadrature);
str.fem.volume.nodes.G.N                 =  N;
str.fem.volume.nodes.G.DN_chi            =  DN_chi;

iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.G,str.geometry.dim-1);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.G,str.geometry.dim-1,new_str.quadrature);
str.fem.surface.nodes.G.N                =  N;
str.fem.surface.nodes.G.DN_chi           =  DN_chi;
%--------------------------------------------------------------------------
% Shape functions for c in the nodes. 
%--------------------------------------------------------------------------
iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.c,str.geometry.dim);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.c,str.geometry.dim,new_str.quadrature);
str.fem.volume.nodes.c.N                 =  N;
str.fem.volume.nodes.c.DN_chi            =  DN_chi;

iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.c,str.geometry.dim-1);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.c,str.geometry.dim-1,new_str.quadrature);
str.fem.surface.nodes.c.N                =  N;
str.fem.surface.nodes.c.DN_chi           =  DN_chi;
