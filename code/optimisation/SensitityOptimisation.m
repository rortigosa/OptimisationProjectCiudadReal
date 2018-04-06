function DIDrho     =  SensitityOptimisation(x_elem,X_elem,DNX,IntWeight,mat_parameters,...
                             p_elem,Klinear,void_factor,diff_void_factor,...
                             rho_p,diff_rho_p,rho_linear,diff_rho_linear)


[F,H,J]             =  KinematicsFunctionFinalMexC(x_elem,X_elem,DNX);
%--------------------------------------------------------------------------
% Compute Piola and the Elasticity tensor for the nonlinear model
%--------------------------------------------------------------------------
Piola               =  MooneyRivlinMexC(mat_parameters.Mooney_Rivlin.mu1,...
                                  mat_parameters.Mooney_Rivlin.mu2,...
                                  mat_parameters.Mooney_Rivlin.lambda,F,H,J);                                              
%--------------------------------------------------------------------------
% Determine if linear elasticity or nonlinear elasticity shall be applied
% on the current element
%--------------------------------------------------------------------------
u                   =  x_elem - X_elem;
%--------------------------------------------------------------------------
% Derivative
%--------------------------------------------------------------------------
linear_contribution =  p_elem(:)'*(Klinear*u(:));
DIDrho_nonlinear    =  SensitivityNonlinearMexC(Piola,p_elem,DNX,IntWeight);
DIDrho_nonlinear    =  (rho_linear*diff_rho_p       + rho_p*diff_rho_linear)*DIDrho_nonlinear;
DIDrho_linear       =  ((1 - rho_linear)*diff_rho_p - rho_p*diff_rho_linear)*linear_contribution;
DIDrho_void         =  (void_factor*diff_rho_p      - (1 - rho_p)*diff_void_factor)*linear_contribution;

DIDrho              =  -DIDrho_nonlinear - DIDrho_linear + DIDrho_void;

