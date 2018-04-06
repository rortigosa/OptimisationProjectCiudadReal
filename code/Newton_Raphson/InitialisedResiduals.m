%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function initialises residuals
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Assembly          =  InitialisedResiduals(Solution,NR,Assembly)

Assembly.Residual          =  zeros(Solution.n_dofs,1);
Assembly.Residual_stored   =  cell(NR.n_incr_loads,1);
