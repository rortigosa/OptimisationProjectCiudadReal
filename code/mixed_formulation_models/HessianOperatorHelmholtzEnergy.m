         
function derivatives                           =  HessianOperatorHelmholtzEnergy(dim,n_gauss,derivatives)

for igauss=1:n_gauss
    
    derivatives.D2Psi.D2PsiDE0DE0(:,:,igauss)  =  -(derivatives.D2Uhat.D2UDD0DD0(:,:,igauss)\eye(dim));
         
    derivatives.D2Psi.D2PsiDFDE0(:,:,igauss)   =  -derivatives.D2Uhat.D2UDFDD0(:,:,igauss)*derivatives.D2Psi.D2PsiDE0DE0(:,:,igauss);
    derivatives.D2Psi.D2PsiDE0DF(:,:,igauss)   =  derivatives.D2Psi.D2PsiDFDE0(:,:,igauss)';
    derivatives.D2Psi.D2PsiDHDE0(:,:,igauss)   =  -derivatives.D2Uhat.D2UDHDD0(:,:,igauss)*derivatives.D2Psi.D2PsiDE0DE0(:,:,igauss);
    derivatives.D2Psi.D2PsiDE0DH(:,:,igauss)   =  derivatives.D2Psi.D2PsiDHDE0(:,:,igauss)';
    derivatives.D2Psi.D2PsiDJDE0(:,:,igauss)   =  -derivatives.D2Uhat.D2UDJDD0(:,:,igauss)*derivatives.D2Psi.D2PsiDE0DE0(:,:,igauss);
    derivatives.D2Psi.D2PsiDE0DJ(:,:,igauss)   =  derivatives.D2Psi.D2PsiDJDE0(:,:,igauss)';
        
    derivatives.D2Psi.D2PsiDFDF(:,:,igauss)    =  derivatives.D2Uhat.D2UDFDF(:,:,igauss) - ...
                                                  derivatives.D2Uhat.D2UDFDD0(:,:,igauss)*derivatives.D2Psi.D2PsiDE0DF(:,:,igauss);
    derivatives.D2Psi.D2PsiDHDF(:,:,igauss)    =  derivatives.D2Uhat.D2UDHDF(:,:,igauss) - ...
                                                  derivatives.D2Uhat.D2UDFDD0(:,:,igauss)*derivatives.D2Psi.D2PsiDE0DH(:,:,igauss);
    derivatives.D2Psi.D2PsiDFDJ(:,:,igauss)    =  derivatives.D2Uhat.D2UDFDJ(:,:,igauss) - ...
                                                  derivatives.D2Uhat.D2UDFDD0(:,:,igauss)*derivatives.D2Psi.D2PsiDE0DJ(:,:,igauss);
    
    derivatives.D2Psi.D2PsiDHDF(:,:,igauss)    =  derivatives.D2Psi.D2PsiDFDH(:,:,igauss)';
    derivatives.D2Psi.D2PsiDHDH(:,:,igauss)    =  derivatives.D2Uhat.D2UDHDH(:,:,igauss) - ...
                                                  derivatives.D2Uhat.D2UDHDD0(:,:,igauss)*derivatives.D2Psi.D2PsiDE0DH(:,:,igauss);
    derivatives.D2Psi.D2PsiDHDJ(:,:,igauss)    =  derivatives.D2Uhat.D2UDHDJ(:,:,igauss) - ...
                                                  derivatives.D2Uhat.D2UDHDD0(:,:,igauss)*derivatives.D2Psi.D2PsiDE0DJ(:,:,igauss);
    
    derivatives.D2Psi.D2PsiDJDF(:,:,igauss)    =  derivatives.D2Psi.D2PsiDFDJ(:,:,igauss)';
    derivatives.D2Psi.D2PsiDJDH(:,:,igauss)    =  derivatives.D2Psi.D2PsiDHDJ(:,:,igauss)';
    derivatives.D2Psi.D2PsiDJDJ(igauss)        =  derivatives.D2Uhat.D2UDJDJ(igauss) - ...
                                                  derivatives.D2Uhat.D2UDJDD0(:,:,igauss)*derivatives.D2Psi.D2PsiDE0DJ(:,:,igauss);
end


