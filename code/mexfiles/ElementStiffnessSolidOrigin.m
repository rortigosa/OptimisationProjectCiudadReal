%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function computes the stiffness matrix for an element in the purely
%  nonlinear elastic region but in the origin (no deformations)
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Kxx     =  ElementStiffnessSolidOrigin(FEM,Solution,Mesh,...
                                                Quadrature,MatInfo)

DN_chi           =  FEM.volume.bilinear.x.DN_chi;
X                =  Solution.x.Lagrangian_X;
connectivity     =  Mesh.volume.x.connectivity;
Weight           =  Quadrature.volume.bilinear.W_v;
%--------------------------------------------------------------------------
% Kinematics
%--------------------------------------------------------------------------
[F,H,J,DNX,...
    IntWeight]  =  KinematicsFunctionMexC(X(:,connectivity(:,1)),...
                                     X(:,connectivity(:,1)),DN_chi,Weight);
%--------------------------------------------------------------------------
% Compute Piola and the Elasticity tensor for the nonlinear model
%--------------------------------------------------------------------------
[~,Elasticity]  =  MooneyRivlinMexC(MatInfo.mu1,MatInfo.mu2,...
                                    MatInfo.lambda,F,H,J);
%--------------------------------------------------------------------------
% Compute the stiffness matrix for the nonlinear model
%--------------------------------------------------------------------------
Kxx                   =  TangentOperatorUFormulationMexC(DNX,Elasticity,IntWeight);



