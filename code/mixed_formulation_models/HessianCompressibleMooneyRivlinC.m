function material_information  =  HessianCompressibleMooneyRivlinC(ielem,dim,n_gauss,...
                                                                        c,material_information)

%--------------------------------------------------------------------------
% Material number identifier
%--------------------------------------------------------------------------
mat_id                         =  material_information.material_identifier(ielem);
%--------------------------------------------------------------------------
% Material parameters
%--------------------------------------------------------------------------                                                                            
mu1                            =  material_information.material_parameters.mu1(mat_id);
mu2                            =  material_information.material_parameters.mu2(mat_id);
kappa                          =  material_information.material_parameters.kappa(mat_id);
%--------------------------------------------------------------------------
% Second derivatives of the model
%--------------------------------------------------------------------------                                                                            
material_information.derivatives.D2U.D2UDcDc   =  0.5*(mu1 + mu2)*(1./c) + 0.25*kappa*c.^(-3/2);
