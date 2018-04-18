function ControlOutput  =  ArcLengthNewtonRaphson(Data,NR,Geometry,Mesh,UserDefinedFuncs,Bc,...
                                FEM,Quadrature,MatInfo,Optimisation,...
                                TimeIntegrator,PostProc,save_flag)

ControlOutput                   =  cell(1);                            
AL.radius                       =  0.005;
AL.fail                         =  0;
AL.iteration                    =  0;
NR.accumulated_factor           =  0.01;
%--------------------------------------------------------------------------
% Initialisation of the formulation
%--------------------------------------------------------------------------
[Solution,NR,Assembly,FEM,...
 Quadrature,MatInfo]  =  InitialisationFormulation(Data,Geometry,FEM,Mesh,NR,Quadrature,MatInfo);
NR.nonlinearity                 =  'nonlinear';
TimeIntegrator.type             =  'Static';
%--------------------------------------------------------------------------
% Initial Assembly
%--------------------------------------------------------------------------
Assembly                        =  FEMAssembly(Data,NR.nonlinearity,Geometry,Mesh,...
                                      FEM,Quadrature,Assembly,MatInfo,...
                                      Optimisation,Solution,TimeIntegrator);    

%--------------------------------------------------------------------------
% Cut-off density
%--------------------------------------------------------------------------
cutoff  =  0.4;
Optimisation.density(Optimisation.density>=cutoff) =  1;
Optimisation.density(Optimisation.density<cutoff)  =  0;

