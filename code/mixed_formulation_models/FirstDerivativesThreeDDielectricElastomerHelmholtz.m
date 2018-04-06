function mat_info  =  FirstDerivativesThreeDDielectricElastomerHelmholtz(ielem,dim,ngauss,...
                                                                         F,H,J,E0,mat_info)
%--------------------------------------------------------------------------                                                                                        
% Material number identifier
%--------------------------------------------------------------------------                                                                                        
mat_id                    =  mat_info.material_identifier(ielem)                                                                                        ;
%--------------------------------------------------------------------------                                                                                        
% Material parameters
%--------------------------------------------------------------------------                                                                                        
mu1                       =  mat_info.material_parameters.mu1(mat_id);
mu2                       =  mat_info.material_parameters.mu2(mat_id);
kappa                     =  mat_info.material_parameters.kappa(mat_id);
e1                        =  mat_info.material_parameters.e1(mat_id);
%--------------------------------------------------------------------------                                                                                        
% Intermediate vectors, scalars, matrices
%--------------------------------------------------------------------------            
switch dim
    case 2
         twoD_Jterm                =  mu2*J;
    case 3 
         twoD_Jterm                =  0;
end
HE0                                =  MatrixVectorMultiplication(dim,ngauss,H,E0);
HE0HE0                             =  VectorVectorInnerMultiplication(ngauss,HE0,HE0);
HE0E0                              =  VectorVectorOuterMultiplication(dim,ngauss,HE0,E0);
HTHE0                              =  MatrixVectorMultiplication(dim,ngauss,permute(H,[2,1,3]),HE0);
invJ                               =  1./J; 
%--------------------------------------------------------------------------                                                                                        
% First derivatives of the model
%--------------------------------------------------------------------------            
mat_info.derivatives.DPsi.DPsiDF   =  mu1*F;
mat_info.derivatives.DPsi.DPsiDH   =  mu2*H - e1*MatrixScalarMultiplication(dim,dim,ngauss,HE0E0,invJ);
mat_info.derivatives.DPsi.DPsiDE0  =  -e1*VectorScalarMultiplication(dim,ngauss,HTHE0,invJ);
mat_info.derivatives.DPsi.DPsiDJ   =  -(mu1 + 2*mu2)*invJ + kappa*(J-1) + e1/(2)*((invJ.^2).*HE0HE0) + twoD_Jterm;

