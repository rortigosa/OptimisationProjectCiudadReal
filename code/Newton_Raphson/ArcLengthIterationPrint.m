%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function prints the value of the residual, the acumulated factor
%  and the load factor for the current Newton-Raphson iteration
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function ArcLengthIterationPrint(NR,Residual_dimensionless,AL)

fprintf('current newton-raphson iteration is %d for load increment %d\n',NR.iteration,NR.incr_load)
fprintf('the residual is %12.5e\n',Residual_dimensionless);
fprintf('the total acumulated load factor is %f\n',NR.accumulated_factor)
fprintf('the radius is %12.5e\n',AL.radius)
fprintf('--------------------------------------------------------------------\n')
fprintf('--------------------------------------------------------------------\n\n')
