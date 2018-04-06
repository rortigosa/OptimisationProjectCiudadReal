%--------------------------------------------------------------------------
%
% Solver for linearised elasticity in increments (for unstable solutions)
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function str                    =  ConvexifiedLinearisedSolver(str,initialisation)

%--------------------------------------------------------------------------
% Select the new nonlinear solver
%--------------------------------------------------------------------------
nonlinear_solver                =  str.data.nonlinearity;
str.data.nonlinearity           =  'convexified_linearised';
%--------------------------------------------------------------------------
% Initialisation
%--------------------------------------------------------------------------
if initialisation
   %-----------------------------------------------------------------------
   % Use this number of load increments
   %-----------------------------------------------------------------------
   str.NR.accumulated_factor    =  0;
   str.NR.iteration             =  1;
   str.NR.n_incr_loads          =  str.data.instability.load_increments_instability;
   str.NR.accumulated_factor    =  0;
   str.NR.incr_load             =  0;
   %-----------------------------------------------------------------------
   % Initialisation
   %-----------------------------------------------------------------------
   str                          =  InitialisedFields(str);
end
incr_load                       =  0;
str.NR.load_factor              =  (1 - str.NR.accumulated_factor)/str.NR.n_incr_loads;



str                             =  InitialisedResiduals(str);
str                             =  TotalAssembly(str);
while str.NR.accumulated_factor<1-1e-6
    %----------------------------------------------------------------------
    % Update solution fields with those of the previous load increment                
    %----------------------------------------------------------------------
    str.solution.old            =  str.solution;      
    %----------------------------------------------------------------------
    % Incremental variables for the load increment strategy.                
    %----------------------------------------------------------------------
    incr_load                   =  incr_load + 1; 
    str.NR.accumulated_factor   =  str.NR.accumulated_factor + str.NR.load_factor;
    %----------------------------------------------------------------------    
    % Update Dirichlet boundary conditions.    
    %----------------------------------------------------------------------    
    old_solution                =  str.solution;
    str                         =  UpdateDirichletBoundaryConditions(str);
    %----------------------------------------------------------------------
    % Updated residual for the next load increment taking into account 
    % Dirichlet boundary conditions.       
    %----------------------------------------------------------------------
    str                         =  NewtonRaphsonInitialResidual(str,old_solution);
    %----------------------------------------------------------------------
    % solving system of equations
    %----------------------------------------------------------------------
    [freedof,fixdof]            =  DeterminationVariableFreeFixedDofs(str);
    str.solution                =  SolveSystemEquations(freedof,fixdof,str.assembly,str.solution);
    %----------------------------------------------------------------------
    % update the variables of the problem. corrector step.
    %----------------------------------------------------------------------
    str                         =  FieldsUpdate(str);
    %----------------------------------------------------------------------
    % update matrices and force vectors.
    %----------------------------------------------------------------------
    str                         =  TotalAssembly(str);
    str                         =  NewtonRaphsonResidualUpdate(str);
    %----------------------------------------------------------------------
    % Print on screen
    %----------------------------------------------------------------------
    LinearisedSolverIterationPrint(incr_load,str.NR.n_incr_loads);
end                 
%--------------------------------------------------------------------------
% Flag for stable solution
%--------------------------------------------------------------------------
str.solution.instability        =  0;
%--------------------------------------------------------------------------
% Select the original nonlinear solver
%--------------------------------------------------------------------------
str.data.nonlinearity           =  nonlinear_solver;
%--------------------------------------------------------------------------
% Plot deformed configuration
%--------------------------------------------------------------------------
%figure(3)
subplot(2,2,1)
plot(str.solution.x.Eulerian_x(1,:),str.solution.x.Eulerian_x(2,:),'o','MarkerSize',2)
hold on
axis equal
 
