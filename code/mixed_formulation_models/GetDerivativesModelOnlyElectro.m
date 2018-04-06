
function mat_info            =  GetDerivativesModelOnlyElectro(ielem,dim,ngauss,D0,mat_info)                                 

%--------------------------------------------------------------------------
% We get DU: derivatives of the internal energy expressed as a function of
% (F,H,J,D0,d)
%--------------------------------------------------------------------------
mat_info                     =  FirstDerivativeComputationOnlyElectro(ielem,ngauss,D0,mat_info);                                                                      
%--------------------------------------------------------------------------
% We get D2U: second derivatives of the internal energy expressed as a 
% function of (F,H,J,D0,d)
%--------------------------------------------------------------------------
mat_info                     =  HessianOperatorInternalEnergyOnlyElectro(ielem,dim,ngauss,D0,mat_info);
%--------------------------------------------------------------------------
% We get D2Psi: second derivatives of the Helmholtz's energy expressed as a 
% function of (F,H,J,E0)
%--------------------------------------------------------------------------
mat_info.derivatives         =  HessianOperatorHelmholtzEnergyOnlyElectro(dim,ngauss,mat_info.derivatives);
