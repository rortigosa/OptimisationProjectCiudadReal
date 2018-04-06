%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Vectorised Stiffness matrix  for the 3D formulation with
% fields:  x-phi-p
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function  vectorised   =  VectorisedStiffnessMatricesElectroThreeD(igauss,BFx,DN_X_phi,D2Psi,DU,...
                                                                QF,QSigmaH,H)
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
geometric              =  (BFxT*QSigmaH*BFx) + DU.DUDJ(igauss)*(BFxT*BHx);
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
