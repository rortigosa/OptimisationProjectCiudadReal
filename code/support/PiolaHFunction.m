%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  For a convex definition of the internal energy in terms of F H and J,
%  this function computes the contribution of the H term in the definition
%  of the first Piola-Kirchhoff stress tensor for 2D and 3D
%
%  PiolaH  =  Cof(SigmaH)  (in 2D)
%  PiolaH  =  SigmaH x F   (in 3D) 
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function PiolaH     =  PiolaHFunction(dim,ngauss,SigmaH,F)

PiolaH              =  zeros(dim,dim,ngauss);
switch dim
    case 2
         for igauss=1:ngauss
             PiolaH(:,:,igauss)  =  Cofactor(SigmaH(:,:,igauss),dim);
         end
    case 3
        for igauss=1:ngauss
            PiolaH(:,:,igauss)  =  JavierDoubleCrossProduct(SigmaH(:,:,igauss),F(:,:,igauss));
        end
end