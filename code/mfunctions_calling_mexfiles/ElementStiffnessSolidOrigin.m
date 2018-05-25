%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function computes the stiffness matrix for an element in the purely
%  nonlinear elastic region but in the origin (no deformations)
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [Kxx,Elasticity]     =  ElementStiffnessSolidOrigin(FEM,Solution,Mesh,...
                                                Quadrature,MatInfo,Geometry)

DN_chi           =  FEM.volume.bilinear.x.DN_chi;
X                =  Solution.x.Lagrangian_X;
connectivity     =  Mesh.volume.x.connectivity;
IntWeight        =  Quadrature.volume.bilinear.IntWeight;
%--------------------------------------------------------------------------
% Kinematics
%--------------------------------------------------------------------------
[F,H,J,DNX,~]    =  KinematicsFunctionMexC(X(:,connectivity(:,1)),...
                                     X(:,connectivity(:,1)),DN_chi,IntWeight);
%--------------------------------------------------------------------------
% Compute Piola and the Elasticity tensor for the nonlinear model
%--------------------------------------------------------------------------
[~,Elasticity]   =  ConstitutiveModels(Geometry.PlaneStress,MatInfo,F,H,J);
%--------------------------------------------------------------------------
% Compute the stiffness matrix for the nonlinear model 
%--------------------------------------------------------------------------
Kxx              =  TangentOperatorUFormulationMexC(DNX,Elasticity,IntWeight);



