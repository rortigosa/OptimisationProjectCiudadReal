clear all
dim       =  2; 
ngauss    =  8;

mu1       =  10;
mu2       =  10;
e1        =  20;
inve1     =  1/e1;
kappa     =  30;

F         =  randi(10,dim,dim,ngauss);
H         =  randi(10,dim,dim,ngauss);
J         =  randi(10,ngauss,1);
E0        =  randi(10,dim,ngauss);

mat_info.derivatives.D2Psi.D2PsiDFDF    =  zeros(dim^2,dim^2,ngauss);
mat_info.derivatives.D2Psi.D2PsiDHDH    =  zeros(dim^2,dim^2,ngauss);
mat_info.derivatives.D2Psi.D2PsiDHDJ    =  zeros(dim^2,1,ngauss);
mat_info.derivatives.D2Psi.D2PsiDHDE0   =  zeros(dim^2,dim,ngauss);
mat_info.derivatives.D2Psi.D2PsiDE0DH   =  zeros(dim,dim^2,ngauss);
mat_info.derivatives.D2Psi.D2PsiDE0DJ   =  zeros(dim,1,ngauss);
mat_info.derivatives.D2Psi.D2PsiDE0DE0  =  zeros(dim,dim,ngauss);
mat_info.derivatives.D2Psi.D2PsiDJDH    =  zeros(1,dim^2,ngauss);
mat_info.derivatives.D2Psi.D2PsiDJDJ    =  zeros(ngauss,1);
mat_info.derivatives.D2Psi.D2PsiDJDE0   =  zeros(1,dim,ngauss);
E0matrix1              =  randi(dim,dim^2);
Itensor                =  eye(dim^2);


N                      =  1e4;
tic
for i=1:N

switch dim
    case 2
         twoD_Jterm    =  mu2*J;
    case 3 
         twoD_Jterm    =  0;
end
E0matrix1              =  zeros(dim,dim^2);  
%LHS_E0                 =  vectorisation.vector2matrix_rowwise.LHS_indices;
%RHS_E0                 =  vectorisation.vector2matrix_rowwise.RHS_indices;
D_HE0HE0_DH_DE0        =  DiffMatrixVectorMatrixVectorDiffMatrixDiffVector(dim,ngauss,H,E0);
%--------------------------------------------------------------------------
% Second derivatives of the model
%--------------------------------------------------------------------------                                                                            
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Auxiliary fields
    %----------------------------------------------------------------------
    invJ               =  1/J(igauss);
    HE0                =  H(:,:,igauss)*E0(:,igauss);
    %E0matrix1(LHS_E0)  =  E0(RHS_E0,igauss);
    HE0_E0             =  HE0*E0(:,igauss)';
    %----------------------------------------------------------------------
    % Derivatives
    %----------------------------------------------------------------------
    mat_info.derivatives.D2Psi.D2PsiDFDF(:,:,igauss)    =  mu1*Itensor;
    
    mat_info.derivatives.D2Psi.D2PsiDHDH(:,:,igauss)    =  mu2*Itensor - invJ*inve1*(E0matrix1'*E0matrix1);
    mat_info.derivatives.D2Psi.D2PsiDHDJ(:,:,igauss)    =  -invJ^2*inve1*reshape(HE0_E0',[],1);
    mat_info.derivatives.D2Psi.D2PsiDHDE0(:,:,igauss)   =  -invJ*inve1*D_HE0HE0_DH_DE0(:,:,igauss);
    
    mat_info.derivatives.D2Psi.D2PsiDE0DH(:,:,igauss)   =  mat_info.derivatives.D2Psi.D2PsiDHDE0(:,:,igauss)';
    mat_info.derivatives.D2Psi.D2PsiDE0DJ(:,:,igauss)   =  invJ^2*inve1*H(:,:,igauss)'*HE0;
    mat_info.derivatives.D2Psi.D2PsiDE0DE0(:,:,igauss)  =  -invJ*inve1*H(:,:,igauss)'*H(:,:,igauss);

    mat_info.derivatives.D2Psi.D2PsiDJDH(:,:,igauss)    =  mat_info.derivatives.D2Psi.D2PsiDHDJ(:,:,igauss)';
    mat_info.derivatives.D2Psi.D2PsiDJDJ(igauss)        =  (mu1 + 2*mu2)/(J(igauss))^2 + kappa - inve1*invJ^3*(HE0'*HE0) + twoD_Jterm(igauss);
    mat_info.derivatives.D2Psi.D2PsiDJDE0(:,:,igauss)   =  mat_info.derivatives.D2Psi.D2PsiDE0DJ(:,:,igauss)';
end
end
toc