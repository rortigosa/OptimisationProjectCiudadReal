
function NR      =  UserDefinedNR

NR.tolerance                =  1e-8;
NR.convergence_plotting     =  0;
NR.max_load_factor          =  1;
%NR.load_increments         =  [1;10];
NR.load_increments          =  30;

NR.nonlinearity             =  'nonlinear';
NR.nonlinearity             =  'linearised_convexified';
NR.instability_load_incr    =  30;