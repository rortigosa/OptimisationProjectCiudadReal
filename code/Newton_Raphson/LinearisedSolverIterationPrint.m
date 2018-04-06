%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function prints the value of the residual, the acumulated factor
%  and the load factor for the current Newton-Raphson iteration
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function LinearisedSolverIterationPrint(load_increment,n_incr_loads,n_unstable_elem,n_elem)

% fprintf('current newton-raphson iteration is %d for load increment %d\n',NR.iteration,NR.incr_load)
fprintf('Incremental iteration %d out of %d\n',load_increment,n_incr_loads);
%fprintf('Number of unstable elements %d out of %d\n',n_unstable_elem,n_elem);
% fprintf('the load factor is %12.5e\n',NR.load_factor)
% fprintf('the total acumulated load factor is %f\n',NR.accumulated_factor)
% fprintf('--------------------------------------------------------------------\n')
% fprintf('--------------------------------------------------------------------\n\n')
