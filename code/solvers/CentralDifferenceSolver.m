%--------------------------------------------------------------------------
%
% Solver for linearised elasticity in increments (for unstable solutions)
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function [Solution,...
    Assembly,TimeIntegrator]       =  CentralDifferenceSolver(Data,NR,Geometry,Mesh,...
                                FEM,Quadrature,Assembly,MatInfo,Optimisation,...
                                Bc,Solution,UserDefinedFuncs,TimeIntegrator,Contact)

%--------------------------------------------------------------------------
% Mass matrix and damping matrix  
%--------------------------------------------------------------------------
TimeIntegrator.RayleighCoeff  =  1.1;
Assembly                      =  MassDampingMatrix(Mesh,Geometry,Solution,...
                                 Quadrature,FEM,MatInfo,Assembly,TimeIntegrator);                                
%--------------------------------------------------------------------------
% Select Time integration parameters 
%--------------------------------------------------------------------------                             
Dt                            =  6e-4;
TimeIntegrator.Dt             =  Dt;                             
Assembly.total_matrix         =  1/Dt^2*Assembly.MassMatrix + ...
                                 1/(2*Dt)*Assembly.DampingMatrix;                             
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
U0                            =  zeros(Geometry.dim,Mesh.volume.x.n_nodes);
Solution.x.Eulerian_x0        =  Solution.x.Lagrangian_X;
Solution.x.Eulerian_x00       =  Solution.x.Lagrangian_X;
Solution.x.velocity           =  zeros(Geometry.dim,Mesh.volume.x.n_nodes);
Solution.x.acceleration       =  zeros(Geometry.dim,Mesh.volume.x.n_nodes);
%--------------------------------------------------------------------------
% Initial acceleration
%--------------------------------------------------------------------------
Solution                      =  InitialAcceleration(Solution,Geometry,Data,Mesh,...
                                                UserDefinedFuncs,Bc,Assembly); 
U00                           =  U0 - ...
                                 Dt*Solution.x.velocity + ...
                                 Dt^2/2*Solution.x.acceleration;
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
%     if TimeStep==200
%        Dt = 2*Dt;
%     elseif TimeStep==400
%        Dt  =  2*Dt;
%     elseif TimeStep==800
%        Dt  =  2*Dt;
%     elseif TimeStep==1000
%        Dt  =  2*Dt;
%     end
    %----------------------------------------------------------------------
    % Predictor step.
    %----------------------------------------------------------------------
    Solution.x.velocity    =  -U00/(2*Dt);  
    Solution.x.acceleration  =  (-2*U0 + U00)/(Dt^2);
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
    initial       =  1; 
    final         =  Geometry.dim*Mesh.volume.x.n_nodes; 
    Solution.x.Eulerian_x     =  Solution.x.Lagrangian_X + reshape(Solution.incremental_solution(initial:final),Geometry.dim,Mesh.volume.x.n_nodes);
    
    U                        =  Solution.x.Eulerian_x - Solution.x.Lagrangian_X;
    Solution.x.velocity      =  (U - U00)/(2*Dt);
    Solution.x.acceleration  =  (U - 2*U0 + U00)/Dt^2;
    %----------------------------------------------------------------------
    % Update values in previous time step
    %----------------------------------------------------------------------
    Solution.x.Eulerian_x00     =  Solution.x.Eulerian_x0;
    Solution.x.Eulerian_x0      =  Solution.x.Eulerian_x;
    U0                          =  Solution.x.Eulerian_x0  - Solution.x.Lagrangian_X;    
    U00                         =  Solution.x.Eulerian_x00 - Solution.x.Lagrangian_X;
    %----------------------------------------------------------------------
    % Print on screen  
    %----------------------------------------------------------------------
    ExplicitNewmarkBetaPrint(TimeStep);
    fprintf('velocity norm %f',norm(Solution.x.velocity));

    if isnan(norm(Solution.x.velocity))
       fprintf('Unstable solution') 
    end 
end

Solution.instability  =  0;
