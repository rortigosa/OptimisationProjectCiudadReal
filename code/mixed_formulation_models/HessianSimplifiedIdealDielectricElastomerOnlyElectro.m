function mat_info  =  HessianSimplifiedIdealDielectricElastomerOnlyElectro(ielem,dim,ngauss,mat_info)

%--------------------------------------------------------------------------
% Material number identifier
%--------------------------------------------------------------------------
mat_id                         =  mat_info.material_identifier(ielem);
%--------------------------------------------------------------------------
% Auxiliar matrices
%--------------------------------------------------------------------------
Imatrix                        =  eye(dim);
%--------------------------------------------------------------------------
% Material parameters
%--------------------------------------------------------------------------                                                                            
e                              =  mat_info.material_parameters.e1(mat_id);
%--------------------------------------------------------------------------
% Second derivatives of the model
%--------------------------------------------------------------------------                                                                            
for igauss=1:ngauss
mat_info.derivatives.D2U.D2UDD0DD0(:,:,igauss)  =  (1/e)*Imatrix;
end
