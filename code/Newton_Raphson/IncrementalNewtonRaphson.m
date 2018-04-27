%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function solves the governing equations of the problem considered
%  for the static case. In addition, using an incremental approach, it
%  controls the magnitude of the loading parameter in case convergence
%  problems are encountered
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [Solution,...
    Optimisation]   =  IncrementalNewtonRaphson(Data,NR,Geometry,Mesh,...
                                FEM,Quadrature,Assembly,MatInfo,Optimisation,...
                                Bc,Solution,UserDefinedFuncs,TimeIntegrator,Contact)
%--------------------------------------------------------------------------
%  Start the Newton-Raphson
%--------------------------------------------------------------------------
%OldSolution                     =  Solution;
NR.convergence_warning           =  1; 
load_iteration                   =  0;  
NR.convergence_warning           =  1;
while NR.convergence_warning==1
      load_iteration             =  load_iteration + 1;
      if load_iteration>length(NR.load_increments)
         NR.convergence_warning  =  0;
         break;
      end
      %--------------------------------------------------------------------
      % Number of load increments
      %--------------------------------------------------------------------
      NR.n_incr_loads        =  NR.load_increments(load_iteration);
      %--------------------------------------------------------------------
      % New accumulated factor
      %--------------------------------------------------------------------
      NR.accumulated_factor  =  0;
      NR.incr_load           =  0;
      NR.load_factor         =  1/NR.n_incr_loads;
      NR.max_load_factor     =  1;
      %--------------------------------------------------------------------
      % Load the initial solution 
      %--------------------------------------------------------------------
      Solution               =  InitialisedFields(Geometry,Mesh,Data.formulation);      
      %--------------------------------------------------------------------
      % Initialise residuals and stiffness matrices (total assembly)
      %--------------------------------------------------------------------
      Assembly        =  InitialisedResiduals(Solution,NR,Assembly);
      Assembly        =  FEMAssembly(Data,NR.nonlinearity,Geometry,Mesh,...
                                      FEM,Quadrature,Assembly,MatInfo,...
                                      Optimisation,Solution,...
                                      TimeIntegrator,'~'); 
      %--------------------------------------------------------------------
      % Newton-Raphson      
      %--------------------------------------------------------------------
      [Solution,NR]   =  NewtonRaphson(NR,FEM,Mesh,Solution,Data,Bc,...
                                       Geometry,UserDefinedFuncs,Assembly,...
                                       Optimisation,MatInfo,Quadrature,...
                                       Contact,TimeIntegrator);
      Solution.instability  =  0;
end

%--------------------------------------------------------------------------
% Convexification in linearised increments 
%--------------------------------------------------------------------------
if load_iteration>length(NR.load_increments)
    %----------------------------------------------------------------------
    % Convexified unstable problem
    %----------------------------------------------------------------------
    [Solution,...
        Optimisation]     =  LinearisedConvexifiedSolver(Data,NR,Geometry,Mesh,...
                                FEM,Quadrature,Assembly,MatInfo,Optimisation,...
                                Bc,Solution,UserDefinedFuncs,TimeIntegrator,...
                                Contact,1,1);
    Solution.instability  =  1;
end    




