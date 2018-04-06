function K  =  ResidualsStiffnessFinalFVersion(xelem,Xelem,DNchi,mu1,mu2,lambda,Weight)
%--------------------------------------------------------------------------
% Compute parent gradients and DetDXChi
%--------------------------------------------------------------------------
[F,H,J,DNX,DetDXChi]  =  KinematicsFinalMexC(xelem,Xelem,DNchi);
%--------------------------------------------------------------------------
% Compute weights for quadrature integration
%--------------------------------------------------------------------------
IntWeight       =  WeightsIntegrationMexC(DetDXChi,Weight);
%--------------------------------------------------------------------------
% Compute first Piola-Kirchhoff stress tensor
%--------------------------------------------------------------------------
[P,Elasticity]  =  MooneyRivlinModelFbasedMexC(mu1,mu2,lambda,F,H,J);
%--------------------------------------------------------------------------
% Stiffness Matrix  
%--------------------------------------------------------------------------
K           =  ConstitutiveMatrixFBasedMexC7(DNX,Elasticity,IntWeight);    
