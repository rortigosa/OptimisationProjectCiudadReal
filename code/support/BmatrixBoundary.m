

function Bmatrix         =  BmatrixBoundary(E,Finv,LHS_indices,RHS_indices)


n_gauss                  =  size(E,2);
dim                      =  size(E,1);

Ematrix                  =  zeros(dim^2,dim^2,n_gauss);
Ematrix(LHS_indices)     =  E(RHS_indices);
Amatrix                  =  repmat(Finv,dim,1,1);
Bmatrix                  =  zeros(dim^2,dim,n_gauss);

for igauss=1:n_gauss
    Bmatrix(:,:,igauss)  =  Ematrix(:,:,igauss)*Amatrix(:,:,igauss);    
end