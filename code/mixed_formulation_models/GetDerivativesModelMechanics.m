
function mat_info   =  GetDerivativesModelMechanics(ielem,dim,ngauss,F,H,J,mat_info,model)                                 

%--------------------------------------------------------------------------
% We get DU: derivatives of the internal energy expressed as a function of
% (F,H,J,D0,d)
%--------------------------------------------------------------------------
mat_info            =  FirstDerivativeComputationMechanics(ielem,dim,ngauss,F,H,J,mat_info,model);                                                                      
%--------------------------------------------------------------------------
% We get D2U: second derivatives of the internal energy expressed as a 
% function of (F,H,J,D0,d)
%--------------------------------------------------------------------------
mat_info            =  HessianOperatorInternalEnergyMechanics(ielem,dim,ngauss,F,H,J,mat_info,model);
