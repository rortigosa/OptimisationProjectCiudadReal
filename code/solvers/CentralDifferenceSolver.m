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
% Extract from the structures   
%--------------------------------------------------------------------------
void_factor                   =  Optimisation.void_factor; 
rho_p                         =  Optimisation.density_p;
x                             =  Solution.x.Eulerian_x;
X                             =  Solution.x.Lagrangian_X;
Klinear                       =  MatInfo.Klinear;
%--------------------------------------------------------------------------
% Free and fixed dofs
%--------------------------------------------------------------------------
fixdof                        =  Bc.Dirichlet.fixdof;                            
freedof                       =  Bc.Dirichlet.freedof;
%--------------------------------------------------------------------------
% Mass matrix and damping matrix  
%--------------------------------------------------------------------------
TimeIntegrator.RayleighCoeff  =  1;
Assembly                      =  MassDampingMatrix(Mesh,Geometry,Solution,...
                                 Quadrature,FEM,MatInfo,Assembly,TimeIntegrator);                                
%--------------------------------------------------------------------------
% Select Time integration parameters 
%--------------------------------------------------------------------------                             
Dt                            =  1e-3;
TimeIntegrator.Dt             =  Dt;                             
Assembly.total_matrix         =  1/Dt^2*Assembly.MassMatrix + ...
                                 1/(2*Dt)*Assembly.DampingMatrix;                             
invK                          =  1./diag(Assembly.total_matrix);                                                    
invK(fixdof)                  =  [];
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
while TimeStep<50000
%tic
    %----------------------------------------------------------------------
    % Update solution fields with those of the previous load increment
    %----------------------------------------------------------------------
    TimeStep                =  TimeStep + 1;
    %----------------------------------------------------------------------
    % Predictor step.
    %----------------------------------------------------------------------
    velocity      =  -U00/(2*Dt);  
    acceleration  =  (-2*U0 + U00)/(Dt^2);
    %----------------------------------------------------------------------
    % Internal residual
    %--------------------------------------------------------------------------
    TInternal               = AssemblyCentralDifferenceLinearUFormulationMexC10(Geometry.dim,...
                                        Mesh.volume.x.n_node_elem,Mesh.volume.x.n_nodes,...
                                        Mesh.volume.n_elem,void_factor,rho_p,...
                                        Mesh.volume.x.connectivity,x,X,Klinear);
    %--------------------------------------------------------------------------
    % Sparse assembly of the residual.
    %--------------------------------------------------------------------------
    TInertial              =  Assembly.MassMatrix*acceleration(:);
    TDamping               =  Assembly.DampingMatrix*velocity(:);
    Total_force            =  TInternal + TInertial + TDamping;
    %----------------------------------------------------------------------
    % update matrices and force vectors.   
    %----------------------------------------------------------------------
    Residual               =  Total_force -  Bc.Neumann.force_vector;
    %----------------------------------------------------------------------
    % solving system of equations   
    %----------------------------------------------------------------------
    Solution.incremental_solution(freedof)  =  -invK.*Residual(freedof,1);
    %----------------------------------------------------------------------
    % update the variables of the problem. corrector step.  
    %----------------------------------------------------------------------
    initial                          =  1;
    final                            =  Geometry.dim*Mesh.volume.x.n_nodes;
    %D_x                          =  reshape(solution.incremental_solution(initial:final),dim,mesh.volume.x.n_nodes);
    %solution.x.Eulerian_x    =  solution.x.Eulerian_x + D_x;
    
    %Solution.x.Eulerian_x     =  Solution.x.Lagrangian_X + reshape(Solution.incremental_solution(initial:final),Geometry.dim,Mesh.volume.x.n_nodes);
    %Solution.x.Eulerian_x     =    
    %U                        =  Solution.x.Eulerian_x - Solution.x.Lagrangian_X;
    %velocity                 =  (U - U00)/(2*Dt);
    %acceleration             =  (U - 2*U0 + U00)/Dt^2;
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
    %ExplicitNewmarkBetaPrint(TimeStep);
    %fprintf('velocity norm %f',norm(Solution.x.velocity));
