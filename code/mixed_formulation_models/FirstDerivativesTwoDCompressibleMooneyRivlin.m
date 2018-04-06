function material_information  =  FirstDerivativesTwoDCompressibleMooneyRivlin(ielem,n_gauss,...
                                                              F,J,material_information)
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
    material_information.derivatives.DU.DUDF(:,:,igauss)   =  (mu1 + mu2)*F(:,:,igauss);
    material_information.derivatives.DU.DUDJ(:,:,igauss)   =  -(mu1 + mu2)/J(igauss) + kappa*(J(igauss)-1);
end
