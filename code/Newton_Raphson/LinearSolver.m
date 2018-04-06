%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Linear solver
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str                =  LinearSolver(str,load_factor)

%--------------------------------------------------------------------------
% Initialise residuals and stiffness matrices (total assembly)
%--------------------------------------------------------------------------
str                         =  InitialisationFormulation(str);
str                         =  InitialisedResiduals(str);
str                         =  TotalAssembly(str);  %  Assembly
%--------------------------------------------------------------------------
% New accumulated factor
%--------------------------------------------------------------------------
str.NR.accumulated_factor   =  0;
str.NR.load_factor          =  load_factor;
str.NR.iteration            =  1;
%--------------------------------------------------------------------------
% Solve
%--------------------------------------------------------------------------
str.NR.incr_load            =  str.NR.incr_load + 1;
str.NR.accumulated_factor   =  str.NR.accumulated_factor + str.NR.load_factor;
%--------------------------------------------------------------------------
% Update Dirichlet boundary conditions.
%--------------------------------------------------------------------------
old_solution                =  str.solution;
str                         =  UpdateDirichletBoundaryConditions(str);
%--------------------------------------------------------------------------
% Updated residual for the next load increment taking into account
% Dirichlet boundary conditions.
%--------------------------------------------------------------------------
str                         =  NewtonRaphsonInitialResidual(str,old_solution);
%--------------------------------------------------------------------------
% Solving system of equations
%--------------------------------------------------------------------------
[freedof,fixdof]            =  DeterminationVariableFreeFixedDofs(str);
str.solution                =  SolveSystemEquations(freedof,fixdof,str.assembly,str.solution);
%--------------------------------------------------------------------------
% Update the variables of the problem. corrector step.
%--------------------------------------------------------------------------
str                         =  FieldsUpdate(str);

 



