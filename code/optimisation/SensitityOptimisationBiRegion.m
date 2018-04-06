%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the derivative of the objective function when an
% unstable solution has     
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function DIDrho  =  SensitityOptimisationBiRegion(xst_elem,x_elem,X_elem,DNX,IntWeight,mat_parameters,...
                             p_elem,density,Klinear,Kvoid_linear)

[F_st,H_st,...
    J_st]     =  KinematicsFunctionFinalMexC(xst_elem,X_elem,DNX);
%--------------------------------------------------------------------------
% Compute Piola and the Elasticity tensor for the nonlinear model
%--------------------------------------------------------------------------
Piola_st      =  MooneyRivlinMexC(mat_parameters.Mooney_Rivlin.mu1,...
                          mat_parameters.Mooney_Rivlin.mu2,...
                          mat_parameters.Mooney_Rivlin.lambda,F_st,H_st,J_st);                                              
%--------------------------------------------------------------------------
% Determine if linear elasticity or nonlinear elasticity shall be applied
% on the current element
%--------------------------------------------------------------------------
u_st          =  xst_elem - X_elem;
u             =  x_elem - xst_elem;
%--------------------------------------------------------------------------
% Derivative
%--------------------------------------------------------------------------
DIDrho_st     =  SensitivityNonlinearMexC(Piola_st,p_elem,DNX,IntWeight);             % Pre-buckling contribution
DIDrho_st     =  (-density*DIDrho_st + density*(p_elem(:)'*(Kvoid_linear*u_st(:))));  % Pre-buckling contribution
DIDrho_inst   =  mat_parameters.stiffness_scaling_factor*density*(p_elem(:)'*(Kvoid_linear - Klinear)*u(:)); % Post-buckling contribution
DIDrho        =  DIDrho_st + DIDrho_inst;
