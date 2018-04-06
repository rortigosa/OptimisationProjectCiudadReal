function str          =  InitialisationDerivativesOnlyElectroBEMFEM(dim,n_gauss,str)

%--------------------------------------------------------------------------
% First derivatives of the internal energy when expressed in terms of F, H,
% J, D0 and d
%--------------------------------------------------------------------------
DU.DUDD0              =  zeros(dim,n_gauss);
%--------------------------------------------------------------------------
% Second derivatives of the Helmholtz's energy
%--------------------------------------------------------------------------
D2Psi.D2PsiDE0DE0     =  zeros(dim,dim,n_gauss);
%--------------------------------------------------------------------------
% Second derivatives of the internal energy when expressed in terms of F,
% H, J, D0 and d
%--------------------------------------------------------------------------
D2U.D2UDD0DD0         =  zeros(dim,dim,n_gauss);
%--------------------------------------------------------------------------
% Store all the derivatives
%--------------------------------------------------------------------------
str.material_information.derivatives.DU      =  DU;
str.material_information.derivatives.D2Psi   =  D2Psi;
str.material_information.derivatives.D2U     =  D2U;
