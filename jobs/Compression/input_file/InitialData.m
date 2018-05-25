%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Data needed
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str                                 =  InitialData(str)

%--------------------------------------------------------------------------
%  Formulation type
%--------------------------------------------------------------------------
str.data.formulation                         =  'u';
%str.data.formulation                        =  'up';
str.data.language                            =  'MatLab';
str.data.language                            =  'CMex';
%--------------------------------------------------------------------------
%  Optimisation type
%--------------------------------------------------------------------------
str.data.optimisation.type                   =  'nodal_force_location_compliance';
%--------------------------------------------------------------------------
%  Static or dynamic analysis
%--------------------------------------------------------------------------
str.data.analysis                            =  'static';
%str.data.analysis                           =  'dynamic';
str.data.nonlinearity                       =  'nonlinear';
%str.data.nonlinearity                       =  'linearised_convexified';
%str.data.nonlinearity                       =  'nonlinear_convexified_linearised';
%str.data.nonlinearity                       =  'nonlinear_convexified';
str.data.nonlinearity                        =  'linear';
% str.data.nonlinearity                        =  'linearised';
% str.data.nonlinearity                        =  'convexified';
%str.data.nonlinearity                        =  'convexified_linearised';
%str.data.instability.solver                 =  'arc_length'; 
%str.data.instability.solver                  =  'biregion';
%str.data.instability.solver                  =  'biregion+penalty';
%str.data.instability.solver                 =  'convexified_linearised'; 
str.data.instability.solver                       =  'linearised_convexified';
%str.data.nonlinearity                       =  'linearised_convexified';
%str.data.instability.solver                  =  'penalty';
%str.data.instability.solver                  =  'linearised';
str.data.instability.load_increments         =  [1;50];
str.data.instability.load_increments_instability  =  50;
switch str.data.nonlinearity
    case {'linearised','convexified','convexified_linearised'}
   str.data.instability.load_increments               =  str.data.instability.load_increments(end);
   str.data.instability.load_increments_instability   =  str.data.instability.load_increments(end);
end
% if strcmp(str.data.instability.solver,'linearised')
%    str.data.instability.stiffness_fraction   =  1/20; 
% end
%str.data.nonlinearity                       =  'linear';
%--------------------------------------------------------------------------
%  Finite element
%--------------------------------------------------------------------------
str.fem.shape                                =  1;
str.fem.degree.x                             =  1;  %  Finite Element interpolation order for displacements
str.fem.degree.phi                           =  1;  %  Finite Element interpolation order for displacements
str.fem.degree.pressure                      =  1;  % degree of interpolation for the pressure
str.fem.shape                                =  1;  %  0 is triangular (or tetrahedral) and 1 is quadrilateral (or cubic)
str.fem.degree.postprocessing                =  1;
%--------------------------------------------------------------------------
%  Gauss integration 
%--------------------------------------------------------------------------
str.quadrature.degree                        =  1;
%--------------------------------------------------------------------------
%  Newton Raphson parameters
%--------------------------------------------------------------------------
str.NR.tolerance                              =  1e-8;
str.NR.convergence_plotting                   =  0;
str.NR.max_load_factor                        =  1;  % maximum fraction of 
                                                     % the total force that 
                                                     % the NR need to reach
%--------------------------------------------------------------------------
%  Contact information
%--------------------------------------------------------------------------
str.contact.lagrange_multiplier               =  0;
str.fem.degree.contact                        =  1;
str.contact.method                            =  'node';

%--------------------------------------------------------------------------
%  Time integrator
%--------------------------------------------------------------------------
str.time_integrator                           =  [];

