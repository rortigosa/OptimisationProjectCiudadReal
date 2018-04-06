function DIDrho  =  SensitityOptimisationEnergy(x_elem,X_elem,DNX,IntWeight,mat_parameters,...
                             Klinear,void_factor,diff_rho_p)

%--------------------------------------------------------------------------
% Kinematics
%--------------------------------------------------------------------------
[F,H,J]          =  KinematicsFunctionFinalMexC(x_elem,X_elem,DNX);
%--------------------------------------------------------------------------
% Determine if linear elasticity or nonlinear elasticity shall be applied
% on the current element
%--------------------------------------------------------------------------
u                =  x_elem - X_elem;
%--------------------------------------------------------------------------
% Linear energy
%--------------------------------------------------------------------------
Wlinear          =  0.5*(u(:)'*(void_factor*Klinear*u(:)));
%--------------------------------------------------------------------------
% Nonlinear energy
%--------------------------------------------------------------------------
Wnonlinear       =  MooneyRivlinEnergyMexC(mat_parameters.Mooney_Rivlin.mu1,...
                                   mat_parameters.Mooney_Rivlin.mu2,...
                                   mat_parameters.Mooney_Rivlin.lambda,F,H,J);
Wnonlinear       =  FEMScalarIntegralMexC(Wnonlinear,IntWeight);
%--------------------------------------------------------------------------
% Derivative
%--------------------------------------------------------------------------
DIDrho           =  diff_rho_p*(Wnonlinear - Wlinear);


