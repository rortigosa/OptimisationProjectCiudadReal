%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function p    =  TestFunctionOptimisationComputation(ObjFunc0,...
                             Solution,Bc,NR,Geometry,Mesh,FEM,Quadrature,...
                             Assembly,MatInfo,Optimisation,Data,TimeIntegrator,...
                             Contact)
 
if Solution.instability==1
   NR.nonlinearity          =  'linearised_convexified';
   Solution                 =  Solution.old; 
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
                 Assembly          =  FEMAssembly(Data,NR.nonlinearity,Geometry,...
                                              Mesh,FEM,Quadrature,Assembly,...
                                              MatInfo,Optimisation,Solution,...
                                              TimeIntegrator);        
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
                                              TimeIntegrator);        
         
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
                                              TimeIntegrator);        
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



