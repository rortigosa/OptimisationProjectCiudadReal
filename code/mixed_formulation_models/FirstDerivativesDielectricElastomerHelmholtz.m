function material_information  =  FirstDerivativesDielectricElastomerHelmholtz(ielem,n_gauss,...
                                                                               F,H,J,E0,material_information)
%--------------------------------------------------------------------------                                                                                        
% Material number identifier
%--------------------------------------------------------------------------                                                                                        
mat_id                    =  material_information.material_identifier(ielem)                                                                                        ;
%--------------------------------------------------------------------------                                                                                        
% Material parameters
%--------------------------------------------------------------------------                                                                                        
mu1                       =  material_information.material_parameters.mu1(mat_id);
mu2                       =  material_information.material_parameters.mu2(mat_id);
kappa                     =  material_information.material_parameters.kappa(mat_id);
e1                        =  material_information.material_parameters.e1(mat_id);
%--------------------------------------------------------------------------                                                                                        
% First derivatives of the model
%--------------------------------------------------------------------------                                                                                        
for igauss=1:n_gauss
    HE0                                                        =  H(:,:,igauss)*E0(:,igauss);
    material_information.derivatives.DPsi.DPsiDF(:,:,igauss)   =  mu1*F(:,:,igauss);
    material_information.derivatives.DPsi.DPsiDH(:,:,igauss)   =  mu2*H(:,:,igauss) - 1/(e1*J(igauss))*((H*E0)*E0(:,igauss)');
    material_information.derivatives.DPsi.DPsiDJ(:,:,igauss)   =  -(mu1 + 2*mu2)/J(igauss) + kappa*(J(igauss)-1) + 1/(2*e1*J(igauss)^2)*(HE0'*HE0);
    material_information.derivatives.DPsi.DPsiDE0(:,igauss)    =  -1/(2*e1*J(igauss))*H(:,:,gauss)'*HE0(:,igauss);
end
