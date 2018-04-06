%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Create shape functions
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function FEM    =  FEMShapeFunctions(FEM,Quadrature,dim,formulation)

switch formulation
    case 'u'
          FEM      =  ShapeFunctionsU(FEM,Quadrature,dim);
    case 'up'
          %str      =  ShapeFunctionsUP(str);
end
