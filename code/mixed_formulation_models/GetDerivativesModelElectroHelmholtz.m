
function material_information            =  GetDerivativesModelElectroHelmholtz(ielem,dim,ngauss,F,H,J,E0,material_information,vectorisation)                                 

%--------------------------------------------------------------------------
% We get DU: derivatives of the internal energy expressed as a function of
% (F,H,J,D0,d)
%--------------------------------------------------------------------------
material_information                     =  FirstDerivativeComputationHelmholtz(ielem,dim,ngauss,F,H,J,E0,material_information);                                                                      
%--------------------------------------------------------------------------
% We get D2U: second derivatives of the internal energy expressed as a 
% function of (F,H,J,D0,d)
%--------------------------------------------------------------------------
material_information                     =  HessianOperatorHelmholtz(ielem,dim,ngauss,F,H,J,E0,material_information,vectorisation);
