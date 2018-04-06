%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Compute the outer product between two vectors
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function matrix          =  VectorVectorOuterMultiplication(dim,n_gauss,V1,V2)

matrix                   =  zeros(dim,dim,n_gauss);
for igauss=1:n_gauss
    matrix(:,:,igauss)   =  V1(:,igauss)*V2(:,igauss)';
end


