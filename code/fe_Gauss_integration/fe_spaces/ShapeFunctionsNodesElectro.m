%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Shape functions.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function str                             =  ShapeFunctionsNodesElectro(str)

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
