%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Compute elemental residuals and stiffness matrices for U formulation
% using Mex files. Combination of nonlinear and linear models
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [Rx,...
    Kxx]  =  ResidualStiffnessUFormulationMexFiles(x_elem,X_elem,...
                          DNX,IntWeight,mat_parameters,rho_p,rho_linear,...
                          Klinear,void_factor)
%--------------------------------------------------------------------------
% kinematics
%--------------------------------------------------------------------------
[F,H,J]       =  KinematicsFunctionFinalMexC(x_elem,X_elem,DNX);
%--------------------------------------------------------------------------
% Compute Piola and the Elasticity tensor for the nonlinear model
%--------------------------------------------------------------------------
[Piola,...
 Elasticity]  =  MooneyRivlinMexC(mat_parameters.mu1,mat_parameters.mu2,...
                                  mat_parameters.lambda,F,H,J);
%--------------------------------------------------------------------------
% Compute the residuals for the nonlinear model
%--------------------------------------------------------------------------
Rx            =  ResidualsUFormulationMexC(DNX,Piola,IntWeight);
%--------------------------------------------------------------------------
% Compute the stiffness matrix for the nonlinear model
%--------------------------------------------------------------------------
Kxx           =  TangentOperatorUFormulationMexC(DNX,Elasticity,IntWeight);
%--------------------------------------------------------------------------
% Compute displacements in the element
%--------------------------------------------------------------------------
u             =  x_elem - X_elem;
%--------------------------------------------------------------------------
% Determine residual and stiffness combining nonlinear and linear models
%--------------------------------------------------------------------------
Rlinear       =  Klinear*u(:);
Rx            =  rho_p*(rho_linear*Rx  + (1-rho_linear)*Rlinear) + (1 - rho_p)*(void_factor*Rlinear);
Kxx           =  rho_p*(rho_linear*Kxx + (1-rho_linear)*Klinear) + (1 - rho_p)*(void_factor*Klinear);


