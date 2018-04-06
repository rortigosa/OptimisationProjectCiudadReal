function K  =  ResidualsStiffnessCVersion(xelem,Xelem,DNchi,mu1,mu2,lambda,BC_LHSC,BC_RHSC,n_node_elem,ngauss,dim,Weight)
%--------------------------------------------------------------------------
% Compute parent gradients and DetDXChi
%--------------------------------------------------------------------------
[DNX,DetDXChi]  =  ParentGradientsMexC(xelem,Xelem,DNchi);
%--------------------------------------------------------------------------
% Compute weights for quadrature integration
%--------------------------------------------------------------------------
IntWeight       =  WeightsIntegrationMexC(DetDXChi,Weight);
%--------------------------------------------------------------------------
% Compute kinematics 
%--------------------------------------------------------------------------
[F,C,G,detC]      =  KinematicsCMexC(xelem,Xelem,DNX);
%--------------------------------------------------------------------------
% Compute first and second derivatives of the Mooney-Rivlin model
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Compute first Piola-Kirchhoff stress tensor
%--------------------------------------------------------------------------
[P,S,Elasticity]     =  MooneyRivlinModelCMexC(mu1,mu2,lambda,F,C,G,detC);
%--------------------------------------------------------------------------
% Compute Bmatrices   
%--------------------------------------------------------------------------
BC        =  BmatricesCMexC(DNX,BC_LHSC,BC_RHSC);
% %--------------------------------------------------------------------------
% % Stiffness Matrix  
% %--------------------------------------------------------------------------
Kcons         =  StiffnessMatricesDBCMexC(dim,ngauss,n_node_elem,BC,Elasticity,IntWeight);
Kgeom         =  GeometricStiffnessCMexC(DNX,S,IntWeight);
K             =  Kcons + Kgeom;

