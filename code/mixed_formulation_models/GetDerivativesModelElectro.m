
function material_information            =  GetDerivativesModelElectro(ielem,dim,ngauss,F,H,J,D0,d,material_information,vectorisation)                                 

%--------------------------------------------------------------------------
% We get DU: derivatives of the internal energy expressed as a function of
% (F,H,J,D0,d)
%--------------------------------------------------------------------------
material_information                     =  FirstDerivativeComputation(ielem,ngauss,F,H,J,D0,d,material_information);                                                                      
%--------------------------------------------------------------------------
% We get D2U: second derivatives of the internal energy expressed as a 
% function of (F,H,J,D0,d)
%--------------------------------------------------------------------------
material_information                     =  HessianOperatorInternalEnergy(ielem,dim,ngauss,F,H,J,D0,d,material_information);
%--------------------------------------------------------------------------
% We get D2Uhat: second derivatives of the internal energy expressed as a 
% function of (F,H,J,D0)
%--------------------------------------------------------------------------
material_information.derivatives         =  ReexpressionInternalEnergyFourFieldSet(dim,ngauss,D0,material_information.derivatives,...
                                                                                F,vectorisation);   
%--------------------------------------------------------------------------
% We get D2Psi: second derivatives of the Helmholtz's energy expressed as a 
% function of (F,H,J,E0)
%--------------------------------------------------------------------------
material_information.derivatives         =  HessianOperatorHelmholtzEnergy(dim,ngauss,material_information.derivatives);
