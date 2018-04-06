%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Compute the product between 
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function newmatrix         =  MatrixScalarMultiplication(dimi,dimj,ngauss,matrix,scalar)

newmatrix                  =  zeros(dimi,dimj,ngauss);
for igauss=1:ngauss
    newmatrix(:,:,igauss)  =  matrix(:,:,igauss)*scalar(igauss);
end


