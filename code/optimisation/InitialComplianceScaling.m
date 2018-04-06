%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the normalisation factor for the compliance
% function
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function E0             =  InitialComplianceScaling(str,xPhys)


str.data.nonlinearity   =  'nonlinear';
str.data.language       =  'CMex';
%--------------------------------------------------------------------------
% EQUILIBRIUM PROBLEM: COMPUTE DISPLACEMENTS (u)   
%--------------------------------------------------------------------------  
str.mat_info.optimisation.rho   =  xPhys;
str             =  LinearSolver(str);
u               =  str.solution.x.Eulerian_x(:) - str.solution.x.Lagrangian_X(:);
E0              =  (str.bc.Neumann.force_vector'*u);
