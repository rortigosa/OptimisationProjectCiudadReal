%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function prints the value of the residual, the acumulated factor
%  and the load factor for the current Newton-Raphson iteration
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function LinearisedArcLengthIterationPrint(NR,AL)



fprintf('Load Incr: %d, Acc Factor: %f,  Radius: %f\n',AL.iteration,NR.accumulated_factor,AL.radius)
