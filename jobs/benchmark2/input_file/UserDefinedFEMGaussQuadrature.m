function [FEM,Quadrature]  =  UserDefinedFEMGaussQuadrature
%--------------------------------------------------------------------------
%  Finite element
%--------------------------------------------------------------------------
FEM.shape                     =  1;
FEM.degree.x                  =  1;  %  Finite Element interpolation order for displacements
FEM.degree.phi                =  1;  %  Finite Element interpolation order for displacements
FEM.degree.pressure           =  1;  % degree of interpolation for the pressure
FEM.shape                     =  1;  %  0 is triangular (or tetrahedral) and 1 is quadrilateral (or cubic)
FEM.degree.postprocessing     =  1;
%--------------------------------------------------------------------------
%  Gauss integration 
%--------------------------------------------------------------------------
Quadrature.degree             =  1;



