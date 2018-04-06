p       =  1;
dim     =  2;
ngauss  =  (p+1)^3;
n_node_elem  =  (p+1)^3;
SigmaF=rand(dim,dim,ngauss);
SigmaH=rand(dim,dim,ngauss);
SigmaJ=rand(ngauss,1);
F=rand(dim,dim,ngauss);
H=rand(dim,dim,ngauss);
BF  =  rand(dim^2,dim*n_node_elem,ngauss);
WFF         =  rand(dim*dim,dim*dim,ngauss);
IntWeight  =  rand(ngauss,1);


N      =  1e4;
%--------------------------------------------------------------------------
% C without structures
%--------------------------------------------------------------------------
tic
for i=1:N
BDB    =  checkBDBmatmul_function(dim,ngauss,n_node_elem,BF,WFF,IntWeight);
end
toc
%--------------------------------------------------------------------------
% MatLab without structures
%--------------------------------------------------------------------------
tic
for i=1:N
K  =  BDBMatlabcheck(dim,ngauss,n_node_elem,BF,WFF,IntWeight);
end
toc 
%--------------------------------------------------------------------------
% C with structures 
%--------------------------------------------------------------------------
D2U.WFF  =  WFF;
str.geometry.dim  =  dim;
str.quadrature.volume.bilinear.W_v  =  rand(ngauss,1);
str.mesh.volume.x.n_node_elem  =  n_node_elem;
tic
for i=1:N
BDB    =  checkBDBmatmul_function(str.geometry.dim,size(str.quadrature.volume.bilinear.W_v,1),str.mesh.volume.x.n_node_elem,BF,D2U.WFF,str.quadrature.volume.bilinear.W_v);
end
toc
%--------------------------------------------------------------------------
% MatLab with structures calling the function
%--------------------------------------------------------------------------
tic
for i=1:N
K  =  BDBMatlabcheck(str.geometry.dim,size(str.quadrature.volume.bilinear.W_v,1),str.mesh.volume.x.n_node_elem,BF,D2U.WFF,str.quadrature.volume.bilinear.W_v);
end
toc

