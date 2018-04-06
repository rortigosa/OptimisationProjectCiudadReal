%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Newton Raphson algorithm
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [Solution,NR]               =  NewtonRaphson(NR,FEM,Mesh,Solution,Data,Bc,...
                                       Geometry,UserDefinedFuncs,Assembly,...
                                       Optimisation,MatInfo,Quadrature,...
                                       Contact,TimeIntegrator)
                                   
NR.convergence_non_linear       =  0; % This flag determines if at least 1 load increment has converged
NR.incr_load                    =  0;
while NR.accumulated_factor<NR.max_load_factor-1e-6
    %----------------------------------------------------------------------
    % Incremental variables for the load increment strategy.                
    %----------------------------------------------------------------------
    NR.incr_load               =  NR.incr_load + 1; 
    NR.accumulated_factor      =  NR.accumulated_factor + NR.load_factor;
    NR.convergence_warning     =  0;
    %----------------------------------------------------------------------    
    % Update Dirichlet boundary conditions.    
    %----------------------------------------------------------------------    
    old_solution               =  Solution;
    Solution                   =  UpdateDirichletBoundaryConditions(Data.formulation,Solution,Bc,NR);
    %----------------------------------------------------------------------
    % Updated residual for the next load increment taking into account 
    % Dirichlet boundary conditions.       
    %----------------------------------------------------------------------
    Assembly                   =  NewtonRaphsonInitialResidual(Data,old_solution,...
                                         Geometry,Bc,Mesh,Solution,UserDefinedFuncs,NR,Assembly);
    %----------------------------------------------------------------------
    % Necessary incremental variables.                                
    %----------------------------------------------------------------------    
    Residual_dimensionless      =  1e8;  
    NR.iteration                =  0;
    NR.nonconvergence_criteria  =  Residual_dimensionless>NR.tolerance;
    while NR.nonconvergence_criteria    
        NR.iteration            =  NR.iteration + 1;
        %------------------------------------------------------------------
        % solving system of equations                                                                                         
        %------------------------------------------------------------------
        [freedof,fixdof]        =  DeterminationVariableFreeFixedDofs(Contact,Solution,Bc,NR);
        Solution                =  SolveSystemEquations(freedof,fixdof,Assembly,Solution);                                                                    
        %------------------------------------------------------------------
        % update the variables of the problem. corrector step.                                  
        %------------------------------------------------------------------
        Solution                =  FieldsUpdate(Data,Geometry,Mesh,Solution,TimeIntegrator,Contact); 
        %------------------------------------------------------------------
        % update matrices and force vectors.                                                                                                                                                         
        %------------------------------------------------------------------
        Assembly     =  FEMAssembly(Data,NR.nonlinearity,Geometry,Mesh,FEM,...
                                    Quadrature,Assembly,MatInfo,Optimisation,...
                                    Solution,TimeIntegrator);
        Assembly     =  NewtonRaphsonResidualUpdate(Geometry.dim,Data,Mesh,...
                             UserDefinedFuncs,Bc,Assembly,NR,TimeIntegrator);
        %------------------------------------------------------------------
        % checking for convergence.                                                                                                                        
        %------------------------------------------------------------------
        [NR,Residual_dimensionless,...
            Assembly]       =  NewtonRaphsonConvergence(NR,Assembly,Bc);
        %------------------------------------------------------------------
        % screen ouput for current Newton-Raphson iteration.                                  
        %------------------------------------------------------------------
        NewtonRaphsonIterationPrint(NR.incr_load,Residual_dimensionless);
        %------------------------------------------------------------------
        % Break in case of nonconvergence           
        %------------------------------------------------------------------
        switch NR.convergence_warning
               case 1
                    break;  
        end  
    end
    if NR.nonconvergence_criteria==0
       if NR.convergence_non_linear==0        
          NR.convergence_non_linear  =  1;        
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
            NewtonRaphsonConvergedSolutionPrint(NR);            
            %--------------------------------------------------------------
            % Postprocessing for static case and saving results.                                     
            %--------------------------------------------------------------
            NewtonRaphsonPostprocessing(NR,Assembly);            
            format long e  
    end                   
    %----------------------------------------------------------------------
    % Break in case of nonconvergence           
    %----------------------------------------------------------------------
    switch NR.convergence_warning
        case 1
            break;
    end    
end                 

 