%    fprintf('\n max displ %f',Solution.x.Eulerian_x(find(Bc.Neumann.force_vector))-Solution.x.Lagrangian_X(find(Bc.Neumann.force_vector)));
%    plot(TimeStep,Solution.x.Eulerian_x(find(Bc.Neumann.force_vector))-Solution.x.Lagrangian_X(find(Bc.Neumann.force_vector)),'-o')
%    hold on
%     if isnan(norm(Solution.x.velocity))
%        fprintf('Unstable solution') 
%     end 
%toc
end

Solution.instability  =  0;

                            
% % % %--------------------------------------------------------------------------
% % % % Extract from the structures   
% % % %--------------------------------------------------------------------------
% % % void_factor                   =  Optimisation.void_factor; 
% % % rho_p                         =  Optimisation.density_p;
% % % x                             =  Solution.x.Eulerian_x;
% % % X                             =  Solution.x.Lagrangian_X;
% % % Klinear                       =  MatInfo.Klinear;
% % % %--------------------------------------------------------------------------
% % % % Free and fixed dofs
% % % %--------------------------------------------------------------------------
% % % fixdof                        =  Bc.Dirichlet.fixdof;                            
% % % freedof                       =  Bc.Dirichlet.freedof;
% % % %--------------------------------------------------------------------------
% % % % Mass matrix and damping matrix  
% % % %--------------------------------------------------------------------------
% % % TimeIntegrator.RayleighCoeff  =  1;
% % % Assembly                      =  MassDampingMatrix(Mesh,Geometry,Solution,...
% % %                                  Quadrature,FEM,MatInfo,Assembly,TimeIntegrator);                                
% % % %--------------------------------------------------------------------------
% % % % Select Time integration parameters 
% % % %--------------------------------------------------------------------------                             
% % % Dt                            =  1e-3;
% % % TimeIntegrator.Dt             =  Dt;                             
% % % Assembly.total_matrix         =  1/Dt^2*Assembly.MassMatrix + ...
% % %                                  1/(2*Dt)*Assembly.DampingMatrix;                             
% % % invK                          =  1./diag(Assembly.total_matrix);                                                    
% % % invK(fixdof)                  =  [];
% % % %--------------------------------------------------------------------------
% % % % Initialisation
% % % %--------------------------------------------------------------------------
% % % Assembly                =  InitialisedResiduals(Solution,NR,Assembly);
% % % Solution.old_old        =  Solution.old;
% % % TimeStep                =  0;
% % % NR.iteration            =  1;
% % % %--------------------------------------------------------------------------
% % % % The initial guess for geometry is in the undeformed config.
% % % %--------------------------------------------------------------------------
% % % Solution                =  InitialisedFields(Geometry,Mesh,Data.formulation);
% % % %--------------------------------------------------------------------------
% % % % Initialise velocity and acceleration.
% % % %--------------------------------------------------------------------------
% % % U0                            =  zeros(Geometry.dim,Mesh.volume.x.n_nodes);
% % % Solution.x.Eulerian_x0        =  Solution.x.Lagrangian_X;
% % % Solution.x.Eulerian_x00       =  Solution.x.Lagrangian_X;
% % % Solution.x.velocity           =  zeros(Geometry.dim,Mesh.volume.x.n_nodes);
% % % Solution.x.acceleration       =  zeros(Geometry.dim,Mesh.volume.x.n_nodes);
% % % %--------------------------------------------------------------------------
% % % % Initial acceleration
% % % %--------------------------------------------------------------------------
% % % Solution                      =  InitialAcceleration(Solution,Geometry,Data,Mesh,...
% % %                                                 UserDefinedFuncs,Bc,Assembly); 
% % % U00                           =  U0 - ...
% % %                                  Dt*Solution.x.velocity + ...
% % %                                  Dt^2/2*Solution.x.acceleration;
% % % %--------------------------------------------------------------------------
% % % % Energy Criterion to stop the simulation
% % % %--------------------------------------------------------------------------
% % % EnergyCriterion  =  1;
% % % %while EnergyCriterion 
% % % while TimeStep<50000
% % % %tic
% % %     %----------------------------------------------------------------------
% % %     % Update solution fields with those of the previous load increment
% % %     %----------------------------------------------------------------------
% % %     TimeStep                =  TimeStep + 1;
% % %     %----------------------------------------------------------------------
% % %     % Predictor step.
% % %     %----------------------------------------------------------------------
% % %     velocity      =  -U00/(2*Dt);  
% % %     acceleration  =  (-2*U0 + U00)/(Dt^2);
% % %     %----------------------------------------------------------------------
% % %     % Internal residual
% % %     %--------------------------------------------------------------------------
% % %     TInternal               = AssemblyCentralDifferenceLinearUFormulationMexC10(Geometry.dim,...
% % %                                         Mesh.volume.x.n_node_elem,Mesh.volume.x.n_nodes,...
% % %                                         Mesh.volume.n_elem,void_factor,rho_p,...
% % %                                         Mesh.volume.x.connectivity,x,X,Klinear);
% % %     %--------------------------------------------------------------------------
% % %     % Sparse assembly of the residual.
% % %     %--------------------------------------------------------------------------
% % %     TInertial              =  Assembly.MassMatrix*acceleration(:);
% % %     TDamping               =  Assembly.DampingMatrix*velocity(:);
% % %     Total_force            =  TInternal + TInertial + TDamping;
% % %     %----------------------------------------------------------------------
% % %     % update matrices and force vectors.   
% % %     %----------------------------------------------------------------------
% % %     Residual               =  Total_force -  Bc.Neumann.force_vector;
% % %     %----------------------------------------------------------------------
% % %     % solving system of equations   
% % %     %----------------------------------------------------------------------
% % %     Solution.incremental_solution(freedof)  =  -invK.*Residual(freedof,1);
% % %     %----------------------------------------------------------------------
% % %     % update the variables of the problem. corrector step.  
% % %     %----------------------------------------------------------------------
% % %     initial                          =  1;
% % %     final                            =  Geometry.dim*Mesh.volume.x.n_nodes;
% % %     %D_x                          =  reshape(solution.incremental_solution(initial:final),dim,mesh.volume.x.n_nodes);
% % %     %solution.x.Eulerian_x    =  solution.x.Eulerian_x + D_x;
% % %     
% % %     Solution.x.Eulerian_x     =  Solution.x.Lagrangian_X + reshape(Solution.incremental_solution(initial:final),Geometry.dim,Mesh.volume.x.n_nodes);
% % %     
% % %     %U                        =  Solution.x.Eulerian_x - Solution.x.Lagrangian_X;
% % %     %velocity                 =  (U - U00)/(2*Dt);
% % %     %acceleration             =  (U - 2*U0 + U00)/Dt^2;
% % %     %----------------------------------------------------------------------
% % %     % Update values in previous time step
% % %     %----------------------------------------------------------------------
% % %     Solution.x.Eulerian_x00     =  Solution.x.Eulerian_x0;
% % %     Solution.x.Eulerian_x0      =  Solution.x.Eulerian_x;
% % %     U0                          =  Solution.x.Eulerian_x0  - Solution.x.Lagrangian_X;    
% % %     U00                         =  Solution.x.Eulerian_x00 - Solution.x.Lagrangian_X;
% % %     %----------------------------------------------------------------------
% % %     % Print on screen  
% % %     %----------------------------------------------------------------------
% % %     %ExplicitNewmarkBetaPrint(TimeStep);
% % %     %fprintf('velocity norm %f',norm(Solution.x.velocity));
% % % %    fprintf('\n max displ %f',Solution.x.Eulerian_x(find(Bc.Neumann.force_vector))-Solution.x.Lagrangian_X(find(Bc.Neumann.force_vector)));
% % % %    plot(TimeStep,Solution.x.Eulerian_x(find(Bc.Neumann.force_vector))-Solution.x.Lagrangian_X(find(Bc.Neumann.force_vector)),'-o')
% % % %    hold on
% % % %     if isnan(norm(Solution.x.velocity))
% % % %        fprintf('Unstable solution') 
% % % %     end 
% % % %toc
% % % end
% % % 
% % % Solution.instability  =  0;
% % % 


