%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Compute contraction between matrices A and B for all the Gauss points
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function AB     =  MatrixMatrixContraction(ngauss,A,B)

AB              =  zeros(ngauss,1);
for igauss=1:ngauss
    AB(igauss)  =  trace(A(:,:,igauss)'*B(:,:,igauss));
end

