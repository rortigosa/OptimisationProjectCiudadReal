%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Shape functions.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function str                             =  ShapeFunctionsNodesElectroMixedIncompressible(str)

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
% Shape functions for F in the nodes. 
%--------------------------------------------------------------------------
iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.F,str.geometry.dim);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.F,str.geometry.dim,new_str.quadrature);
str.fem.volume.nodes.F.N                 =  N;
str.fem.volume.nodes.F.DN_chi            =  DN_chi;

iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.F,str.geometry.dim-1);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.F,str.geometry.dim-1,new_str.quadrature);
str.fem.surface.nodes.F.N                =  N;
str.fem.surface.nodes.F.DN_chi           =  DN_chi;
%--------------------------------------------------------------------------
% Shape functions for H in the nodes. 
%--------------------------------------------------------------------------
iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.H,str.geometry.dim);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.H,str.geometry.dim,new_str.quadrature);
str.fem.volume.nodes.H.N                 =  N;
str.fem.volume.nodes.H.DN_chi            =  DN_chi;

iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.H,str.geometry.dim-1);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.H,str.geometry.dim-1,new_str.quadrature);
str.fem.surface.nodes.H.N                =  N;
str.fem.surface.nodes.H.DN_chi           =  DN_chi;
%--------------------------------------------------------------------------
% Shape functions for J in the nodes. 
%--------------------------------------------------------------------------
iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.J,str.geometry.dim);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.J,str.geometry.dim,new_str.quadrature);
str.fem.volume.nodes.J.N                 =  N;
str.fem.volume.nodes.J.DN_chi            =  DN_chi;

iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.J,str.geometry.dim-1);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.J,str.geometry.dim-1,new_str.quadrature);
str.fem.surface.nodes.J.N                =  N;
str.fem.surface.nodes.J.DN_chi           =  DN_chi;
%--------------------------------------------------------------------------
% Shape functions for D0 in the nodes. 
%--------------------------------------------------------------------------
iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.D0,str.geometry.dim);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.D0,str.geometry.dim,new_str.quadrature);
str.fem.volume.nodes.D0.N                =  N;
str.fem.volume.nodes.D0.DN_chi           =  DN_chi;

iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.D0,str.geometry.dim-1);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.D0,str.geometry.dim-1,new_str.quadrature);
str.fem.surface.nodes.D0.N               =  N;
str.fem.surface.nodes.D0.DN_chi          =  DN_chi;
%--------------------------------------------------------------------------
% Shape functions for d in the nodes. 
%--------------------------------------------------------------------------
iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.d,str.geometry.dim);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.d,str.geometry.dim,new_str.quadrature);
str.fem.volume.nodes.d.N                 =  N;
str.fem.volume.nodes.d.DN_chi            =  DN_chi;

iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.d,str.geometry.dim-1);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.d,str.geometry.dim-1,new_str.quadrature);
str.fem.surface.nodes.d.N                =  N;
str.fem.surface.nodes.d.DN_chi           =  DN_chi;
