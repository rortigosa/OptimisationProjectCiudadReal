%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Types of shape functions: volume and surface
% Within, we can find: 
%
%  volume---->  bilinear, mass
%  surface--->  bilinear, mass, contact
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function  FEM      =  ShapeFunctionsFormulation(FEM,Quadrature,dim,formulation)

switch formulation
    case 'u'
          FEM      =  ShapeFunctionsU(FEM,Quadrature,dim);
    case 'up'
          %str      =  ShapeFunctionsUP(str);
end
