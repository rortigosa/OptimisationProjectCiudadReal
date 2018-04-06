
function mat_info   =  GetDerivativesModelElectroMixed(ielem,dim,ngauss,F,H,J,D0,d,mat_info)                                 

%--------------------------------------------------------------------------
% We get DU: derivatives of the internal energy expressed as a function of
% (F,H,J,D0,d)
%--------------------------------------------------------------------------
mat_info            =  FirstDerivativeComputation(ielem,ngauss,F,H,J,D0,d,mat_info);                                                                      
%--------------------------------------------------------------------------
% We get D2U: second derivatives of the internal energy expressed as a 
% function of (F,H,J,D0,d)
%--------------------------------------------------------------------------
mat_info            =  HessianOperatorInternalEnergy(ielem,dim,ngauss,F,H,J,D0,d,mat_info);
