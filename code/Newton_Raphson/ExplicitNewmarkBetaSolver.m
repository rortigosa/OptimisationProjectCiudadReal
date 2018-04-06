%--------------------------------------------------------------------------
%
% Solver for linearised elasticity in increments (for unstable solutions)
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function [Solution,...
    TimeIntegrator]       =  ExplicitNewmarkBetaSolver(Data,NR,Geometry,Mesh,...
                                FEM,Quadrature,Assembly,MatInfo,Optimisation,...
                                Bc,Solution,UserDefinedFuncs,TimeIntegrator,Contact)

%--------------------------------------------------------------------------
% Mass matrix and damping matrix
%--------------------------------------------------------------------------
TimeIntegrator.RayleighCoeff  =  1000;
TimeIntegrator.Gamma          =  0.5;
Assembly                      =  MassDampingMatrix(Mesh,Geometry,Solution,...
                                 Quadrature,FEM,MatInfo,Assembly,TimeIntegrator);                                
%--------------------------------------------------------------------------
% Select Time integration parameters
%--------------------------------------------------------------------------                             
gamma                         =  TimeIntegrator.Gamma;
Dt                            =  1e-5;
TimeIntegrator.Dt             =  Dt;
                             
Assembly.total_matrix         =  2*(1-gamma)/(1+gamma)/Dt^2*Assembly.MassMatrix + ...
                                 2*gamma/(Dt*(1+gamma))*Assembly.DampingMatrix;                             
%--------------------------------------------------------------------------
% Initialisation
%--------------------------------------------------------------------------
Assembly                =  InitialisedResiduals(Solution,NR,Assembly);
Solution.old_old        =  Solution.old;
TimeStep                =  0;
NR.iteration            =  1;
%--------------------------------------------------------------------------
% The initial guess for geometry is in the undeformed config.
%--------------------------------------------------------------------------
Solution                =  InitialisedFields(Geometry,Mesh,Data.formulation);
%--------------------------------------------------------------------------
% Initialise velocity and acceleration.
%--------------------------------------------------------------------------
Solution.x.velocity           =  zeros(Geometry.dim,Mesh.volume.x.n_nodes);
Solution.x.velocity_old       =  zeros(Geometry.dim,Mesh.volume.x.n_nodes);
Solution.x.acceleration       =  zeros(Geometry.dim,Mesh.volume.x.n_nodes);
Solution.x.acceleration_old   =  zeros(Geometry.dim,Mesh.volume.x.n_nodes);
%--------------------------------------------------------------------------
% Initial acceleration
%--------------------------------------------------------------------------
Solution                      =  InitialAcceleration(Solution,Geometry,Data,Mesh,...
                                                UserDefinedFuncs,Bc,Assembly);
Solution.x.acceleration_old   =  Solution.x.acceleration;
%--------------------------------------------------------------------------
% Energy Criterion to stop the simulation
%--------------------------------------------------------------------------
EnergyCriterion  =  1;
%while EnergyCriterion 
while TimeStep<10000 
    %----------------------------------------------------------------------
    % Update solution fields with those of the previous load increment
    %----------------------------------------------------------------------
    TimeStep                =  TimeStep + 1;
    %----------------------------------------------------------------------
    % Predictor step.
    %----------------------------------------------------------------------
    Solution.x.Eulerian_x  =  Solution.x.Eulerian_x_old;
    Solution.x.velocity    =  (1/(1+gamma))*Solution.x.velocity_old + ...
                              (1-gamma)/(1+gamma)*Dt*Solution.x.acceleration_old;
    Solution.x.acceleration  =  -2/Dt/(1+gamma)*Solution.x.velocity_old - ...
                                2*(1-gamma)/(1+gamma)*Solution.x.acceleration_old;                            
    %----------------------------------------------------------------------
    % Incremental variables for the load increment strategy.
    %----------------------------------------------------------------------
    Assembly                =  FEMAssembly(Data,'~',Geometry,Mesh,...
                                        FEM,Quadrature,Assembly,MatInfo,...
                                        Optimisation,Solution,TimeIntegrator);
    %----------------------------------------------------------------------
    % Update Dirichlet boundary conditions. 
    %----------------------------------------------------------------------
    Solution          =  UpdateDirichletBoundaryConditions(Data.formulation,Solution,Bc,NR);
    %----------------------------------------------------------------------
    % update matrices and force vectors.  
    %----------------------------------------------------------------------
    Assembly          =  NewtonRaphsonResidualUpdate(Geometry.dim,Data,Mesh,UserDefinedFuncs,...
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
    Dx            =  Solution.x.Eulerian_x - Solution.x.Eulerian_x_old;
    Solution.x.velocity      =  Solution.x.velocity + ...
                                2*gamma/(Dt*(1 + gamma))*Dx;
    Solution.x.acceleration  =  Solution.x.acceleration +  2/Dt^2*((1-gamma)/(1+gamma))*Dx;
    %----------------------------------------------------------------------
    % Update values in previous time step
    %----------------------------------------------------------------------
    Solution.x.Eulerian_x_old     =  Solution.x.Eulerian_x;
    Solution.x.velocity_old       =  Solution.x.velocity;
    Solution.x.acceleration_old   =  Solution.x.acceleration;
    %----------------------------------------------------------------------
    % Print on screen 
    %----------------------------------------------------------------------
    ExplicitNewmarkBetaPrint(TimeStep);
end


asdf=98
