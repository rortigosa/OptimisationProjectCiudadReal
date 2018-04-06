%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Stiffness matrix in a compact matrix form for the formulation with
% fields:  x-phi-p
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function  vectorised   =  VectorisedStiffnessMatricesElectroMixedIncompTwoD(igauss,BFx,SigmaJ,QF,pressure,fem,...
                                                                    D0_matrix,Sigmad_matrix,DN_X_phi,D2U,Fx)
%--------------------------------------------------------------------------
% Transpose of matrices
%--------------------------------------------------------------------------
BFxT                   =  BFx';
%--------------------------------------------------------------------------
% Stiffness matrices for Kxx
%--------------------------------------------------------------------------
vectorised.Kxx         =  (SigmaJ + pressure)*(BFxT*(QF*BFx));
%--------------------------------------------------------------------------
% Stiffness matrices for KxSigmaF, KxSigmaH, KxSigmaJ, KxSigmad
%--------------------------------------------------------------------------
vectorised.KxSigmaF    =  BFx'*fem.F.N_vectorised(:,:,igauss);
vectorised.KxSigmaJ    =  BFx'*fem.J.N(:,igauss);
vectorised.KxSigmad    =  BFx'*D0_matrix'*fem.d.N_vectorised(:,:,igauss);
vectorised.KxD0        =  BFx'*Sigmad_matrix'*fem.D0.N_vectorised(:,:,igauss);
%--------------------------------------------------------------------------
% Stiffness matrices for Kphiphi
%--------------------------------------------------------------------------
vectorised.KphiD0      =  -DN_X_phi'*fem.D0.N_vectorised(:,:,igauss);
%--------------------------------------------------------------------------
% Matrices for incompressibility
%--------------------------------------------------------------------------
vectorised.Kpx         =  fem.pressure.N(:,igauss)*(BJx);
vectorised.Kpp         =  zeros(size(fem.pressure.N,1));
%--------------------------------------------------------------------------
% Matrices KFF, KFH,...
%--------------------------------------------------------------------------
vectorised.KFF         =  fem.F.N_vectorised(:,:,igauss)'*D2U.F2UDFDF(:,:,igauss)*fem.F.N_vectorised(:,:,igauss);
vectorised.KFJ         =  fem.F.N_vectorised(:,:,igauss)'*D2U.F2UDFDJ(:,:,igauss)*fem.J.N(:,igauss);
vectorised.KFD0        =  fem.F.N_vectorised(:,:,igauss)'*D2U.F2UDFDD0(:,:,igauss)*fem.D0.N_vectorised(:,:,igauss);
vectorised.KFd         =  fem.F.N_vectorised(:,:,igauss)'*D2U.F2UDFDd(:,:,igauss)*fem.d.N_vectorised(:,:,igauss);

vectorised.KJJ         =  fem.J.N(igauss)'*D2U.F2UDJDJ(igauss)*fem.J.N(:,igauss);
vectorised.KJD0        =  fem.J.N(igauss)'*D2U.F2UDJDD0(:,:,igauss)*fem.D0.N_vectorised(:,:,igauss);
vectorised.KJd         =  fem.J.N(igauss)'*D2U.F2UDJDd(:,:,igauss)*fem.d.N_vectorised(:,:,igauss);

vectorised.KD0D0       =  fem.D0.N_vectorised(:,:,igauss)'*D2U.F2UDD0DD0(:,:,igauss)*fem.D0.N_vectorised(:,:,igauss);
vectorised.KD0d        =  fem.D0.N_vectorised(:,:,igauss)'*D2U.F2UDD0Dd(:,:,igauss)*fem.d.N_vectorised(:,:,igauss);

vectorised.Kdd         =  fem.d.N_vectorised(:,:,igauss)'*D2U.F2UDdDd(:,:,igauss)*fem.d.N_vectorised(:,:,igauss);
%--------------------------------------------------------------------------
% Matrices KFSigmaF, KHSigmaH, KJSigmaJ
%--------------------------------------------------------------------------
vectorised.KFSigmaF    =  -fem.F.N_vectorised(:,:,igauss)'*fem.F.N_vectorised(:,:,igauss);
vectorised.KJSigmaJ    =  -fem.J.N(igauss)*fem.J.N(igauss);
vectorised.KD0Sigmad   =  fem.D0.N_vectorised(:,:,igauss)'*Fx(:,:,igauss)*fem.d.N_vectorised(:,:,igauss);
vectorised.KdSigmad    =  -fem.d.N_vectorised(:,:,igauss)'*fem.d.N_vectorised(:,:,igauss);


