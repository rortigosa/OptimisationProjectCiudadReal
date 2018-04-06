%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function computes the stiffness matrix for an element in the void
%  region
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str     =  ElementStiffnessVoid(str)

DN_chi           =  str.fem.volume.bilinear.x.DN_chi;
X                =  str.solution.x.Lagrangian_X;
connectivity     =  str.mesh.volume.x.connectivity;
Weight           =  str.quadrature.volume.bilinear.W_v;
%--------------------------------------------------------------------------
% Kinematics
%--------------------------------------------------------------------------
[F,H,J,DNX,...
    IntWeight]  =  KinematicsFunctionMexC(X(:,connectivity(:,1)),...
                                     X(:,connectivity(:,1)),DN_chi,Weight);
%--------------------------------------------------------------------------
% Compute Piola and the Elasticity tensor for the nonlinear model
%--------------------------------------------------------------------------
% [Piola,...
%     Elasticity]  =  MooneyRivlinMexC(str.mat_info_void.parameters.Mooney_Rivlin.mu1,...
%                             str.mat_info_void.parameters.Mooney_Rivlin.mu2,...
%                             str.mat_info_void.parameters.Mooney_Rivlin.lambda,F,H,J);
[Piola,...
    Elasticity]  =  MooneyRivlinMexC(str.mat_info.parameters.Mooney_Rivlin.mu1,...
                            str.mat_info.parameters.Mooney_Rivlin.mu2,...
                            str.mat_info.parameters.Mooney_Rivlin.lambda,F,H,J);
%--------------------------------------------------------------------------
% Compute the stiffness matrix for the nonlinear model
%--------------------------------------------------------------------------
Kxx           =  TangentOperatorUFormulationMexC(DNX,Elasticity,IntWeight);

str.mat_info_void.Klinear  =  Kxx;

