%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Stiffness matrix in a compact matrix form for the formulation with
% fields:  x-phi-p
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function  vectorised   =  VectorisedStiffnessMatricesElectroIncompressibleTwoD(igauss,BFx,DN_X_phi,D2Psi,DU,pressure,...
                                                                    QF,H,Nshape_pressure)
%--------------------------------------------------------------------------
% Transpose of matrices
%--------------------------------------------------------------------------
BFxT                   =  BFx';
BHx                    =  QF*BFx;
BJx                    =  reshape(H',[],1)'*BFx;
BJxT                   =  BJx';
%--------------------------------------------------------------------------
% Stiffness matrices for Kxx
%--------------------------------------------------------------------------
KFF                    =  BFxT*(D2Psi.D2PsiDFDF(:,:,igauss)*BFx);
KFJ                    =  BFxT*(D2Psi.D2PsiDFDJ(:,:,igauss)*BJx);
KJJ                    =  BJxT*(D2Psi.D2PsiDJDJ(igauss)*BJx);
geometric              =  (DU.DUDJ(igauss) + pressure(igauss))*(BFxT*BHx);
vectorised.Kxx         =  KFF + KJJ + (KFJ + KFJ') + geometric;
%--------------------------------------------------------------------------
% Stiffness matrices for Kphiphi
%--------------------------------------------------------------------------
vectorised.Kphiphi     =  DN_X_phi'*(D2Psi.D2PsiDE0DE0(:,:,igauss)*DN_X_phi);
%--------------------------------------------------------------------------
% Stiffness matrices for Kphix
%--------------------------------------------------------------------------
vectorised.Kphix       =  DN_X_phi'*(D2Psi.D2PsiDE0DF(:,:,igauss)*BFx + ...
                                     D2Psi.D2PsiDE0DJ(:,:,igauss)*BJx);
vectorised.Kxphi       =  vectorised.Kphix';                                                
%--------------------------------------------------------------------------
% Matrices for incompressibility
%--------------------------------------------------------------------------
vectorised.Kpx         =  Nshape_pressure*(BJx);
vectorised.Kxp         =  vectorised.Kpx';
vectorised.Kpp         =  zeros(size(Nshape_pressure,1));


