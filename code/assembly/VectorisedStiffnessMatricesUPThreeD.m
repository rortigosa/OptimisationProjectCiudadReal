%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Stiffness matrix in a compact matrix form for the formulation with
% fields:  x-phi-p
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function  vectorised   =  VectorisedStiffnessMatricesUPThreeD(igauss,BFx,D2U,DU,pressure,...
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
KFF                    =  BFxT*(D2U.D2UDFDF(:,:,igauss)*BFx);
KFH                    =  BFxT*(D2U.D2UDFDH(:,:,igauss)*BHx);
KFJ                    =  BFxT*(D2U.D2UDFDJ(:,:,igauss)*BJx);
KHH                    =  BHxT*(D2U.D2UDHDH(:,:,igauss)*BHx);
KHJ                    =  BHxT*(D2U.D2UDHDJ(:,:,igauss)*BJx);
KJJ                    =  BJxT*(D2U.D2UDJDJ(igauss)*BJx);
geometric              =  (BFxT*QSigmaH*BFx) + (DU.DUDJ(igauss) + pressure(igauss))*(BFxT*BHx);
vectorised.Kxx         =  KFF + KHH + KJJ + (KFH + KFH') + (KFJ + KFJ') + (KHJ + KHJ') + geometric;
%--------------------------------------------------------------------------
% Matrices for incompressibility
%--------------------------------------------------------------------------
vectorised.Kpx         =  Nshape_pressure*(BJx);
vectorised.Kxp         =  vectorised.Kpx';
vectorised.Kpp         =  zeros(size(Nshape_pressure,1));


