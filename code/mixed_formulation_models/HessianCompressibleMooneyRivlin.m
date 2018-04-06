function mat_info    =  HessianCompressibleMooneyRivlin(ielem,dim,ngauss,...
                                                      J,mat_info)

%--------------------------------------------------------------------------
% Material number identifier
%--------------------------------------------------------------------------
mat_id               =  mat_info.material_identifier(ielem);
%--------------------------------------------------------------------------
% Material parameters
%--------------------------------------------------------------------------                                                                            
mu1                  =  mat_info.parameters.MRivlin.mu1(mat_id);
mu2                  =  mat_info.parameters.MRivlin.mu2(mat_id);
kappa                =  mat_info.parameters.MRivlin.kappa(mat_id);
%--------------------------------------------------------------------------
% Auxiliar matrices
%--------------------------------------------------------------------------
Itensor              =  repmat(eye(dim^2),1,1,ngauss);
%--------------------------------------------------------------------------
% Converting invariant H from 3 to 2D
%--------------------------------------------------------------------------                                                                            
switch dim
    case 2
         twoD_Jterm  =  mu2;
    case 3
         twoD_Jterm  =  0;
end
%--------------------------------------------------------------------------
% Second derivatives of the model
%--------------------------------------------------------------------------                                                                            
mat_info.derivatives.D2U.D2UDFDF  =  mu1*Itensor;
mat_info.derivatives.D2U.D2UDHDH  =  mu2*Itensor;
mat_info.derivatives.D2U.D2UDJDJ  =  (mu1 + 2*mu2)./(J.^2) + kappa + twoD_Jterm;


