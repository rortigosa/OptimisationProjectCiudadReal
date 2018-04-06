%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Initialisation of parameters for the Newton-Raphson algorithm
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function NR            =  NRInitialisation(NR)  

NR.accumulated_factor  =  0;
NR.incr_load           =  0;
NR.load_factor         =  1;
NR.max_load_factor     =  1;
NR.n_incr_loads        =  1;
