%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function prints the value of the residual, the acumulated factor
%  and the load factor for the current Newton-Raphson iteration
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function ArcLengthIterationPrint(NR,Residual_dimensionless,AL)

fprintf('Load Incr: %d, Iteration: %d,  Residual: %f,  Acc Factor: %f,  Radius: %f\n',AL.iteration,NR.iteration,Residual_dimensionless,NR.accumulated_factor,AL.radius)
