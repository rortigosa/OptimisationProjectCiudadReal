%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Stiffness matrix in a compact matrix form for the formulation with
% fields:  x-phi-p
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function  vectorised   =  VectorisedStiffnessMatricesUPTwoD(igauss,BFx,D2U,DU,pressure,...
                                                                    QF,H,Nshape_pressure)
%--------------------------------------------------------------------------
% Transpose of matrices
%--------------------------------------------------------------------------
BFxT                   =  BFx';
BJx                    =  reshape(H',[],1)'*BFx;
BJxT                   =  BJx';
%--------------------------------------------------------------------------
% Stiffness matrices for Kxx
%--------------------------------------------------------------------------
KFF                    =  BFxT*(D2U.D2PsiDFDF(:,:,igauss)*BFx);
KFJ                    =  BFxT*(D2U.D2PsiDFDJ(:,:,igauss)*BJx);
KJJ                    =  BJxT*(D2U.D2PsiDJDJ(igauss)*BJx);
geometric              =  (DU.DUDJ(igauss) + pressure(igauss))*(BFxT*(QF*BFx0));
vectorised.Kxx         =  KFF + KJJ + (KFJ + KFJ') + geometric;
%--------------------------------------------------------------------------
% Matrices for incompressibility
%--------------------------------------------------------------------------
vectorised.Kpx         =  Nshape_pressure(:,igauss)*(BJx);
vectorised.Kxp         =  local_assembly.Kpx';
vectorised.Kpp         =  zeros(size(Nshape_pressure,1));


