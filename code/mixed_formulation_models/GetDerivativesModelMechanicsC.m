
function material_information     =  GetDerivativesModelMechanicsC(ielem,dim,ngauss,C,G,c,material_information)                                 

%--------------------------------------------------------------------------
% We get DU: derivatives of the internal energy expressed as a function of
% (F,H,J,D0,d)
%--------------------------------------------------------------------------
material_information                =  FirstDerivativeComputationMechanicsC(ielem,ngauss,C,G,c,material_information);                                                                      
%--------------------------------------------------------------------------
% We get D2U: second derivatives of the internal energy expressed as a 
% function of (F,H,J,D0,d)
%--------------------------------------------------------------------------
material_information                =  HessianOperatorInternalEnergyMechanicsC(ielem,dim,ngauss,C,G,c,material_information);
