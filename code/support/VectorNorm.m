%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the norm of a vector at each Gauss point: the
% vector is in reality a matrix, where in the columns we store the vector
% associated with each of the Gauss points
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function vector_norm     =  VectorNorm(vector)

n_gauss                  =  size(vector,2);
vector_norm              =  zeros(n_gauss,1);
for igauss=1:n_gauss
    vector_norm(igauss)  =  norm(vector(:,igauss));
end
