function mat_info    =  HessianCompressibleNeoHookean(ielem,dim,ngauss,...
                                                      J,mat_info)

%--------------------------------------------------------------------------
% Material number identifier
%--------------------------------------------------------------------------
mat_id               =  mat_info.material_identifier(ielem);
%--------------------------------------------------------------------------
% Material parameters
%--------------------------------------------------------------------------                                                                            
mu                   =  mat_info.parameters.NHookean.mu(mat_id);
kappa                =  mat_info.parameters.NHookean.kappa(mat_id);
%--------------------------------------------------------------------------
% Auxiliar matrices
%--------------------------------------------------------------------------
Itensor              =  repmat(eye(dim^2),1,1,ngauss);
%--------------------------------------------------------------------------
% Second derivatives of the model
%--------------------------------------------------------------------------                                                                            
mat_info.derivatives.D2U.D2UDFDF  =  mu*Itensor;
mat_info.derivatives.D2U.D2UDJDJ  =  mu./(J.^2) + kappa;




