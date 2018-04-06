function mat_info  =  HessianSimplifiedIdealDielectricElastomer(ielem,dim,n_gauss,...
                                                                J,D0,mat_info)

%--------------------------------------------------------------------------
% Material number identifier
%--------------------------------------------------------------------------
mat_id                         =  mat_info.material_identifier(ielem);
%--------------------------------------------------------------------------
% Auxiliar matrices
%--------------------------------------------------------------------------
Itensor                        =  eye(dim^2);
Imatrix                        =  eye(dim);
%--------------------------------------------------------------------------
% Material parameters
%--------------------------------------------------------------------------                                                                            
mu1                            =  mat_info.material_parameters.mu1(mat_id);
mu2                            =  mat_info.material_parameters.mu2(mat_id);
kappa                          =  mat_info.material_parameters.kappa(mat_id);
e1                             =  mat_info.material_parameters.e1(mat_id);
e2                             =  mat_info.material_parameters.e2(mat_id);
%--------------------------------------------------------------------------
% Second derivatives of the model
%--------------------------------------------------------------------------                                                                            
for igauss=1:n_gauss
    mat_info.derivatives.D2U.D2UDFDF(:,:,igauss)    =  mu1*Itensor;
    mat_info.derivatives.D2U.D2UDHDH(:,:,igauss)    =  mu2*Itensor;
    mat_info.derivatives.D2U.D2UDJDJ(igauss)        =  (mu1 + 2*mu2)/(J(igauss))^2 + kappa;
    mat_info.derivatives.D2U.D2UDD0DD0(:,:,igauss)  =  1/(e2)*Imatrix;
    mat_info.derivatives.D2U.D2UDdDd(:,:,igauss)    =  1/(e1)*Imatrix;
end
