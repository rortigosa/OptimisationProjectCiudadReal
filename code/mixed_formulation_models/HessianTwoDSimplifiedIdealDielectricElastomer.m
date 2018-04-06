function material_information  =  HessianTwoDSimplifiedIdealDielectricElastomer(ielem,dim,n_gauss,...
                                                                                   J,D0,material_information)

%--------------------------------------------------------------------------                                                                               
% Material number identifier
%--------------------------------------------------------------------------                                                                               
mat_id                         =  material_information.material_identifier(ielem);
%--------------------------------------------------------------------------                                                                               
% Auxiliar matrices
%--------------------------------------------------------------------------                                                                               
Itensor                        =  eye(dim^2);
Imatrix                        =  eye(dim);
%--------------------------------------------------------------------------                                                                               
% Material parameters
%--------------------------------------------------------------------------                                                                                                                                                           
mu1                            =  material_information.material_parameters.mu1(mat_id);
mu2                            =  material_information.material_parameters.mu2(mat_id);
kappa                          =  material_information.material_parameters.kappa(mat_id);
e1                             =  material_information.material_parameters.e1(mat_id);
e2                             =  material_information.material_parameters.e2(mat_id);
%--------------------------------------------------------------------------                                                                               
% Second derivatives of the model
%--------------------------------------------------------------------------                                                                                                                                                           
for igauss=1:n_gauss
    material_information.derivatives.D2U.D2UDFDF(:,:,igauss)    =  (mu1 + mu2)*Itensor;
    material_information.derivatives.D2U.D2UDJDJ(igauss)        =  (mu1 + mu2)/(J(igauss))^2 + kappa;
    material_information.derivatives.D2U.D2UDD0DD0(:,:,igauss)  =  1/(e2)*Imatrix;
    material_information.derivatives.D2U.D2UDdDd(:,:,igauss)    =  1/(e1)*Imatrix;
end
