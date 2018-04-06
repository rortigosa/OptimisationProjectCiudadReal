function material_information  =  HessianIdealDielectricElastomerHelmholtzV0(ielem,dim,n_gauss,H,...
                                                                           J,E0,material_information,vectorisation)

%--------------------------------------------------------------------------
% Material number identifier
%--------------------------------------------------------------------------
mat_id                 =  material_information.material_identifier(ielem);
%--------------------------------------------------------------------------
% Auxiliar matrices
%--------------------------------------------------------------------------
Itensor                =  eye(dim^2);
%--------------------------------------------------------------------------
% Material parameters
%--------------------------------------------------------------------------                                                                            
mu1                    =  material_information.material_parameters.mu1(mat_id);
mu2                    =  material_information.material_parameters.mu2(mat_id);
kappa                  =  material_information.material_parameters.kappa(mat_id);
e1                     =  material_information.material_parameters.e1(mat_id);
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
E0matrix1              =  zeros(dim,dim^2);  
LHS_E0                 =  vectorisation.vector2matrix_rowwise.LHS_indices;
RHS_E0                 =  vectorisation.vector2matrix_rowwise.RHS_indices;
D_HE0HE0_DH_DE0        =  DiffMatrixVectorMatrixVectorDiffMatrixDiffVector(dim,n_gauss,H,E0);
%--------------------------------------------------------------------------
% Second derivatives of the model
%--------------------------------------------------------------------------                                                                            
for igauss=1:n_gauss
    %----------------------------------------------------------------------
    % Auxiliary fields
    %----------------------------------------------------------------------
    invJ               =  1/J(igauss);
    HE0                =  H(:,:,igauss)*E0(:,igauss);
    E0matrix1(LHS_E0)  =  E0(RHS_E0,igauss);
    HE0_E0             =  HE0*E0(:,igauss)';
    %----------------------------------------------------------------------
    % Derivatives
    %----------------------------------------------------------------------
    material_information.derivatives.D2Psi.D2PsiDFDF(:,:,igauss)    =  mu1*Itensor;
    
    material_information.derivatives.D2Psi.D2PsiDHDH(:,:,igauss)    =  mu2*Itensor - invJ*inve1*(E0matrix1'*E0matrix1);
    material_information.derivatives.D2Psi.D2PsiDHDJ(:,:,igauss)    =  -invJ^2*inve1*reshape(HE0_E0',[],1);
    material_information.derivatives.D2Psi.D2PsiDHDE0(:,:,igauss)   =  -invJ*inve1*D_HE0HE0_DH_DE0(:,:,igauss);
    
    material_information.derivatives.D2Psi.D2PsiDE0DH(:,:,igauss)   =  material_information.derivatives.D2Psi.D2PsiDHDE0(:,:,igauss)';
    material_information.derivatives.D2Psi.D2PsiDE0DJ(:,:,igauss)   =  invJ^2*inve1*H(:,:,igauss)'*HE0;
    material_information.derivatives.D2Psi.D2PsiDE0DE0(:,:,igauss)  =  -invJ*inve1*H(:,:,igauss)'*H(:,:,igauss);

    material_information.derivatives.D2Psi.D2PsiDJDH(:,:,igauss)    =  material_information.derivatives.D2Psi.D2PsiDHDJ(:,:,igauss)';
    material_information.derivatives.D2Psi.D2PsiDJDJ(igauss)        =  (mu1 + 2*mu2)/(J(igauss))^2 + kappa - inve1*invJ^3*(HE0'*HE0) + twoD_Jterm(igauss);
    material_information.derivatives.D2Psi.D2PsiDJDE0(:,:,igauss)   =  material_information.derivatives.D2Psi.D2PsiDE0DJ(:,:,igauss)';
end
