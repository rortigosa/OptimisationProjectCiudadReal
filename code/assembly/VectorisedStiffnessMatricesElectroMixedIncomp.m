function  vectorised   =  VectorisedStiffnessMatricesElectroMixedIncomp(igauss,BFx,SigmaJ,QF,QSigmaH,pressure,fem,...
                                                                    D0_matrix,Sigmad_matrix,DN_X_phi,D2U,Fx,Hxv)
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
vectorised.Kxx         =  BFxT*QSigmaH*BFx + (SigmaJ + pressure)*(BFxT*(QF*BFx));
%--------------------------------------------------------------------------
% Stiffness matrices for KxSigmaF, KxSigmaH, KxSigmaJ, KxSigmad
%--------------------------------------------------------------------------
vectorised.KxSigmaF    =  BFxT*fem.F.N_vectorised(:,:,igauss);
vectorised.KxSigmaH    =  BHxT*fem.H.N_vectorised(:,:,igauss);
vectorised.KxSigmaJ    =  BJxT*fem.J.N(:,igauss);
vectorised.KxSigmad    =  BFxT*D0_matrix'*fem.d.N_vectorised(:,:,igauss);
vectorised.KxD0        =  BFxT*Sigmad_matrix'*fem.D0.N_vectorised(:,:,igauss);
%--------------------------------------------------------------------------
% Stiffness matrices for Kphiphi
%--------------------------------------------------------------------------
vectorised.KphiD0      =  DN_X_phi'*fem.D0.N_vectorised(:,:,igauss);
%--------------------------------------------------------------------------
% Matrices for incompressibility
%--------------------------------------------------------------------------
vectorised.Kpx         =  fem.pressure.N(:,igauss)*(BJx);
vectorised.Kpp         =  zeros(size(fem.pressure.N,1));
vectorised.Kxp         =  vectorised.Kpx';
%--------------------------------------------------------------------------
% Matrices KFF, KFH,...
%--------------------------------------------------------------------------
vectorised.KFF         =  fem.F.N_vectorised(:,:,igauss)'*D2U.D2UDFDF(:,:,igauss)*fem.F.N_vectorised(:,:,igauss);
vectorised.KFH         =  fem.F.N_vectorised(:,:,igauss)'*D2U.D2UDFDH(:,:,igauss)*fem.H.N_vectorised(:,:,igauss);
vectorised.KFJ         =  fem.F.N_vectorised(:,:,igauss)'*D2U.D2UDFDJ(:,:,igauss)*fem.J.N(:,igauss);
vectorised.KFD0        =  fem.F.N_vectorised(:,:,igauss)'*D2U.D2UDFDD0(:,:,igauss)*fem.D0.N_vectorised(:,:,igauss);
vectorised.KFd         =  fem.F.N_vectorised(:,:,igauss)'*D2U.D2UDFDd(:,:,igauss)*fem.d.N_vectorised(:,:,igauss);

vectorised.KHH         =  fem.H.N_vectorised(:,:,igauss)'*D2U.D2UDHDH(:,:,igauss)*fem.H.N_vectorised(:,:,igauss);
vectorised.KHJ         =  fem.H.N_vectorised(:,:,igauss)'*D2U.D2UDHDJ(:,:,igauss)*fem.J.N(:,igauss);
vectorised.KHD0        =  fem.H.N_vectorised(:,:,igauss)'*D2U.D2UDHDD0(:,:,igauss)*fem.D0.N_vectorised(:,:,igauss);
vectorised.KHd         =  fem.H.N_vectorised(:,:,igauss)'*D2U.D2UDHDd(:,:,igauss)*fem.d.N_vectorised(:,:,igauss);

vectorised.KJJ         =  fem.J.N(igauss)'*D2U.D2UDJDJ(igauss)*fem.J.N(:,igauss);
vectorised.KJD0        =  fem.J.N(igauss)'*D2U.D2UDJDD0(:,:,igauss)*fem.D0.N_vectorised(:,:,igauss);
vectorised.KJd         =  fem.J.N(igauss)'*D2U.D2UDJDd(:,:,igauss)*fem.d.N_vectorised(:,:,igauss);

vectorised.KD0D0       =  fem.D0.N_vectorised(:,:,igauss)'*D2U.D2UDD0DD0(:,:,igauss)*fem.D0.N_vectorised(:,:,igauss);
vectorised.KD0d        =  fem.D0.N_vectorised(:,:,igauss)'*D2U.D2UDD0Dd(:,:,igauss)*fem.d.N_vectorised(:,:,igauss);

vectorised.Kdd         =  fem.d.N_vectorised(:,:,igauss)'*D2U.D2UDdDd(:,:,igauss)*fem.d.N_vectorised(:,:,igauss);
%--------------------------------------------------------------------------
% Matrices KFSigmaF, KHSigmaH, KJSigmaJ
%--------------------------------------------------------------------------
vectorised.KFSigmaF    =  -fem.F.N_vectorised(:,:,igauss)'*fem.F.N_vectorised(:,:,igauss);
vectorised.KHSigmaH    =  -fem.H.N_vectorised(:,:,igauss)'*fem.H.N_vectorised(:,:,igauss);
vectorised.KJSigmaJ    =  -fem.J.N(igauss)*fem.J.N(igauss);
vectorised.KD0Sigmad   =  fem.D0.N_vectorised(:,:,igauss)'*Fx*fem.d.N_vectorised(:,:,igauss);
vectorised.KdSigmad    =  -fem.d.N_vectorised(:,:,igauss)'*fem.d.N_vectorised(:,:,igauss);

