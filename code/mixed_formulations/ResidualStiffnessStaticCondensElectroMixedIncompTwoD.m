%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% 1. Equivalent stiffness matrices and residual vectors after static
% condensation in the mixed formulations with variables: (F,H,J,D0,d), 
% (SigmaF,SigmaH,SigmaJ,Sigmad) and p for 3D
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function assembly  =  ResidualStiffnessStaticCondensElectroMixedIncompTwoD(assembly)  
%--------------------------------------------------------------------------
% B. Compute modified stiffness matrices
%--------------------------------------------------------------------------
dofF               =  size(assembly.TF,1);
dofJ               =  size(assembly.TJ,1); 
dofD0              =  size(assembly.TD0,1); 
dofd               =  size(assembly.Td,1); 
%--------------------------------------------------------------------------
% KxSigma  
%--------------------------------------------------------------------------
KxSigma            =  [assembly.KxSigmaF  assembly.KxSigmaJ  assembly.KxSigmad];
KSigmax            =  KxSigma';
%--------------------------------------------------------------------------
% KDSigma
%--------------------------------------------------------------------------
KDSigma            =  [[assembly.KFSigmaF  zeros(dofF,dofJ)       zeros(dofF,dofd)];...
                       [zeros(dofJ,dofF)   assembly.KJSigmaJ      zeros(dofJ,dofd)];...
                       [zeros(dofd,dofF)   zeros(dofd,dofJ)       assembly.KdSigmad]];
KSigmaD            =  KDSigma';                                                   
%--------------------------------------------------------------------------
% KDD0
%--------------------------------------------------------------------------
KDD0               =  [KFD0;  KJD0;  KdD0];
KD0D               =  KDD0';
%--------------------------------------------------------------------------
% KDD 
%--------------------------------------------------------------------------
KDD                =  [[assembly.KFF      assembly.KFJ     assembly.KFd];...
                       [assembly.KFJ'     assembly.KJJ     assembly.KJd];...
                       [assembly.KFd'     assembly.KJd'    assembly.Kdd]];
%--------------------------------------------------------------------------
% KSigmaD0
%--------------------------------------------------------------------------
KSigmaD0           =  [zeros(dofF,dofD0);  zeros(dofJ,dofD0);  KSigmadD0];
KD0Sigma           =  KSigmaD0';
%--------------------------------------------------------------------------
% Reduced assembly matrix  
%--------------------------------------------------------------------------
MDu                =  -KSigmaD\KSigmax;
M1star             =  (assembly.KD0D0 - KD0D*(assembly.KSigmaD\KSigmaD0))\eye(size(assembly.KD0D0,1));
M2star             =  (KDD0 - KDD*(KSigmaD\KSigmaD0));
M3star             =  (KDSigma - M2star*M1star*KD0Sigma)\eye(size(KDSigma,1));

MSigmau            =  -M3star*(KDD*MDu - M2star*M1star*(assembly.KxD0' + assembly.KD0D*MDu));
MSigmaphi          =  M3star*M2star*M1star*assembly.KD0phi;
MD0ustarstar       =  -M1star*(KD0Sigma*MSigmau + assembly.KD0x + KD0D*MDu);
MD0phistarstar     =  -M1star*(KD0Sigma*MSigmaphi + assembly.KD0phi);
 
assembly.Kxx       =  assembly.Kxx + KxSigma*MSigmau + assembly.KxD0*MD0ustarstar;
assembly.Kxphi     =  (KxSigma*MSigmaphi + assembly.KxD0*MD0phistarstar);
assembly.Kphix     =  assembly.KphiD0*MD0ustarstar;
assembly.Kphiphi   =  assembly.KphiD0*MD0phistarstar;
%--------------------------------------------------------------------------
% B. Compute modified residual Ru. 
%--------------------------------------------------------------------------
TD                =  [assembly.TF; assembly.TJ; assembly.Td];
TSigma            =  [assembly.TSigmaF; assembly.TSigmaJ; assembly.TSigmad];
%--------------------------------------------------------------------------
% Intermediate variables
%--------------------------------------------------------------------------
TDstar            =  -(KSigmaD\TSigma);
TSigmastar        =  -M3star*(TD + KDD*TDstar - M2star*M1star*(assembly.TD0 + KD0D*TDstar));
TD0starstar       =  -M1star*(assembly.TD0 + KD0D*TDstar + KD0Sigma*TSigmastar);
%--------------------------------------------------------------------------
% Modified residuals
%--------------------------------------------------------------------------                                                                                                                                                                              
assembly.Tx       =  assembly.Tx   + KxSigma*TSigmastar + assembly.KxD0*TD0starstar;
assembly.Tphi     =  assembly.Tphi + assembly.KphiD0*TD0starstar;


