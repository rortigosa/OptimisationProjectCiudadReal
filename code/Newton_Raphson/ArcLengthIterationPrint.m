%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function prints the value of the residual, the acumulated factor
%  and the load factor for the current Newton-Raphson iteration
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function ArcLengthIterationPrint(NR,Residual_dimensionless,AL,Residual)

fprintf('Load Incr: %d, Iter: %d,  Scaled Residual: %f, Residual: %1.3e  Acc Factor: %f,  Radius: %f\n',AL.iteration,NR.iteration,Residual_dimensionless,Residual,NR.accumulated_factor,AL.radius)
