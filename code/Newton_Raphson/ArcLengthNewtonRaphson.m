%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Newton Raphson algorithm
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str                        =  ArcLengthNewtonRaphson(str,max_factor)

str.AL.radius                       =  0.005;
str.AL.fail                         =  0;
str.AL.iteration                    =  0;
str.NR.accumulated_factor           =  0.01;
old_solution                        =  str.solution;
old_NR                              =  str.NR;
old_AL                              =  str.AL;
str.solution.x.xincr                =  zeros(str.solution.n_dofs,1);
str.NR.nonconvergence_criteria      =  1;
while (str.NR.accumulated_factor<max_factor  ||  str.AL.fail==1)
    %----------------------------------------------------------------------
    % Initialisation variables  
    %----------------------------------------------------------------------    
    str.NR.iteration                =  0;
    str.AL.iteration                =  str.AL.iteration + 1;
    str.solution.x.Dxk              =  zeros(str.geometry.dim,str.mesh.volume.x.n_nodes);
    %----------------------------------------------------------------------
    % Incremental variables for the load increment strategy.               
    %----------------------------------------------------------------------
    str.NR.convergence_warning      =  0;
    %----------------------------------------------------------------------
    % Re-start in case of non-convergence issues               
    %----------------------------------------------------------------------
    if str.AL.fail
       str.AL.radius                =  str.AL.radius/2;
       str.solution                 =  old_solution;
       str.NR                       =  old_NR;
       str.solution.x.Dxk           =  zeros(str.geometry.dim,str.mesh.volume.x.n_nodes);
       str                          =  TotalAssembly(str); 
       str.AL.fail                  =  0;
       str.AL.iteration             =  old_AL.iteration;
       str.NR.iteration             =  0;
    end
    %----------------------------------------------------------------------    
    % Update Dirichlet boundary conditions.      
    %----------------------------------------------------------------------    
    str                             =  UpdateDirichletBoundaryConditions(str);
    %----------------------------------------------------------------------
    % Updated residual for the next load increment taking into account 
    % Dirichlet boundary conditions.       
    %----------------------------------------------------------------------    
    str                             =  ArcLengthInitialResidual(str);
    %----------------------------------------------------------------------
    % Necessary incremental variables.                                
    %----------------------------------------------------------------------    
    Residual_dimensionless          =  1e8;  
    str.NR.nonconvergence_criteria  =  Residual_dimensionless>str.NR.tolerance;
    while str.NR.nonconvergence_criteria    
        tic  
        str.NR.iteration            =  str.NR.iteration + 1;
        %------------------------------------------------------------------
        % solving system of equations                                                                                         
        %------------------------------------------------------------------
        [freedof,fixdof]            =  DeterminationVariableFreeFixedDofs(str);
        
        uR                          =  NewSolveSystemEquations(freedof,fixdof,...
                                               str.assembly.total_matrix,-str.assembly.Residual,...
                                               zeros(str.solution.n_dofs,1));
        uF                          =  NewSolveSystemEquations(freedof,fixdof,...
                                               str.assembly.total_matrix,str.bc.Neumann.force_vector,...
                                               zeros(str.solution.n_dofs,1));
        [uR,str.AL,...
         str.NR,str.solution]       =  ArcLengthRootFindingV2(str.AL,str.NR,uR,uF,str.solution);                                           
        str.solution.incremental_solution  =  uR;
        %------------------------------------------------------------------
        % update the variables of the problem. corrector step.                                
        %------------------------------------------------------------------
        str                         =  FieldsUpdate(str); 
        %------------------------------------------------------------------
        % update matrices and force vectors.                                                                                                                                                         
        %------------------------------------------------------------------
        str                         =  TotalAssembly(str);
        %------------------------------------------------------------------
        % Update residual.                                                                                                                                                          
        %------------------------------------------------------------------
        str                         =  ArcLengthResidualUpdate(str);        
        %------------------------------------------------------------------
        % checking for convergence.                                                                                                                       
        %------------------------------------------------------------------
        [str.NR,str.AL,Residual_dimensionless,...
            str.assembly]           =  ArcLengthConvergence(str.NR,str.assembly,str.bc,str.AL);
        %------------------------------------------------------------------
        % screen ouput for current Newton-Raphson iteration.                                   
        %------------------------------------------------------------------
        toc 
        ArcLengthIterationPrint(str.NR,Residual_dimensionless,str.AL);
        %------------------------------------------------------------------
        % Store converged solution 
        %------------------------------------------------------------------
        if str.NR.nonconvergence_criteria==0
           old_solution             =  str.solution;
           old_NR                   =  str.NR;
           old_AL                   =  str.AL;
        end
        %------------------------------------------------------------------
        % Break in case of nonconvergence            
        %------------------------------------------------------------------
        switch str.AL.fail
               case 1
                    break;  
            otherwise
        end  
    end  
    switch str.NR.convergence_warning
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
            ArcLengthConvergedSolutionPrint(str.NR,str.AL);            
            %--------------------------------------------------------------
            % Postprocessing for static case and saving results.                                     
            %--------------------------------------------------------------
            ArcLengthPostprocessing(str);            
            format long e              
    end                   
    if (str.NR.convergence_warning==0  &&  str.AL.iteration>60)
       break;
    end
end                 

%--------------------------------------------------------------------------
%  if it is not possible to reach the a load factor of 1, we take the
%  maximum of all the converged simulations and we stimate linearly the
%  final displaced configuration
%--------------------------------------------------------------------------
if (str.NR.convergence_warning==0  &&  str.AL.iteration>60)
load_factor                =  zeros(str.AL.iteration ,1);
for iload=1:str.AL.iteration 
    filename               =  ['Arc_Length_iteration_' num2str(iload) '.mat'];
    load(filename)
    load_factor(iload)     =  str.NR.accumulated_factor;    
end
[x,id]                     =  max(load_factor);
load(['Arc_Length_iteration_' num2str(id) '.mat'])
str.solution.x.Eulerian_x  =  str.solution.x.Lagrangian_X + ...
                             (1/str.NR.accumulated_factor)*(str.solution.x.Eulerian_x - str.solution.x.Lagrangian_X);
end
    
    