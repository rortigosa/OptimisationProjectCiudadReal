%--------------------------------------------------------------------------
%
% Solver for linearised elasticity in increments (for unstable solutions)
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function [Solution,...
    Optimisation]       =  LinearisedConvexifiedSolver(Data,NR,Geometry,Mesh,...
                                FEM,Quadrature,Assembly,MatInfo,Optimisation,...
                                Bc,Solution,UserDefinedFuncs,TimeIntegrator,...
                                Contact,StabilisationFactor,Initialisation)

if Initialisation
   %----------------------------------------------------------------------- 
   % Initialise the stabilisation from the undeformed configuration
   %----------------------------------------------------------------------- 
   %-----------------------------------------------------------------------
   % Select the new nonlinear solver
   %-----------------------------------------------------------------------
   NR.nonlinearity         =  'linearised_convexified';
   NR.accumulated_factor   =  0;
   NR.n_incr_loads         =  NR.instability_load_incr;
   NR.load_factor          =  1/NR.n_incr_loads;
   NR.accumulated_factor   =  0;
   NR.incr_load            =  0;
   %-----------------------------------------------------------------------
   % Initialisation
   %-----------------------------------------------------------------------
   Assembly                =  InitialisedResiduals(Solution,NR,Assembly);
   Assembly                =  FEMAssembly(Data,NR.nonlinearity,Geometry,Mesh,...
                                       FEM,Quadrature,Assembly,MatInfo,Optimisation,...
                                       Solution,TimeIntegrator,StabilisationFactor);   
   incr_load               =  0;
   NR.iteration            =  1;
   accumulated_factor      =  0;
   Solution.old_old        =  Solution.old;
   %-----------------------------------------------------------------------
   % The initial guess for geometry is in the undeformed config.
   %-----------------------------------------------------------------------
   Solution      =  InitialisedFields(Geometry,Mesh,Data.formulation);
else
   %----------------------------------------------------------------------- 
   % Initialise the stabilisation from a given deformed configuration
   %----------------------------------------------------------------------- 
   %-----------------------------------------------------------------------
   % Select the new nonlinear solver
   %-----------------------------------------------------------------------
   NR.nonlinearity         =  'linearised_convexified';
   %NR.accumulated_factor  =  0;
   NR.n_incr_loads         =  NR.instability_load_incr;
   NR.load_factor          =  (1 - NR.accumulated_factor)/NR.n_incr_loads;
   %NR.accumulated_factor  =  0;
   NR.incr_load            =  0;
   %-----------------------------------------------------------------------
   % Initialisation
   %-----------------------------------------------------------------------
   %Assembly                =  InitialisedResiduals(Solution,NR,Assembly);
   %Assembly                =  FEMAssembly(Data,NR.nonlinearity,Geometry,Mesh,...
   %                                    FEM,Quadrature,Assembly,MatInfo,Optimisation,...
   %                                    Solution,TimeIntegrator,StabilisationFactor);   
   incr_load               =  0;
   NR.iteration            =  1;
   accumulated_factor      =  0;
   Solution.old_old        =  Solution.old;    
end
while accumulated_factor<1-1e-6
    %----------------------------------------------------------------------
    % Update solution fields with those of the previous load increment
    %----------------------------------------------------------------------
    incr_load           =  incr_load + 1;
    %----------------------------------------------------------------------
    % Incremental variables for the load increment strategy. 
    %----------------------------------------------------------------------
    Assembly                =  FEMAssembly(Data,NR.nonlinearity,Geometry,Mesh,...
                                        FEM,Quadrature,Assembly,MatInfo,...
                                        Optimisation,Solution,TimeIntegrator,...
                                        StabilisationFactor);
    %[Assembly,~,NIncrements] =  StabilisationTuningProcedure(Contact,Solution,Bc,NR,...
    %                                Data,Geometry,Mesh,FEM,Quadrature,Assembly,...
    %                                MatInfo,Optimisation,TimeIntegrator,'Solution');                                    
    %NR.load_factor          =  min((1 - accumulated_factor),1/NIncrements);                             
    NR.accumulated_factor   =  NR.accumulated_factor + NR.load_factor;
    accumulated_factor      =  NR.accumulated_factor;
    %----------------------------------------------------------------------
    % Update Dirichlet boundary conditions.   
    %----------------------------------------------------------------------
    Solution.old_old  =  Solution.old;
    Solution.old      =  Solution;
    Solution.old      =  rmfield(Solution.old,'old');
    Solution.old      =  rmfield(Solution.old,'old_old');
    Solution          =  UpdateDirichletBoundaryConditions(Data.formulation,Solution,Bc,NR);
    %----------------------------------------------------------------------
    % update matrices and force vectors.
    %----------------------------------------------------------------------
    Assembly      =  NewtonRaphsonResidualUpdate(Geometry.dim,Data,Mesh,UserDefinedFuncs,...
                              Bc,Assembly,NR,TimeIntegrator);
    %----------------------------------------------------------------------
    % solving system of equations 
    %----------------------------------------------------------------------
    [freedof,...
        fixdof]   =  DeterminationVariableFreeFixedDofs(Contact,Solution,Bc,NR);
    Solution      =  SolveSystemEquations(freedof,fixdof,Assembly,Solution);
    %----------------------------------------------------------------------
    % update the variables of the problem. corrector step.
    %----------------------------------------------------------------------
    Solution      =  FieldsUpdate(Data,Geometry,Mesh,Solution,TimeIntegrator,Contact);
    %----------------------------------------------------------------------
    % Print on screen
    %----------------------------------------------------------------------
    LinearisedSolverIterationPrint(incr_load,NR.n_incr_loads,'','');    
end

%--------------------------------------------------------------------------
% Select the original nonlinear solver
%--------------------------------------------------------------------------
Solution.instability        =  1;
%--------------------------------------------------------------------------
% Output unstable elements
%--------------------------------------------------------------------------
Optimisation       =  PlotUnstableElements(Data.formulation,Optimisation,Solution,...
                                       Mesh,FEM,Quadrature,MatInfo,0,0,1);
