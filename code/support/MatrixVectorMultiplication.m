%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Compute the product between 
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function newvector       =  MatrixVectorMultiplication(dim,n_gauss,matrix,vector)

newvector                =  zeros(dim,n_gauss);
for igauss=1:n_gauss
    newvector(:,igauss)  =  matrix(:,:,igauss)*vector(:,igauss);
end


