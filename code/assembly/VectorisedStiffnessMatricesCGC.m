function  vectorised   =  VectorisedStiffnessMatricesCGC(igauss,BCx,Sigmac,QC,QSigmaG,fem,...
                                                               Gxv,D2U,Sgeom)
%--------------------------------------------------------------------------
% Transpose of matrices
%--------------------------------------------------------------------------
BCxT                   =  BCx';
BGx                    =  QC*BCx;
BGxT                   =  BGx';
Bcx                    =  Gxv'*BCx;
BcxT                   =  Bcx';
%--------------------------------------------------------------------------
% Stiffness matrices for Kxx
%--------------------------------------------------------------------------
vectorised.Kxx         =  BCxT*QSigmaG*BCx + Sigmac*(BCxT*(QC*BCx)) + BCxT*Sgeom*BCx;
%--------------------------------------------------------------------------
% Stiffness matrices for KxSigmaF, KxSigmaH, KxSigmaJ, KxSigmad
%--------------------------------------------------------------------------
vectorised.KxSigmaC    =  BCxT*fem.C.N_vectorised(:,:,igauss);
vectorised.KxSigmaG    =  BGxT*fem.G.N_vectorised(:,:,igauss);
vectorised.KxSigmac    =  BcxT*fem.c.N(:,igauss);
%--------------------------------------------------------------------------
% Matrices KFF, KFH,...
%--------------------------------------------------------------------------
vectorised.KCC         =  fem.C.N_vectorised(:,:,igauss)'*D2U.D2UDCDC(:,:,igauss)*fem.C.N_vectorised(:,:,igauss);
vectorised.KCG         =  fem.C.N_vectorised(:,:,igauss)'*D2U.D2UDCDG(:,:,igauss)*fem.G.N_vectorised(:,:,igauss);
vectorised.KCc         =  fem.C.N_vectorised(:,:,igauss)'*D2U.D2UDCDc(:,:,igauss)*fem.c.N(:,igauss);

vectorised.KGG         =  fem.G.N_vectorised(:,:,igauss)'*D2U.D2UDGDG(:,:,igauss)*fem.G.N_vectorised(:,:,igauss);
vectorised.KGc         =  fem.G.N_vectorised(:,:,igauss)'*D2U.D2UDGDc(:,:,igauss)*fem.c.N(:,igauss);

vectorised.Kcc         =  fem.c.N(igauss)'*D2U.D2UDcDc(igauss)*fem.c.N(:,igauss);
%--------------------------------------------------------------------------
% Matrices KFSigmaF, KHSigmaH, KJSigmaJ
%--------------------------------------------------------------------------
vectorised.KCSigmaC    =  -fem.C.N_vectorised(:,:,igauss)'*fem.C.N_vectorised(:,:,igauss);
vectorised.KGSigmaG    =  -fem.G.N_vectorised(:,:,igauss)'*fem.G.N_vectorised(:,:,igauss);
vectorised.KcSigmac    =  -fem.c.N(igauss)*fem.c.N(igauss);

