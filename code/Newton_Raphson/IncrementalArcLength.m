function [Solution,Optimisation]  =  IncrementalArcLength(Data,NR,Geometry,Mesh,UserDefinedFuncs,Bc,...
                                FEM,Quadrature,MatInfo,Optimisation,...
                                TimeIntegrator,PostProc,save_flag)


%--------------------------------------------------------------------------
% Critical load
%--------------------------------------------------------------------------
Bc.Neumann.load_factor          =  Bc.Neumann.load_factor*NR.critical_load;
Bc                              =  NeumannBcs(Geometry.dim,Data.formulation,Mesh,...
                                              UserDefinedFuncs,Bc);
%--------------------------------------------------------------------------
% Arc-length parameters
%--------------------------------------------------------------------------
AL.radius                       =  0.5;
%AL.radius                       =  45;
AL.fail                         =  0;
AL.max_accumulated_factor       =  1.02;
AL.min_diff_accumulated_factor  =  1e-3;  % minimum allowed difference for the accumulated factor
AL.iteration                    =  0;
NR.accumulated_factor           =  0.01;
max_iter                        =  50;
AL.max_number_AL_iterations     =  20;  % maximum number of iteration in the NR
AL.critical_load_estimation     =  1;
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
% Start
%--------------------------------------------------------------------------
old_solution                    =  Solution;
old_NR                          =  NR;
old_AL                          =  AL;
Solution.x.xincr                =  zeros(Solution.n_dofs,1);
NR.nonconvergence_criteria      =  1;
stopping_condition              =  1;
NFails                          =  0;
F0                              =  Bc.Neumann.force_vector;
%while (stopping_condition  ||  AL.fail==1)
while stopping_condition
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
       AL.iteration             =  old_AL.iteration + 1;
       NR.iteration             =  0;
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
                                               Assembly.total_matrix,F0,...
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
            Assembly,stopping_condition]           =  ArcLengthConvergence(NR,old_NR,Assembly,Bc,AL);
        %------------------------------------------------------------------
        % screen ouput for current Newton-Raphson iteration.                                    
        %------------------------------------------------------------------
        ArcLengthIterationPrint(NR,Residual_dimensionless,AL,norm(Assembly.Residual(Bc.Dirichlet.freedof))/norm(Bc.Neumann.force_vector));
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
                    UserDefinedFuncs,PostProc,AL,save_flag);
            format long e              
    end                   
    if (NR.convergence_warning==0  &&  AL.iteration>max_iter)
       break;
    end 
end                 

Solution.instability  =  0;
%--------------------------------------------------------------------------
% Save solution field
%--------------------------------------------------------------------------
if AL.fail
    Solution                  =  old_solution;
    NR                        =  old_NR;
    %----------------------------------------------------------------------
    % The  umber of stability iterations is scaled
    %----------------------------------------------------------------------
    if NR.accumulated_factor>1
       NR.instability_load_incr  =  5;    
    else
       NR.instability_load_incr  =  max(5,ceil((1 - NR.accumulated_factor)*NR.instability_load_incr));
    end
    %----------------------------------------------------------------------
    % Convexified unstable problem
    %----------------------------------------------------------------------
    [Solution,...
        Optimisation]     =  LinearisedConvexifiedSolver(Data,NR,Geometry,Mesh,...
                                FEM,Quadrature,Assembly,MatInfo,Optimisation,...
                                Bc,Solution,UserDefinedFuncs,TimeIntegrator,...
                                '~',1,0);
    Solution.instability     =  1;
end    