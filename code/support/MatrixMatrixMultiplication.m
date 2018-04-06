%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Compute the product between 
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function newmatrix         =  MatrixMatrixMultiplication(dimi,dimj,n_gauss,matrixA,matrixB)

newmatrix                  =  zeros(dimi,dimj,n_gauss);
for igauss=1:n_gauss
    newmatrix(:,:,igauss)  =  matrixA(:,:,igauss)*matrixB(:,:,igauss);
end


