function material_information  =  FirstDerivativesThreeDCompressibleMooneyRivlin(ielem,n_gauss,...
                                                              F,H,J,material_information)
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
%--------------------------------------------------------------------------                                                                                        
% First derivatives of the model
%--------------------------------------------------------------------------                                                                                        
for igauss=1:n_gauss
    material_information.derivatives.DU.DUDF(:,:,igauss)   =  mu1*F(:,:,igauss);
    material_information.derivatives.DU.DUDH(:,:,igauss)   =  mu2*H(:,:,igauss);
    material_information.derivatives.DU.DUDJ(:,:,igauss)   =  -(mu1 + 2*mu2)/J(igauss) + kappa*(J(igauss)-1);
end
