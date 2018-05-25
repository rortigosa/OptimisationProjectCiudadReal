
function NR      =  UserDefinedNR

NR.tolerance                =  1e-6;
NR.convergence_plotting     =  0;
NR.max_load_factor          =  1;
%NR.load_increments         =  [1;10];
NR.load_increments          =  [3;30];

NR.nonlinearity             =  'nonlinear';
NR.nonlinearity             =  'arclength';
%NR.nonlinearity             =  'linearised_arclength';
%NR.nonlinearity             =  'linearised_convexified';
NR.instability_load_incr    =  10;
NR.critical_load            =  1;