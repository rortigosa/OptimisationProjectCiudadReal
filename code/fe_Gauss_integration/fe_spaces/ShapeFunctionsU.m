%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Shape functions.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function FEM                           =  ShapeFunctionsU(FEM,Quadrature,dim)


switch dim
    case 2
         %-----------------------------------------------------------------
         % Shape functions for displacements in the volume
         %-----------------------------------------------------------------
         load(['Quad_QuadRule_' num2str(Quadrature.degree) '_Q' num2str(FEM.degree.x)]);
         FEM.volume.bilinear.x.N       =  N;
         FEM.volume.bilinear.x.DN_chi  =  DN_chi;
    case 3
         %-----------------------------------------------------------------
         % Shape functions for displacements for in the mid-plane
         %-----------------------------------------------------------------
         load(['Hexa_QuadRule_' num2str(Quadrature.degree) '_Q' num2str(FEM.degree.x)]);
         FEM.volume.bilinear.x.N       =  N;
         FEM.volume.bilinear.x.DN_chi  =  DN_chi;
end
FEM.volume.bilinear.x.N_vectorised     =  VectorisationShapeFunctions(FEM.volume.bilinear.x.N,dim);