% % % 
% % % 
% % % %--------------------------------------------------------------------------
% % % %
% % % % Solver for linearised elasticity in increments (for unstable solutions)
% % % %
% % % %--------------------------------------------------------------------------
% % % %--------------------------------------------------------------------------
% % % function [Solution,...
% % %     Assembly,TimeIntegrator]       =  CentralDifferenceSolver(Data,NR,Geometry,Mesh,...
% % %                                 FEM,Quadrature,Assembly,MatInfo,Optimisation,...
% % %                                 Bc,Solution,UserDefinedFuncs,TimeIntegrator,Contact)
% % % 
% % % %--------------------------------------------------------------------------
% % % % Mass matrix and damping matrix  
% % % %--------------------------------------------------------------------------
% % % TimeIntegrator.RayleighCoeff  =  1;
% % % Assembly                      =  MassDampingMatrix(Mesh,Geometry,Solution,...
% % %                                  Quadrature,FEM,MatInfo,Assembly,TimeIntegrator);                                
% % % %--------------------------------------------------------------------------
% % % % Select Time integration parameters 
% % % %--------------------------------------------------------------------------                             
% % % Dt                            =  1e-3;
% % % TimeIntegrator.Dt             =  Dt;                             
% % % Assembly.total_matrix         =  1/Dt^2*Assembly.MassMatrix + ...
% % %                                  1/(2*Dt)*Assembly.DampingMatrix;                             
% % % invK                          =  1./diag(Assembly.total_matrix);                                                    
% % % invK(Bc.Dirichlet.fixdof)     =  [];
% % % %--------------------------------------------------------------------------
% % % % Initialisation
% % % %--------------------------------------------------------------------------
% % % Assembly                =  InitialisedResiduals(Solution,NR,Assembly);
% % % Solution.old_old        =  Solution.old;
% % % TimeStep                =  0;
% % % NR.iteration            =  1;
% % % %--------------------------------------------------------------------------
% % % % The initial guess for geometry is in the undeformed config.
% % % %--------------------------------------------------------------------------
% % % Solution                =  InitialisedFields(Geometry,Mesh,Data.formulation);
% % % %--------------------------------------------------------------------------
% % % % Initialise velocity and acceleration.
% % % %--------------------------------------------------------------------------
% % % U0                            =  zeros(Geometry.dim,Mesh.volume.x.n_nodes);
% % % Solution.x.Eulerian_x0        =  Solution.x.Lagrangian_X;
% % % Solution.x.Eulerian_x00       =  Solution.x.Lagrangian_X;
% % % Solution.x.velocity           =  zeros(Geometry.dim,Mesh.volume.x.n_nodes);
% % % Solution.x.acceleration       =  zeros(Geometry.dim,Mesh.volume.x.n_nodes);
% % % %--------------------------------------------------------------------------
% % % % Initial acceleration
% % % %--------------------------------------------------------------------------
% % % Solution                      =  InitialAcceleration(Solution,Geometry,Data,Mesh,...
% % %                                                 UserDefinedFuncs,Bc,Assembly); 
% % % U00                           =  U0 - ...
% % %                                  Dt*Solution.x.velocity + ...
% % %                                  Dt^2/2*Solution.x.acceleration;
% % % %--------------------------------------------------------------------------
% % % % Energy Criterion to stop the simulation
% % % %--------------------------------------------------------------------------
% % % EnergyCriterion  =  1;
% % % %while EnergyCriterion 
% % % while TimeStep<10000
% % % tic
% % %     %----------------------------------------------------------------------
% % %     % Update solution fields with those of the previous load increment
% % %     %----------------------------------------------------------------------
% % %     TimeStep                =  TimeStep + 1;
% % %     %----------------------------------------------------------------------
% % %     % Predictor step.
% % %     %----------------------------------------------------------------------
% % %     Solution.x.velocity      =  -U00/(2*Dt);  
% % %     Solution.x.acceleration  =  (-2*U0 + U00)/(Dt^2);
% % %     %----------------------------------------------------------------------
% % %     % Incremental variables for the load increment strategy.
% % %     %----------------------------------------------------------------------
% % % %     switch NR.nonlinearity
% % % %         case 'nonlinear'
% % % %             Assembly  =  InternalWorkUExplicitAssembly(Data.formulation,...
% % % %                 Geometry,Mesh,FEM,Quadrature,Assembly,...
% % % %                 MatInfo,Optimisation,Solution);
% % % %         case 'linear'
% % %             Assembly  =  InternalWorkUExplicitLinearAssembly(Data.formulation,...
% % %                 Geometry,Mesh,FEM,Quadrature,Assembly,...
% % %                 MatInfo,Optimisation,Solution);
% % % %     end                                    
% % %     %----------------------------------------------------------------------
% % %     % Update Dirichlet boundary conditions. 
% % %     %----------------------------------------------------------------------
% % %     Solution          =  UpdateDirichletBoundaryConditions(Data.formulation,Solution,Bc,NR);
% % %     %----------------------------------------------------------------------
% % %     % update matrices and force vectors.   
% % %     %----------------------------------------------------------------------
% % %     Assembly.Residual  =  Assembly.total_force -  Bc.Neumann.force_vector;
% % % %      Assembly          =  NewtonRaphsonResidualUpdate(Geometry.dim,Data,Mesh,UserDefinedFuncs,...
% % % %                                Bc,Assembly,NR,TimeIntegrator);
% % %     %----------------------------------------------------------------------
% % %     % solving system of equations   
% % %     %----------------------------------------------------------------------
% % % %     [freedof,...
% % % %         fixdof]   =  DeterminationVariableFreeFixedDofs(Contact,Solution,Bc,NR);
% % % %    Solution      =  SolveSystemEquations(freedof,fixdof,Assembly,Solution);
% % %     Solution.incremental_solution(Bc.Dirichlet.freedof)  =  -invK.\Assembly.Residual(Bc.Dirichlet.freedof,1);
% % %         %----------------------------------------------------------------------
% % %     % update the variables of the problem. corrector step.  
% % %     %----------------------------------------------------------------------
% % %     Solution      =  FieldsUpdate(Data,Geometry,Mesh,Solution,TimeIntegrator,Contact);
% % %     initial       =  1; 
% % %     final         =  Geometry.dim*Mesh.volume.x.n_nodes; 
% % %     Solution.x.Eulerian_x     =  Solution.x.Lagrangian_X + reshape(Solution.incremental_solution(initial:final),Geometry.dim,Mesh.volume.x.n_nodes);
% % %     
% % %     U                        =  Solution.x.Eulerian_x - Solution.x.Lagrangian_X;
% % %     Solution.x.velocity      =  (U - U00)/(2*Dt);
% % %     Solution.x.acceleration  =  (U - 2*U0 + U00)/Dt^2;
% % %     %----------------------------------------------------------------------
% % %     % Update values in previous time step
% % %     %----------------------------------------------------------------------
% % %     Solution.x.Eulerian_x00     =  Solution.x.Eulerian_x0;
% % %     Solution.x.Eulerian_x0      =  Solution.x.Eulerian_x;
% % %     U0                          =  Solution.x.Eulerian_x0  - Solution.x.Lagrangian_X;    
% % %     U00                         =  Solution.x.Eulerian_x00 - Solution.x.Lagrangian_X;
% % %     %----------------------------------------------------------------------
% % %     % Print on screen  
% % %     %----------------------------------------------------------------------
% % %     %ExplicitNewmarkBetaPrint(TimeStep);
% % %     %fprintf('velocity norm %f',norm(Solution.x.velocity));
% % % %    fprintf('\n max displ %f',Solution.x.Eulerian_x(find(Bc.Neumann.force_vector))-Solution.x.Lagrangian_X(find(Bc.Neumann.force_vector)));
% % % %    plot(TimeStep,Solution.x.Eulerian_x(find(Bc.Neumann.force_vector))-Solution.x.Lagrangian_X(find(Bc.Neumann.force_vector)),'-o')
% % % %    hold on
% % % %     if isnan(norm(Solution.x.velocity))
% % % %        fprintf('Unstable solution') 
% % % %     end 
% % % toc
% % % end
% % % 
% % % Solution.instability  =  0;
