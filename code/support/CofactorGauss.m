%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Compute the cofactor for all the Gauss points of an element
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Cof          =  CofactorGauss(dim,ngauss,C)

Cof                   =  zeros(dim,dim,ngauss);
for igauss=1:ngauss
    Cof(:,:,igauss)   =  Cofactor(C(:,:,igauss),dim);
end
