

function [N,DN_chi]      =  SymbolicShapeFunctionsQuadsHexas(degree,dimension)

[iso_coordinates,...
 oneD_isocoordinates]    =  IsoparametricCoordinatesQuadsHexas(degree,dimension);
[N,DN_chi]               =  SymbolicTensorisationShapeFunctions(degree,dimension,iso_coordinates,oneD_isocoordinates);

