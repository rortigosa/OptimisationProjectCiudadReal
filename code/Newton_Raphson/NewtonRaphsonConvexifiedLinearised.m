%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Solver for linearised elasticity in increments (for unstable solutions)
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str                    =  NewtonRaphsonConvexifiedLinearised(str,Iteration)

%--------------------------------------------------------------------------
%  Start the Newton-Raphson
%--------------------------------------------------------------------------
old_solution                 =  str.solution;
str.NR.convergence_warning   =  1; 
str.NR.convergence_warning   =  1;
str.NR.n_incr_loads          =  str.data.instability.load_increments(end);
str.NR.accumulated_factor    =  0;
str.NR.incr_load             =  0;
str.NR.load_factor           =  1/str.NR.n_incr_loads;
str.NR.max_load_factor       =  1;
%--------------------------------------------------------------------------
% Load the initial solution 
%--------------------------------------------------------------------------
str.solution                 =  old_solution;
%--------------------------------------------------------------------------
% Initialise residuals and stiffness matrices (total assembly)
%--------------------------------------------------------------------------
str                          =  InitialisedResiduals(str);
str                          =  TotalAssembly(str);  %  First assembly
%--------------------------------------------------------------------------
% Newton-Raphson
%--------------------------------------------------------------------------
str                          =  NewtonRaphson(str);
%--------------------------------------------------------------------------
% Flag for stable solution
%--------------------------------------------------------------------------
str.solution.instability     =  1;
%--------------------------------------------------------------------------
% Plot deformed configuration
%--------------------------------------------------------------------------
%figure(3)
subplot(2,2,1)
plot(str.solution.x.Eulerian_x(1,:),str.solution.x.Eulerian_x(2,:),'o','MarkerSize',2)
hold on
axis equal
%--------------------------------------------------------------------------
% Plot unstable and stable elements
%--------------------------------------------------------------------------
str                          =  PlotUnstableElements(str,0,1,Iteration);
