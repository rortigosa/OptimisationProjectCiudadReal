%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% 1. Equivalent stiffness matrices and residual vectors after static
% condensation in the mixed formulations with variables: (F,H,J,D0,d), 
% (SigmaF,SigmaH,SigmaJ,Sigmad) and p for 3D
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function assembly  =  ResidualStiffnessStaticCondensFHJ(assembly)  
%--------------------------------------------------------------------------
% B. Compute modified stiffness matrices
%--------------------------------------------------------------------------
dofF               =  size(assembly.TF,1);
dofH               =  size(assembly.TH,1);
dofJ               =  size(assembly.TJ,1); 
%--------------------------------------------------------------------------
% KxSigma  
%--------------------------------------------------------------------------
KxSigma            =  [assembly.KxSigmaF  assembly.KxSigmaH  assembly.KxSigmaJ];
%KSigmax            =  KxSigma';
%--------------------------------------------------------------------------
% KDSigma
%--------------------------------------------------------------------------
%KDSigma           =  [[assembly.KFSigmaF  zeros(dofF,dofH)    zeros(dofF,dofJ)];...
%                      [zeros(dofH,dofF)   assembly.KHSigmaH   zeros(dofH,dofJ)];...
%                      [zeros(dofJ,dofF)   zeros(dofJ,dofH)    assembly.KJSigmaJ]];
%KSigmaD           =  KDSigma';     
%KDSigmainv        =  [[assembly.KFSigmaF\eye(dofF)  zeros(dofF,dofH)              zeros(dofF,dofJ)];...
%                      [zeros(dofH,dofF)             assembly.KHSigmaH\eye(dofH)   zeros(dofH,dofJ)];...
%                      [zeros(dofJ,dofF)             zeros(dofJ,dofH)              assembly.KJSigmaJ\eye(dofJ)]];
%KSigmaDinv        =  KDSigmainv';
%--------------------------------------------------------------------------
% KDD 
%--------------------------------------------------------------------------
KDD                =  [[assembly.KFF      assembly.KFH      assembly.KFJ];...
                       [assembly.KFH'     assembly.KHH      assembly.KHJ];...
                       [assembly.KFJ'     assembly.KHJ'     assembly.KJJ]];
%--------------------------------------------------------------------------
% Reduced assembly matrix  
%--------------------------------------------------------------------------
%MDu               =  -KSigmaD\KSigmax;
%MDu               =  -KSigmaDinv*KSigmax;
MDu                =   [(assembly.KFSigmaF')\assembly.KxSigmaF';...
                        (assembly.KHSigmaH')\assembly.KxSigmaH';...
                        (assembly.KJSigmaJ')\assembly.KxSigmaJ'];      


%Mstar             =  KDSigma\eye(size(KDSigma,1));
%Mstar             =  KDSigmainv;
%MSigmau           =  -Mstar*KDD*MDu;
assembly.Kxx       =  assembly.Kxx + MDu'*KDD*MDu;
%--------------------------------------------------------------------------
% B. Compute modified residual Ru. 
%--------------------------------------------------------------------------
TD                =  [assembly.TF; assembly.TH; assembly.TJ];
%TSigma           =  [assembly.TSigmaF; assembly.TSigmaH; assembly.TSigmaJ];
%--------------------------------------------------------------------------
% Intermediate variables
%--------------------------------------------------------------------------
%TDstar           =  -(KSigmaD\TSigma);
%TDstar           =  -KSigmaDinv*TSigma;
TDstar            =  [(assembly.KFSigmaF')*assembly.TSigmaF;...
                      (assembly.KHSigmaH')*assembly.TSigmaF;...
                      (assembly.KJSigmaJ')*assembly.TSigmaJ];
R                 =  TD + KDD*TDstar;                  
TSigmastar        =  -[assembly.KFSigmaF\R(1:dofF);...
                       assembly.KHSigmaH\R(dofF+1:dofF+dofH);...
                       assembly.KJSigmaJ\R(dofF+dofH+1:dofF+dofH+dofJ)];
%--------------------------------------------------------------------------
% Modified residuals 
%--------------------------------------------------------------------------                                                                                                                                                                              
assembly.Tx       =  assembly.Tx   + KxSigma*TSigmastar;


