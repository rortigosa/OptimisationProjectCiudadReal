%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Solver for linearised elasticity in increments (for unstable solutions)
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str                    =  IncrementalLinearisedSolver(str)

%--------------------------------------------------------------------------
% Use this number of load increments
%--------------------------------------------------------------------------
str.NR.accumulated_factor       =  0; 
incr_load                       =  0;
str.NR.iteration                =  1;
str.NR.n_incr_loads             =  str.data.instability.load_increments;
str.NR.accumulated_factor       =  0;
str.NR.incr_load                =  0;
str.NR.load_factor              =  1/str.NR.n_incr_loads;
%--------------------------------------------------------------------------
% Initialisation
%--------------------------------------------------------------------------
str                             =  InitialisedFields(str);
str                             =  InitialisedResiduals(str);
str                             =  TotalAssembly(str);  %  First assembly
while str.NR.accumulated_factor<1-1e-6
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
% Plot deformed configuration
%--------------------------------------------------------------------------
subplot(2,2,1)
plot(str.solution.x.Eulerian_x(1,:),str.solution.x.Eulerian_x(2,:),'o','MarkerSize',2)
hold on
axis equal
 
