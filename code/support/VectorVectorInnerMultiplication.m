%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Compute the dot product between two vectors
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function scalar      =  VectorVectorInnerMultiplication(n_gauss,V1,V2)

scalar               =  zeros(n_gauss,1);
for igauss=1:n_gauss
    scalar(igauss)   =  V1(:,igauss)'*V2(:,igauss);
end


