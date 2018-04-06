function material_information  =  HessianThreeDCompressibleMooneyRivlin(ielem,dim,n_gauss,...
                                                                        J,material_information)

%--------------------------------------------------------------------------
% Material number identifier
%--------------------------------------------------------------------------
mat_id                         =  material_information.material_identifier(ielem);
%--------------------------------------------------------------------------
% Auxiliar matrices
%--------------------------------------------------------------------------
Itensor                        =  eye(dim^2);
%--------------------------------------------------------------------------
% Material parameters
%--------------------------------------------------------------------------                                                                            
mu1                            =  material_information.material_parameters.mu1(mat_id);
mu2                            =  material_information.material_parameters.mu2(mat_id);
kappa                          =  material_information.material_parameters.kappa(mat_id);
%--------------------------------------------------------------------------
% Second derivatives of the model
%--------------------------------------------------------------------------                                                                            
for igauss=1:n_gauss
    material_information.derivatives.D2U.D2UDFDF(:,:,igauss)    =  mu1*Itensor;
    material_information.derivatives.D2U.D2UDHDH(:,:,igauss)    =  mu2*Itensor;
    material_information.derivatives.D2U.D2UDJDJ(igauss)        =  (mu1 + 2*mu2)/(J(igauss))^2 + kappa;
end
