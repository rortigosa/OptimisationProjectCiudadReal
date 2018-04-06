dim           =  2;
n_node_elem   =  4;
ngauss        =  4;
geometry.dim  =  dim;
F             =  rand(dim,dim,ngauss);
H             =  rand(dim,dim,ngauss);
J             =  rand(ngauss,1);
SigmaH        =  H;

DNX   =  rand(dim,n_node_elem,ngauss);
fem.volume.bilinear.x.DN_X  =  DNX;


N  = 1e4;
tic 
for i=1:N
%--------------------------------------------------------------------------
% Bmatrix in MatLab
%--------------------------------------------------------------------------
BF   =  BMatrix(ngauss,geometry.dim,str.mesh.volume.x.n_node_elem,...
                fem.volume.bilinear.x.DN_X,...
                str.vectorisation.Bx_matrix.LHS_indices,...
                str.vectorisation.Bx_matrix.RHS_indices);
QF                 =  QMatrixComputation(F,dim,ngauss);
QSigmaH            =  QMatrixComputation(F,dim,ngauss);    
if dim==2
   QSigmaH         =  QSigmaH*0;
end
BH  =  zeros(dim*dim,dim*n_node_elem,ngauss);
BSigmaH  =  zeros(dim*dim,dim*n_node_elem,ngauss);
BJ       =  zeros(1,dim*n_node_elem,ngauss);
for igauss=1:ngauss
    BH(:,:,igauss)   =  QF(:,:,igauss)*BF(:,:,igauss);
    BSigmaH(:,:,igauss)  =  QSigmaH(:,:,igauss)*BF(:,:,igauss);
    BJ(:,:,igauss)  =  (reshape(H(:,:,igauss)',dim^2,1))'*BF(:,:,igauss);
end

end 
toc

tic
for i=1:N
%--------------------------------------------------------------------------
% Bmatrix in C
%--------------------------------------------------------------------------
[BFC,BHC,BJC,BSHC]  =  Bmatrices(fem.volume.bilinear.x.DN_X,str.vectorisation.Bx_matrix.LHS_indices,str.vectorisation.Bx_matrix.RHS_indices,F,H,SigmaH);
end
toc

