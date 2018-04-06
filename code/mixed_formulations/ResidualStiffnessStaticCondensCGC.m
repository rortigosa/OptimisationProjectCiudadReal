%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% 1. Equivalent stiffness matrices and residual vectors after static
% condensation in the mixed formulations with variables: (F,H,J,D0,d), 
% (SigmaF,SigmaH,SigmaJ,Sigmad) and p for 3D
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function assembly  =  ResidualStiffnessStaticCondensCGC(assembly)  
%--------------------------------------------------------------------------
% B. Compute modified stiffness matrices
%--------------------------------------------------------------------------
dofC               =  size(assembly.TC,1);
dofG               =  size(assembly.TG,1);
dofc               =  size(assembly.Tc,1); 
%--------------------------------------------------------------------------
% KxSigma  
%--------------------------------------------------------------------------
KxSigma            =  [assembly.KxSigmaC  assembly.KxSigmaG  assembly.KxSigmac];
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
KDD                =  [[assembly.KCC      assembly.KCG      assembly.KCc];...
                       [assembly.KCG'     assembly.KGG      assembly.KGc];...
                       [assembly.KCc'     assembly.KGc'     assembly.Kcc]];
%--------------------------------------------------------------------------
% Reduced assembly matrix  
%--------------------------------------------------------------------------
%MDu               =  -KSigmaD\KSigmax;
%MDu               =  -KSigmaDinv*KSigmax;
MDu                =   [(assembly.KCSigmaC')\assembly.KxSigmaC';...
                        (assembly.KGSigmaG')\assembly.KxSigmaG';...
                        (assembly.KcSigmac')\assembly.KxSigmac'];      


%Mstar             =  KDSigma\eye(size(KDSigma,1));
%Mstar             =  KDSigmainv;
%MSigmau           =  -Mstar*KDD*MDu;
assembly.Kxx       =  assembly.Kxx + MDu'*KDD*MDu;
%--------------------------------------------------------------------------
% B. Compute modified residual Ru. 
%--------------------------------------------------------------------------
TD                =  [assembly.TC; assembly.TG; assembly.Tc];
%TSigma           =  [assembly.TSigmaF; assembly.TSigmaH; assembly.TSigmaJ];
%--------------------------------------------------------------------------
% Intermediate variables
%--------------------------------------------------------------------------
%TDstar           =  -(KSigmaD\TSigma);
%TDstar           =  -KSigmaDinv*TSigma;
TDstar            =  [(assembly.KCSigmaC')*assembly.TSigmaC;...
                      (assembly.KGSigmaG')*assembly.TSigmaG;...
                      (assembly.KcSigmac')*assembly.TSigmac];
R                 =  TD + KDD*TDstar;                  
TSigmastar        =  -[assembly.KCSigmaC\R(1:dofC);...
                       assembly.KGSigmaG\R(dofC+1:dofC+dofG);...
                       assembly.KcSigmac\R(dofC+dofG+1:dofC+dofG+dofc)];
%--------------------------------------------------------------------------
% Modified residuals 
%--------------------------------------------------------------------------                                                                                                                                                                              
assembly.Tx       =  assembly.Tx   + KxSigma*TSigmastar;


