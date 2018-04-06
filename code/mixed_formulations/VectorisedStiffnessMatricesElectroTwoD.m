%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Vectorised Stiffness matrix  for the 3D formulation with
% fields:  x-phi-p
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function  vectorised   =  VectorisedStiffnessMatricesElectroTwoD(igauss,BFx,DN_X_phi,D2Psi,DU,...
                                                                QF,H)
%--------------------------------------------------------------------------
% Transpose of matrices
%--------------------------------------------------------------------------
BFxT                   =  BFx';
BJx                    =  reshape(H',[],1)'*BFx;
BJxT                   =  BJx';
%--------------------------------------------------------------------------
% Stiffness matrices for Kxx
%--------------------------------------------------------------------------
KFF                    =  BFxT*(D2Psi.D2PsiDFDF(:,:,igauss)*BFx);
KFJ                    =  BFxT*(D2Psi.D2PsiDJDF(:,:,igauss)*BJx);
KJJ                    =  BJxT*(D2Psi.D2PsiDJDJ(igauss)*BJx);
geometric              =  DU.DUDJ(igauss)*(BFxT*(QF*BFx));
vectorised.Kxx         =  KFF + KJJ + (KFJ + KFJ') + geometric;
%--------------------------------------------------------------------------
% Stiffness matrices for Kphiphi
%--------------------------------------------------------------------------
vectorised.Kphiphi     =  DN_X_phi'*(D2Psi.D2PsiDE0DE0(:,:,igauss)*DN_X_phi);
%--------------------------------------------------------------------------
% Stiffness matrices for Kphix
%--------------------------------------------------------------------------
vectorised.Kphix       =  DN_X_phi'*(D2Psi.D2PsiDFDE0(:,:,igauss)*BFx + ...
                                     D2Psi.D2PsiDJDE0(:,:,igauss)*BJx);
vectorised.Kxphi       =  vectorised.Kphix';                                                
