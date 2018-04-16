%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [p,StabilisationFactor]    =  TestFunctionOptimisationComputation(ObjFunc0,...
                             Solution,Bc,NR,Geometry,Mesh,FEM,Quadrature,...
                             Assembly,MatInfo,Optimisation,Data,TimeIntegrator,...
                             Contact,Iteration)
 
StabilisationFactor        =  1;                         
if Solution.instability==1
   NR.nonlinearity          =  'linearised_convexified';
%    %Solution                 =  Solution.old; 
%    Solution.x.Eulerian_x      =  Solution.old.x.Eulerian_x;
%    Solution.old.x.Eulerian_x  =  Solution.old_old.x.Eulerian_x;
end
                          
%--------------------------------------------------------------------------
% Compute remaining contributions 
%--------------------------------------------------------------------------
switch Optimisation.ObjFunction
    case 'Compliance'
         NR.iteration      =  1;
         [freedof,fixdof]  =  DeterminationVariableFreeFixedDofs(Contact,...
                                                           Solution,Bc,NR);
         switch TimeIntegrator.type
             case 'Static'
                 if (strcmp(NR.nonlinearity,'linearised_convexified') && Iteration<30)
                     [Assembly,...
                      StabilisationFactor]   =  StabilisationAdjointProblem(Contact,...
                                         Solution,Bc,NR,Data,Geometry,...
                                         Mesh,FEM,Quadrature,Assembly,...
                                         MatInfo,Optimisation,TimeIntegrator);
                 else
                     Assembly  =  FEMAssembly(Data,NR.nonlinearity,Geometry,...
                                          Mesh,FEM,Quadrature,Assembly,...
                                          MatInfo,Optimisation,Solution,...
                                          TimeIntegrator,StabilisationFactor);        
                 end
             case 'CentralDifference'                 
         end
         
         Assembly.Residual              =  -Bc.Neumann.force_vector/ObjFunc0;
         Solution.incremental_solution  =  zeros(Solution.n_dofs,1);
         Solution                       =  SolveSystemEquations(freedof,fixdof,Assembly,Solution);
         p                              =  Solution.incremental_solution;
    case 'Stability'
         NR.iteration      =  1;
         DObjFuncDu        =  DlambdaDxMooneyRivlin(Optimisation,Solution,Quadrature,Mesh,FEM,Geometry,MatInfo,Assembly,Data.formulation);
         [freedof,fixdof]  =  DeterminationVariableFreeFixedDofs(Contact,...
                                                           Solution,Bc,NR);
         Assembly          =  FEMAssembly(Data,NR.nonlinearity,Geometry,...
                                              Mesh,FEM,Quadrature,Assembly,...
                                              MatInfo,Optimisation,Solution,...
                                              TimeIntegrator,StabilisationFactor);        
         
         Assembly.Residual              =  -DObjFuncDu/ObjFunc0;
         Solution.incremental_solution  =  zeros(Solution.n_dofs,1);
         Solution                       =  SolveSystemEquations(freedof,fixdof,Assembly,Solution);
         p                              =  Solution.incremental_solution;
    case 'StrainEnergy'
         NR.iteration      =  1;
         [freedof,fixdof]  =  DeterminationVariableFreeFixedDofs(Contact,...
                                                           Solution,Bc,NR);
         switch TimeIntegrator.type
             case 'Static'
                  Assembly          =  FEMAssembly(Data,NR.nonlinearity,Geometry,...
                                              Mesh,FEM,Quadrature,Assembly,...
                                              MatInfo,Optimisation,Solution,...
                                              TimeIntegrator,Stabilisation);        
                  T                 =  AdjointProblemEnergy(Data.formulation,Geometry,Mesh,...
                                               Assembly,Solution,Optimisation,...
                                               MatInfo,FEM,Quadrature);    
             case 'CentralDifference'
                  T                 =  AdjointProblemEnergy(Data.formulation,Geometry,Mesh,...
                                               Assembly,Solution,Optimisation,...
                                               MatInfo,FEM,Quadrature);    
                 
         end
         Assembly.Residual              =   -T/ObjFunc0;
         Solution.incremental_solution  =  zeros(Solution.n_dofs,1);
         Solution                       =  SolveSystemEquations(freedof,fixdof,Assembly,Solution);
         p                              =  Solution.incremental_solution;
end



