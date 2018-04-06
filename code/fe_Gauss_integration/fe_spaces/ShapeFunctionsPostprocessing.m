function [N,DN_chi]  =  ShapeFunctionsPostprocessing(dim)

switch dim
    case 2
         load(['Quad_NodeShapeFunctions_Q' num2str(1) '.mat']);
    case 3
         load(['Hexa_NodeShapeFunctions_Q' num2str(1) '.mat']);        
end
