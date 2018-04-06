%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Compute p for the adjoint problem
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function p                         =  TestFunctionAdjointProblem(str)

[freedof,fixdof]                   =  DeterminationVariableFreeFixedDofs(str);
str.assembly.Residual              =  str.bc.Neumann.force_vector;
str.solution.incremental_solution  =  zeros(str.solution.n_dofs,1);
str.solution                       =  SolveSystemEquations(freedof,fixdof,str.assembly,str.solution);
p                                  =  str.solution.incremental_solution;

