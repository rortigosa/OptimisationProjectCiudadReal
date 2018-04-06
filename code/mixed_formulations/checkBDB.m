dim=3;
ngauss=27;
n_node_elem=27;
BF =  rand(dim^2,dim*n_node_elem,ngauss);
WFF=  rand(dim^2,dim^2,ngauss);
IntWeight = rand(ngauss,1);

N  =  1e3;
tic
for i=1:N
K = BDBMatricesUFormulation(dim,ngauss,n_node_elem,BF,WFF,IntWeight);
end
toc

tic
for i=1:N
KK  =  zeros(dim*n_node_elem);
for igauss=1:ngauss
    BFT  =  BF(:,:,igauss)';
    KK  =  KK  +  BFT*WFF(:,:,igauss)*BF(:,:,igauss)*IntWeight(igauss);
end
end
toc



%check=det(F(:,:,3))*inv(F(:,:,3))' - H(:,:,3)

