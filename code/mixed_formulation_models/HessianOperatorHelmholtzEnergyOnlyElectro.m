         
function derivatives                           =  HessianOperatorHelmholtzEnergyOnlyElectro(dim,n_gauss,derivatives)

for igauss=1:n_gauss
    derivatives.D2Psi.D2PsiDE0DE0(:,:,igauss)  =  -(derivatives.D2U.D2UDD0DD0(:,:,igauss)\eye(dim));
end


