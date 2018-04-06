%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Shape functions.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function str                             =  ShapeFunctionsUP(str)

dim                                      =  str.geometry.dim;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Shape functions for x.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% 3D shape functions
%--------------------------------------------------------------------------
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,dim,str.quadrature.volume.bilinear);
str.fem.volume.bilinear.x.N              =  N;
str.fem.volume.bilinear.x.DN_chi         =  DN_chi;
str.fem.volume.bilinear.x.N_vectorised   =  VectorisationShapeFunctions(str.fem.volume.bilinear.x.N,dim);
%--------------------------------------------------------------------------
% 3D shape functions for mass matrices
%--------------------------------------------------------------------------
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,dim,str.quadrature.volume.mass);
str.fem.volume.mass.x.N                  =  N;
str.fem.volume.mass.x.DN_chi             =  DN_chi;
%--------------------------------------------------------------------------
% 2D shape functions
%--------------------------------------------------------------------------
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,dim-1,str.quadrature.surface.bilinear);
str.fem.surface.bilinear.x.N             =  N;
str.fem.surface.bilinear.x.DN_chi        =  DN_chi;
str.fem.surface.bilinear.x.N_vectorised  =  VectorisationShapeFunctions(str.fem.surface.bilinear.x.N,dim);
%--------------------------------------------------------------------------
% Shape functions for contact (2D shape functions).
%--------------------------------------------------------------------------
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,dim-1,str.quadrature.surface.contact);
str.fem.surface.contact.x.N              =  N;
str.fem.surface.contact.x.DN_chi         =  DN_chi;
%--------------------------------------------------------------------------
% 2D shape functions for mass matrices
%--------------------------------------------------------------------------
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,dim-1,str.quadrature.surface.mass);
str.fem.surface.mass.x.N                 =  N;
str.fem.surface.mass.x.DN_chi            =  DN_chi;
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Shape functions for pressure field (3D shape functions).
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.pressure,dim,str.quadrature.volume.bilinear);
str.fem.volume.bilinear.pressure.N       =  N;
str.fem.volume.bilinear.pressure.DN_chi  =  DN_chi;
%--------------------------------------------------------------------------
% Shape functions for pressure field (3D shape functions) for mass matrices.
%--------------------------------------------------------------------------
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.pressure,dim,str.quadrature.volume.mass);
str.fem.volume.mass.pressure.N           =  N;
str.fem.volume.mass.pressure.DN_chi      =  DN_chi;

end
