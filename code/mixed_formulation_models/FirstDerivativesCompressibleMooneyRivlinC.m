function material_information  =  FirstDerivativesCompressibleMooneyRivlinC(ielem,n_gauss,...
                                                              C,G,c,material_information)
%--------------------------------------------------------------------------                                                                                        
% Material number identifier
%--------------------------------------------------------------------------                                                                                        
mat_id                    =  material_information.material_identifier(ielem);
Imatrix                   =  eye(size(C,1));
%--------------------------------------------------------------------------                                                                                        
% Material parameters
%--------------------------------------------------------------------------                                                                                        
mu1                       =  material_information.material_parameters.mu1(mat_id);
mu2                       =  material_information.material_parameters.mu2(mat_id);
kappa                     =  material_information.material_parameters.kappa(mat_id);
%--------------------------------------------------------------------------                                                                                        
% J
%--------------------------------------------------------------------------                                                                                        
J                         =  sqrt(c);
invJ                      =  1./J;
%--------------------------------------------------------------------------                                                                                        
% First derivatives of the model 
%--------------------------------------------------------------------------                                                                                        
for igauss=1:n_gauss
    material_information.derivatives.DU.DUDC(:,:,igauss)   =  0.5*mu1*Imatrix;
    material_information.derivatives.DU.DUDG(:,:,igauss)   =  0.5*mu2*Imatrix;
    material_information.derivatives.DU.DUDc(igauss)       =  -0.5*(mu1 + 2*mu2)/c(igauss) + 0.5*kappa*(J(igauss)-1)*invJ(igauss);
end
