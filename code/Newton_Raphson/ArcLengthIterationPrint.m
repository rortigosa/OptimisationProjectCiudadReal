%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function prints the value of the residual, the acumulated factor
%  and the load factor for the current Newton-Raphson iteration
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function ArcLengthIterationPrint(NR,Residual_dimensionless,AL)

fprintf('Iteration: %d,  Load Incr: %d,  Residual: %12.5f,  Acc Factor: %f,  Radius: %12.5f',NR.iteration,NR.incr_load,Residual_dimensionless,NR.accumulated_factor,AL.radius)
fprintf('\n--------------------------------------------------------------------\n')
