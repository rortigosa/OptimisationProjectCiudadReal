%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Compute the product between 
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function newvector         =  VectorScalarMultiplication(dim,ngauss,vector,scalar)

newvector                  =  zeros(dim,ngauss);
for igauss=1:ngauss
    newvector(:,igauss)    =  vector(:,igauss)*scalar(igauss);
end