%--------------------------------------------------------------------------
% Start
%--------------------------------------------------------------------------
old_solution                    =  Solution;
old_NR                          =  NR;
old_AL                          =  AL;
Solution.x.xincr                =  zeros(Solution.n_dofs,1);
NR.nonconvergence_criteria      =  1;
stopping_condition              =  1;
NFails                          =  0;
while (stopping_condition  ||  AL.fail==1)
    %----------------------------------------------------------------------
    % Initialisation variables  
    %----------------------------------------------------------------------    
    NR.iteration                =  0;
    AL.iteration                =  AL.iteration + 1;
    Solution.x.Dxk              =  zeros(Geometry.dim,Mesh.volume.x.n_nodes);
    %----------------------------------------------------------------------
    % Incremental variables for the load increment strategy.               
    %----------------------------------------------------------------------
    NR.convergence_warning      =  0;
    %----------------------------------------------------------------------
    % Re-start in case of non-convergence issues               
    %----------------------------------------------------------------------
    if AL.fail
       NFails                   =  NFails + 1;
       AL.radius                =  AL.radius/2;
       Solution                 =  old_solution;
       NR                       =  old_NR;
       Solution.x.Dxk           =  zeros(Geometry.dim,Mesh.volume.x.n_nodes);
       Assembly                 =  FEMAssembly(Data,NR.nonlinearity,Geometry,Mesh,...
                                        FEM,Quadrature,Assembly,MatInfo,...
                                        Optimisation,Solution,TimeIntegrator);    
       AL.fail                  =  0;
       AL.iteration             =  old_AL.iteration;
       NR.iteration             =  0;
    end
    if NFails>20
        break;
    end
    %----------------------------------------------------------------------    
    % Update Dirichlet boundary conditions.        
    %----------------------------------------------------------------------    
    Solution                    =  UpdateDirichletBoundaryConditions(Data.formulation,Solution,Bc,NR);
    %----------------------------------------------------------------------
    % Updated residual for the next load increment taking into account 
    % Dirichlet boundary conditions.       
    %----------------------------------------------------------------------    
    Assembly                   =  ArcLengthInitialResidual(Geometry.dim,Data.formulation,...
                                         Mesh,UserDefinedFuncs,Bc,Assembly,NR) ;   
    %----------------------------------------------------------------------
    % Necessary incremental variables.                                 
    %----------------------------------------------------------------------    
    Residual_dimensionless          =  1e8;  
    NR.nonconvergence_criteria  =  Residual_dimensionless>NR.tolerance;
    while NR.nonconvergence_criteria    
        NR.iteration            =  NR.iteration + 1;
        %------------------------------------------------------------------
        % solving system of equations                                                                                         
        %------------------------------------------------------------------
        [freedof,fixdof]            =  DeterminationVariableFreeFixedDofs('~',Solution,Bc,NR);
        
        uR                          =  NewSolveSystemEquations(freedof,fixdof,...
                                               Assembly.total_matrix,-Assembly.Residual,...
                                               zeros(Solution.n_dofs,1));
        uF                          =  NewSolveSystemEquations(freedof,fixdof,...
                                               Assembly.total_matrix,Bc.Neumann.force_vector,...
                                               zeros(Solution.n_dofs,1));
        [uR,AL,...
         NR,Solution]       =  ArcLengthRootFindingV2(AL,NR,uR,uF,Solution);                                           
        Solution.incremental_solution  =  uR;
        %------------------------------------------------------------------
        % update the variables of the problem. corrector step.                                
        %------------------------------------------------------------------
        Solution             =  FieldsUpdate(Data,Geometry,Mesh,Solution,TimeIntegrator,'~');
        %------------------------------------------------------------------
        % update matrices and force vectors.                                                                                                                                                         
        %------------------------------------------------------------------
        Assembly        =  FEMAssembly(Data,NR.nonlinearity,Geometry,Mesh,...
                                 FEM,Quadrature,Assembly,MatInfo,...
                                 Optimisation,Solution,TimeIntegrator);    
        %------------------------------------------------------------------
        % Update residual.                                                                                                                                                          
        %------------------------------------------------------------------
        Assembly    =  ArcLengthResidualUpdate(Geometry.dim,Data.formulation,Mesh,UserDefinedFuncs,Bc,Assembly,NR);        
        %------------------------------------------------------------------
        % checking for convergence.                                                                                                                       
        %------------------------------------------------------------------
        [NR,AL,Residual_dimensionless,...
            Assembly]           =  ArcLengthConvergence(NR,Assembly,Bc,AL);
        %------------------------------------------------------------------
        % screen ouput for current Newton-Raphson iteration.                                   
        %------------------------------------------------------------------
        ArcLengthIterationPrint(NR,Residual_dimensionless,AL);
        %------------------------------------------------------------------
        % Store converged solution 
        %------------------------------------------------------------------
        if NR.nonconvergence_criteria==0
           old_solution             =  Solution;
           old_NR                   =  NR;
           old_AL                   =  AL;
        end
        %------------------------------------------------------------------
        % Break in case of nonconvergence            
        %------------------------------------------------------------------
        switch AL.fail
               case 1
                    break;  
            otherwise
        end  
    end  
    switch NR.convergence_warning
        %------------------------------------------------------------------
        % Non converged results 
        %------------------------------------------------------------------
        case 1
        %------------------------------------------------------------------
        % Converged results 
        %------------------------------------------------------------------
        case 0
            %--------------------------------------------------------------
            % Printing orders for the converged case.    
            %--------------------------------------------------------------
            %ArcLengthConvergedSolutionPrint(NR,AL);            
            %--------------------------------------------------------------
            % Postprocessing for static case and saving results.                                     
            %--------------------------------------------------------------
            ArcLengthPostprocessing(dir,Optimisation,Geometry,Data,TimeIntegrator,...
                    FEM,Quadrature,NR,MatInfo,Bc,Solution,Mesh,Assembly,...
                    UserDefinedFuncs,PostProc,AL,save_flag)
            %--------------------------------------------------------------
            % Get information to plot the equilibrium path.                                     
            %--------------------------------------------------------------
            ControlOutput{AL.iteration}  =  UserDefinedFuncs.ArcLengthControl(Solution,Bc,NR);    

            format long e              
    end                   
    if (NR.convergence_warning==0  &&  AL.iteration>300)
       break;
    end
end                 

% %--------------------------------------------------------------------------
% %  if it is not possible to reach the a load factor of 1, we take the
% %  maximum of all the converged simulations and we stimate linearly the
% %  final displaced configuration
% %--------------------------------------------------------------------------
% if (NR.convergence_warning==0  &&  AL.iteration>60)
% load_factor                =  zeros(AL.iteration ,1);
% for iload=1:AL.iteration 
%     filename               =  ['Arc_Length_iteration_' num2str(iload) '.mat'];
%     load(filename)
%     load_factor(iload)     =  NR.accumulated_factor;    
% end
% [x,id]                     =  max(load_factor);
% load(['Arc_Length_iteration_' num2str(id) '.mat'])
% Solution.x.Eulerian_x  =  Solution.x.Lagrangian_X + ...
%                              (1/NR.accumulated_factor)*(Solution.x.Eulerian_x - Solution.x.Lagrangian_X);
% end
%     
    