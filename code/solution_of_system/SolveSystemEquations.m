%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Incremental solution (for free degrees of freedom)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
function solution                       =  SolveSystemEquations(freedof,fixdof,assembly,solution)

reduced_matrix                          =  assembly.total_matrix;
reduced_matrix(fixdof,:)                =  [];
reduced_matrix(:,fixdof)                =  [];
%--------------------------------------------------------------------------
% Incremental solution
%--------------------------------------------------------------------------
solution.incremental_solution(freedof)  =  -reduced_matrix\assembly.Residual(freedof,1); 
