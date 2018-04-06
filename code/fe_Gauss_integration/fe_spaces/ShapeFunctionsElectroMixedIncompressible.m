%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Shape functions.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function str                                =  ShapeFunctionsElectroMixedIncompressible(str)

dim                                         =  str.geometry.dim;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Shape functions for x.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% 3D shape functions
%--------------------------------------------------------------------------
[N,DN_chi]                                  =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,dim,str.quadrature.volume.bilinear);
str.fem.volume.bilinear.x.N                 =  N;
str.fem.volume.bilinear.x.DN_chi            =  DN_chi;
str.fem.volume.bilinear.x.N_vectorised      =  VectorisationShapeFunctions(str.fem.volume.bilinear.x.N,dim);
%--------------------------------------------------------------------------
% 3D shape functions for mass matrices
%--------------------------------------------------------------------------
[N,DN_chi]                                  =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,dim,str.quadrature.volume.mass);
str.fem.volume.mass.x.N                     =  N;
str.fem.volume.mass.x.DN_chi                =  DN_chi;
%--------------------------------------------------------------------------
% 2D shape functions
%--------------------------------------------------------------------------
[N,DN_chi]                                  =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,dim-1,str.quadrature.surface.bilinear);
str.fem.surface.bilinear.x.N                =  N;
str.fem.surface.bilinear.x.DN_chi           =  DN_chi;
str.fem.volume.surface.x.N_vectorised       =  VectorisationShapeFunctions(str.fem.surface.bilinear.x.N,dim);
%--------------------------------------------------------------------------
% Shape functions for contact (2D shape functions).
%--------------------------------------------------------------------------
[N,DN_chi]                                  =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,dim-1,str.quadrature.surface.contact);
str.fem.surface.contact.x.N                 =  N;
str.fem.surface.contact.x.DN_chi            =  DN_chi;
%--------------------------------------------------------------------------
% 2D shape functions for mass matrices
%--------------------------------------------------------------------------
[N,DN_chi]                                  =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,dim-1,str.quadrature.surface.mass);
str.fem.surface.mass.x.N                    =  N;
str.fem.surface.mass.x.DN_chi               =  DN_chi;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Shape functions for electric potential.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% 3D shape functions
%--------------------------------------------------------------------------
[N,DN_chi]                                  =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.phi,dim,str.quadrature.volume.bilinear);
str.fem.volume.bilinear.phi.N               =  N;
str.fem.volume.bilinear.phi.DN_chi          =  DN_chi;
%--------------------------------------------------------------------------
% 3D shape functions for mass matrices
%--------------------------------------------------------------------------
[N,DN_chi]                                  =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,dim,str.quadrature.volume.mass);
str.fem.volume.mass.phi.N                   =  N;
str.fem.volume.mass.phi.DN_chi              =  DN_chi;
%--------------------------------------------------------------------------
% 2D shape functions
%--------------------------------------------------------------------------
[N,DN_chi]                                  =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.phi,dim-1,str.quadrature.surface.bilinear);
str.fem.surface.bilinear.phi.N              =  N;
str.fem.surface.bilinear.phi.DN_chi         =  DN_chi;
%--------------------------------------------------------------------------
% Shape functions for contact (2D shape functions).
%--------------------------------------------------------------------------
[N,DN_chi]                                  =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.phi,dim-1,str.quadrature.surface.contact);
str.fem.surface.contact.phi.N               =  N;
str.fem.surface.contact.phi.DN_chi          =  DN_chi;
%--------------------------------------------------------------------------
% 2D shape functions for mass matrices
%--------------------------------------------------------------------------
[N,DN_chi]                                  =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.phi,dim-1,str.quadrature.surface.mass);
str.fem.surface.mass.phi.N                  =  N;
str.fem.surface.mass.phi.DN_chi             =  DN_chi;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Shape functions for pressure field (3D shape functions).
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
[N,DN_chi]                                  =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.pressure,dim,str.quadrature.volume.bilinear);
str.fem.volume.bilinear.pressure.N          =  N;
str.fem.volume.bilinear.pressure.DN_chi     =  DN_chi;
%--------------------------------------------------------------------------
% Shape functions for pressure field (3D shape functions) for mass matrices.
%--------------------------------------------------------------------------
[N,DN_chi]                                  =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.pressure,dim,str.quadrature.volume.mass);
str.fem.volume.mass.pressure.N              =  N;
str.fem.volume.mass.pressure.DN_chi         =  DN_chi;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Shape functions for mixed variables.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
[N,DN_chi]                                  =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.F,dim,str.quadrature.volume.bilinear);
str.fem.volume.bilinear.F.N                 =  N;
str.fem.volume.bilinear.F.DN_chi            =  DN_chi;
str.fem.volume.bilinear.F.N_vectorised      =  VectorisationShapeFunctions(str.fem.volume.bilinear.F.N,dim^2);

[N,DN_chi]                                  =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.H,dim,str.quadrature.volume.bilinear);
str.fem.volume.bilinear.H.N                 =  N;
str.fem.volume.bilinear.H.DN_chi            =  DN_chi;
str.fem.volume.bilinear.H.N_vectorised      =  VectorisationShapeFunctions(str.fem.volume.bilinear.H.N,dim^2);

[N,DN_chi]                                  =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.J,dim,str.quadrature.volume.bilinear);
str.fem.volume.bilinear.J.N                 =  N;
str.fem.volume.bilinear.J.DN_chi            =  DN_chi;

[N,DN_chi]                                  =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.D0,dim,str.quadrature.volume.bilinear);
str.fem.volume.bilinear.D0.N                =  N;
str.fem.volume.bilinear.D0.DN_chi           =  DN_chi;
str.fem.volume.bilinear.D0.N_vectorised     =  VectorisationShapeFunctions(str.fem.volume.bilinear.D0.N,dim);

[N,DN_chi]                                  =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.d,dim,str.quadrature.volume.bilinear);
str.fem.volume.bilinear.d.N                 =  N;
str.fem.volume.bilinear.d.DN_chi            =  DN_chi;
str.fem.volume.bilinear.d.N_vectorised      =  VectorisationShapeFunctions(str.fem.volume.bilinear.d.N,dim);

end
