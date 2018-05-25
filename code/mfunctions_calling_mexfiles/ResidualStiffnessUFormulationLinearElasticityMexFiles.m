%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Compute elemental residuals and stiffness matrices for U formulation
% using Mex files. Combination of nonlinear and linear models
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [Rx,...
    Kxx]  =  ResidualStiffnessUFormulationLinearElasticityMexFiles(x_elem,X_elem,...
                          density,Klinear,Klinear_void)
%--------------------------------------------------------------------------
% Compute displacements in the element
%--------------------------------------------------------------------------
u             =  x_elem - X_elem;
%--------------------------------------------------------------------------
% Determine residual and stiffness combining nonlinear and linear models
%--------------------------------------------------------------------------
Rx            =  density*(Klinear*u(:)) + (1 - density)*(Klinear_void*u(:));
Kxx           =  density*Klinear + (1 - density)*Klinear_void;


