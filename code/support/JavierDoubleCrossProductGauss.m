%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function computes the double cross product beteen two matrices A
%  and B for every Gauss point
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function C         =   JavierDoubleCrossProductGauss(dim,ngauss,A,B)

C                  =  zeros(dim,dim,ngauss);
for igauss=1:ngauss
    C(:,:,igauss)  =  JavierDoubleCrossProduct(A,B);   
end