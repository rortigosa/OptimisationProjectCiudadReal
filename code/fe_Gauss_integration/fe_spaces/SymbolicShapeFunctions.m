%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Symbolic shape functions for tets and hexas (3D) and triangles and quads
%  (2D)
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [symbN,symbDN_chi]   =  SymbolicShapeFunctions(shape,degree,dimension)

switch shape
    case 1
         [symbN,symbDN_chi]   =  SymbolicShapeFunctionsQuadsHexas(degree,dimension);  
    case 0
         [symbN,symbDN_chi]   =  SymbolicShapeFunctionsTrisTets(degree,dimension);  
end

