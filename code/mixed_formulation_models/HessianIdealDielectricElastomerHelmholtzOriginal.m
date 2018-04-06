function mat_info  =  HessianIdealDielectricElastomerHelmholtzOriginal(ielem,dim,ngauss,H,...
                                                                       J,E0,mat_info,vectorisation)

%--------------------------------------------------------------------------
% Material number identifier
%--------------------------------------------------------------------------
mat_id                 =  mat_info.material_identifier(ielem);
%--------------------------------------------------------------------------
% Material parameters
%--------------------------------------------------------------------------                                                                            
mu1                    =  mat_info.material_parameters.mu1(mat_id);
mu2                    =  mat_info.material_parameters.mu2(mat_id);
kappa                  =  mat_info.material_parameters.kappa(mat_id);
e1                     =  mat_info.material_parameters.e1(mat_id);
inve1                  =  1/e1;
%--------------------------------------------------------------------------
% Intermediate entities
%--------------------------------------------------------------------------                                                                            
switch dim
    case 2
         twoD_Jterm    =  mu2*J;
    case 3 
         twoD_Jterm    =  0;
end
HT                     =  permute(H,[2 1 3]);
E0matrix1              =  zeros(dim,dim^2,ngauss);  
LHS_E0                 =  vectorisation.vector2matrix_rowwise_Gauss_points.LHS_indices;
RHS_E0                 =  vectorisation.vector2matrix_rowwise_Gauss_points.RHS_indices;
D_HE0HE0_DH_DE0        =  DiffMatrixVectorMatrixVectorDiffMatrixDiffVector(dim,ngauss,H,E0);
HE0                    =  MatrixVectorMultiplication(dim,ngauss,H,E0);
E0matrix1(LHS_E0)      =  E0(RHS_E0);
HE0_E0                 =  VectorVectorOuterMultiplication(dim,ngauss,HE0,E0);
Itensor                =  repmat(eye(dim^2),1,1,ngauss);
E0matrix_E0matrix1     =  MatrixMatrixMultiplication(dim^2,dim^2,ngauss,permute(E0matrix1,[2 1 3]),E0matrix1);
HTHE0                  =  MatrixVectorMultiplication(dim,ngauss,HT,HE0);
invJ                   =  1./J;
invJ2                  =  invJ.^2;
invJ3                  =  invJ.^3;
HTH                    =  MatrixMatrixMultiplication(dim,dim,ngauss,HT,H);
HTE0_HTE0              =  VectorVectorInnerMultiplication(ngauss,HE0,HE0);
%--------------------------------------------------------------------------
% Derivatives 
%--------------------------------------------------------------------------
mat_info.derivatives.D2Psi.D2PsiDFDF    =  mu1*Itensor;

mat_info.derivatives.D2Psi.D2PsiDHDH    =  mu2*Itensor - inve1*MatrixScalarMultiplication(dim^2,dim^2,ngauss,E0matrix_E0matrix1,invJ);
mat_info.derivatives.D2Psi.D2PsiDHDJ    =  inve1*VectorScalarMultiplication(dim^2,ngauss,reshape(HE0_E0,dim^2,ngauss),invJ2);

mat_info.derivatives.D2Psi.D2PsiDHDE0   =  -inve1*MatrixScalarMultiplication(dim^2,dim,ngauss,D_HE0HE0_DH_DE0,invJ);

mat_info.derivatives.D2Psi.D2PsiDE0DH   =  permute(mat_info.derivatives.D2Psi.D2PsiDHDE0,[2  1 3]);
mat_info.derivatives.D2Psi.D2PsiDE0DJ   =  inve1*VectorScalarMultiplication(dim,ngauss,HTHE0,invJ2);
mat_info.derivatives.D2Psi.D2PsiDE0DE0  =  -inve1*MatrixScalarMultiplication(dim,dim,ngauss,HTH,invJ);

mat_info.derivatives.D2Psi.D2PsiDJDH    =  reshape(mat_info.derivatives.D2Psi.D2PsiDHDJ,1,dim^2,ngauss);
mat_info.derivatives.D2Psi.D2PsiDJDJ    =  (mu1 + 2*mu2)*invJ2 + kappa - inve1*(invJ3.*HTE0_HTE0) + twoD_Jterm;
mat_info.derivatives.D2Psi.D2PsiDJDE0   =  reshape(mat_info.derivatives.D2Psi.D2PsiDE0DJ,1,dim,ngauss);
