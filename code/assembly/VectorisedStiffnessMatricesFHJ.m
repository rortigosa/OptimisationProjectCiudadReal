function  vectorised   =  VectorisedStiffnessMatricesFHJ(igauss,BFx,SigmaJ,QF,QSigmaH,Hxv,fem,...
                                                               D2U)
%--------------------------------------------------------------------------
% Transpose of matrices
%--------------------------------------------------------------------------
BFxT                   =  BFx';
BHx                    =  QF*BFx;
BHxT                   =  BHx';
BJx                    =  Hxv'*BFx;
BJxT                   =  BJx';
%--------------------------------------------------------------------------
% Stiffness matrices for Kxx
%--------------------------------------------------------------------------
vectorised.Kxx         =  BFxT*QSigmaH*BFx + SigmaJ*(BFxT*(QF*BFx));
%--------------------------------------------------------------------------
% Stiffness matrices for KxSigmaF, KxSigmaH, KxSigmaJ, KxSigmad
%--------------------------------------------------------------------------
vectorised.KxSigmaF    =  BFxT*fem.F.N_vectorised(:,:,igauss);
vectorised.KxSigmaH    =  BHxT*fem.H.N_vectorised(:,:,igauss);
vectorised.KxSigmaJ    =  BJxT*fem.J.N(:,igauss);
%--------------------------------------------------------------------------
% Matrices KFF, KFH,...
%--------------------------------------------------------------------------
vectorised.KFF         =  fem.F.N_vectorised(:,:,igauss)'*D2U.D2UDFDF(:,:,igauss)*fem.F.N_vectorised(:,:,igauss);
vectorised.KFH         =  fem.F.N_vectorised(:,:,igauss)'*D2U.D2UDFDH(:,:,igauss)*fem.H.N_vectorised(:,:,igauss);
vectorised.KFJ         =  fem.F.N_vectorised(:,:,igauss)'*D2U.D2UDFDJ(:,:,igauss)*fem.J.N(:,igauss);

vectorised.KHH         =  fem.H.N_vectorised(:,:,igauss)'*D2U.D2UDHDH(:,:,igauss)*fem.H.N_vectorised(:,:,igauss);
vectorised.KHJ         =  fem.H.N_vectorised(:,:,igauss)'*D2U.D2UDHDJ(:,:,igauss)*fem.J.N(:,igauss);

vectorised.KJJ         =  fem.J.N(igauss)'*D2U.D2UDJDJ(igauss)*fem.J.N(:,igauss);
%--------------------------------------------------------------------------
% Matrices KFSigmaF, KHSigmaH, KJSigmaJ
%--------------------------------------------------------------------------
vectorised.KFSigmaF    =  -fem.F.N_vectorised(:,:,igauss)'*fem.F.N_vectorised(:,:,igauss);
vectorised.KHSigmaH    =  -fem.H.N_vectorised(:,:,igauss)'*fem.H.N_vectorised(:,:,igauss);
vectorised.KJSigmaJ    =  -fem.J.N(igauss)*fem.J.N(igauss);

