%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Shape functions.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function str                             =  ShapeFunctionsNodesUP(str)

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
