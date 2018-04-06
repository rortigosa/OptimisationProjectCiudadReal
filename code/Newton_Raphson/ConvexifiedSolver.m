%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function solves the governing equations of the problem considered
%  for the static case. In addition, using an incremental approach, it
%  controls the magnitude of the loading parameter in case convergence
%  problems are encountered
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str                  =  ConvexifiedSolver(str)

%--------------------------------------------------------------------------
% Initialise residuals and stiffness matrices (total assembly)
%--------------------------------------------------------------------------
str                            =  InitialisationFormulation(str);
str                            =  InitialisedResiduals(str);
str                            =  TotalAssembly(str);  %  First assembly
%--------------------------------------------------------------------------
%  Start the Newton-Raphson
%--------------------------------------------------------------------------
str.NR.convergence_warning     =  1; 
str.NR.n_incr_loads            =  str.data.instability.load_increments;
str.NR.accumulated_factor      =  0;
str.NR.incr_load               =  0;
str.NR.load_factor             =  1/str.NR.n_incr_loads; 
%--------------------------------------------------------------------------
% Newton-Raphson
%--------------------------------------------------------------------------
str                            =  NewtonRaphson(str);
%--------------------------------------------------------------------------
% Flag for stable solution
%--------------------------------------------------------------------------
str.solution.instability       =  0;
%--------------------------------------------------------------------------
% Plot configuration
%--------------------------------------------------------------------------
figure(3)
plot(str.solution.x.Eulerian_x(1,:),str.solution.x.Eulerian_x(2,:),'o','MarkerSize',2)
hold on
axis equal

