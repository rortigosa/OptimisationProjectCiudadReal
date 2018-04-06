%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function prints the value of the residual, the acumulated factor
%  and the load factor for the current Newton-Raphson iteration
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function NewtonRaphsonIterationPrint(load_increment,Residual_dimensionless)

% fprintf('current newton-raphson iteration is %d for load increment %d\n',NR.iteration,NR.incr_load)
fprintf('Load increment %d. The residual is %12.5e\n',load_increment,Residual_dimensionless);
% fprintf('the load factor is %12.5e\n',NR.load_factor)
% fprintf('the total acumulated load factor is %f\n',NR.accumulated_factor)
% fprintf('--------------------------------------------------------------------\n')
% fprintf('--------------------------------------------------------------------\n\n')
