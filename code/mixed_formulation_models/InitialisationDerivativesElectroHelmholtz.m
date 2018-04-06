function str          =  InitialisationDerivativesElectroHelmholtz(dim,n_gauss,str)

%--------------------------------------------------------------------------
% First derivatives of the internal energy when expressed in terms of F, H,
% J, D0 and d
%--------------------------------------------------------------------------
DPsi.DPsiDF           =  zeros(dim,dim,n_gauss);
DPsi.DPsiDH           =  zeros(dim,dim,n_gauss);
DPsi.DPsiDJ           =  zeros(n_gauss,1);
DPsi.DPsiDE0          =  zeros(dim,n_gauss);
%--------------------------------------------------------------------------
% Second derivatives of the Helmholtz's energy
%--------------------------------------------------------------------------
D2Psi.D2PsiDFDF       =  zeros(dim^2,dim^2,n_gauss);
D2Psi.D2PsiDFDH       =  zeros(dim^2,dim^2,n_gauss);
D2Psi.D2PsiDFDJ       =  zeros(dim^2,1,n_gauss);
D2Psi.D2PsiDFDE0      =  zeros(dim^2,dim,n_gauss);
D2Psi.D2PsiDHDF       =  zeros(dim^2,dim^2,n_gauss);
D2Psi.D2PsiDHDH       =  zeros(dim^2,dim^2,n_gauss);
D2Psi.D2PsiDHDJ       =  zeros(dim^2,1,n_gauss);
D2Psi.D2PsiDHDE0      =  zeros(dim^2,dim,n_gauss);
D2Psi.D2PsiDJDF       =  zeros(1,dim^2,n_gauss);
D2Psi.D2PsiDJDH       =  zeros(1,dim^2,n_gauss);
D2Psi.D2PsiDJDJ       =  zeros(n_gauss,1);
D2Psi.D2PsiDJDE0      =  zeros(1,dim,n_gauss);
D2Psi.D2PsiDE0DF      =  zeros(dim,dim^2,n_gauss);
D2Psi.D2PsiDE0DH      =  zeros(dim,dim^2,n_gauss);
D2Psi.D2PsiDE0DJ      =  zeros(dim,1,n_gauss);
D2Psi.D2PsiDE0DE0     =  zeros(dim,dim,n_gauss);
%--------------------------------------------------------------------------
% Store all the derivatives
%--------------------------------------------------------------------------
str.mat_info.derivatives.DPsi    =  DPsi;
str.mat_info.derivatives.D2Psi   =  D2Psi;
