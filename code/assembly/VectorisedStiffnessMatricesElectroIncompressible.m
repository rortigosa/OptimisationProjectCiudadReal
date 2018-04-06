%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Stiffness matrix in a compact matrix form for the formulation with
% fields:  x-phi-p
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function  vectorised   =  VectorisedStiffnessMatricesElectroIncompressible(igauss,BFx,DN_X_phi,D2Psi,DU,pressure,...
                                                                    QF,QSigmaH,H,Nshape_pressure)
%--------------------------------------------------------------------------
% Transpose of matrices
%--------------------------------------------------------------------------
BFxT                   =  BFx';
BHx                    =  QF*BFx;
BHxT                   =  BHx';
BJx                    =  reshape(H',[],1)'*BFx;
BJxT                   =  BJx';
%--------------------------------------------------------------------------
% Stiffness matrices for Kxx
%--------------------------------------------------------------------------
KFF                    =  BFxT*(D2Psi.D2PsiDFDF(:,:,igauss)*BFx);
KFH                    =  BFxT*(D2Psi.D2PsiDFDH(:,:,igauss)*BHx);
KFJ                    =  BFxT*(D2Psi.D2PsiDFDJ(:,:,igauss)*BJx);
KHH                    =  BHxT*(D2Psi.D2PsiDHDH(:,:,igauss)*BHx);
KHJ                    =  BHxT*(D2Psi.D2PsiDHDJ(:,:,igauss)*BJx);
KJJ                    =  BJxT*(D2Psi.D2PsiDJDJ(igauss)*BJx);
geometric              =  (BFxT*QSigmaH*BFx) + (DU.DUDJ(igauss) + pressure(igauss))*(BFxT*BHx);
vectorised.Kxx         =  KFF + KHH + KJJ + (KFH + KFH') + (KFJ + KFJ') + (KHJ + KHJ') + geometric;
%--------------------------------------------------------------------------
% Stiffness matrices for Kphiphi
%--------------------------------------------------------------------------
vectorised.Kphiphi     =  DN_X_phi'*(D2Psi.D2PsiDE0DE0(:,:,igauss)*DN_X_phi);
%--------------------------------------------------------------------------
% Stiffness matrices for Kphix
%--------------------------------------------------------------------------
vectorised.Kphix       =  DN_X_phi'*(D2Psi.D2PsiDE0DF(:,:,igauss)*BFx + ...
                                     D2Psi.D2PsiDE0DH(:,:,igauss)*BHx + ...
                                     D2Psi.D2PsiDE0DJ(:,:,igauss)*BJx);
vectorised.Kxphi       =  vectorised.Kphix';                                                
%--------------------------------------------------------------------------
% Matrices for incompressibility
%--------------------------------------------------------------------------
vectorised.Kpx         =  Nshape_pressure*(BJx);
vectorised.Kxp         =  vectorised.Kpx';
vectorised.Kpp         =  zeros(size(Nshape_pressure,1));


