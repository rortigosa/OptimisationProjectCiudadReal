%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes:
%  a) Equilibrium problem: new displaced configuration
%  b) Test functions p
%  c) Derivative (with respect to rho) of the objective function
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [ObjFunc,ObjFunc0,...
    DIDrho,Solution,...
    Optimisation]       =  FEMSolver(xPhys,xPhys0,Iteration,ObjFunc0,...
                                        Data,TimeIntegrator,NR,Geometry,Mesh,...
                                FEM,Quadrature,Assembly,MatInfo,Optimisation,...
                                Bc,Solution,UserDefinedFuncs)


%--------------------------------------------------------------------------                            
% Do consistent linearisation  durin the first 20 iterations
%--------------------------------------------------------------------------                            
% if Iteration<20
%    NR.nonlinearity  =  'nonlinear';
% end
%--------------------------------------------------------------------------
% INITIALISATION 
%--------------------------------------------------------------------------  
Optimisation.density             =  xPhys;
Optimisation.density0            =  xPhys0;  % Density associated with the previous optimisation iteration
Optimisation.IncrTechnique       =  'IncrLoad';
%--------------------------------------------------------------------------
% EQUILIBRIUM PROBLEM: COMPUTE DISPLACEMENTS (u)     
%--------------------------------------------------------------------------  
switch TimeIntegrator.type
    %----------------------------------------------------------------------
    % Static solvers
    %----------------------------------------------------------------------
    case 'Static'
       switch NR.nonlinearity
           case 'linear'
               %Solution    =  LinearSolver(str,1);
           case 'nonlinear'
               [Solution,...
                   Optimisation]  =  IncrementalNewtonRaphson(Data,NR,Geometry,Mesh,...
                                        FEM,Quadrature,Assembly,MatInfo,Optimisation,...
                                        Bc,Solution,UserDefinedFuncs,TimeIntegrator,'~');
           case 'linearised_convexified'
               StabilisationFactor  =  1;
               [Solution,...
                   Optimisation]  =  LinearisedConvexifiedSolver(Data,NR,Geometry,Mesh,...
                                         FEM,Quadrature,Assembly,MatInfo,Optimisation,...
                                         Bc,Solution,UserDefinedFuncs,TimeIntegrator,...
                                         '~',StabilisationFactor);
       end
    %----------------------------------------------------------------------
    % Explicit Newmark Beta solver
    %----------------------------------------------------------------------
    case 'ExplicitNewmarkBeta'
          Solution       =   ExplicitNewmarkBetaSolver(Data,NR,Geometry,Mesh,...
                                         FEM,Quadrature,Assembly,MatInfo,Optimisation,...
                                         Bc,Solution,UserDefinedFuncs,TimeIntegrator,'~');
    %----------------------------------------------------------------------
    % Explicit Newmark Beta solver
    %----------------------------------------------------------------------
    case 'CentralDifference'
          [Solution,Assembly,...
              TimeIntegrator]       =   CentralDifferenceSolver(Data,NR,Geometry,Mesh,...
                                         FEM,Quadrature,Assembly,MatInfo,Optimisation,...
                                         Bc,Solution,UserDefinedFuncs,TimeIntegrator,'~');
end
%--------------------------------------------------------------------------
% COMPUTE OBJECTIVE FUNCTION   
%--------------------------------------------------------------------------  
ObjFunc               =  ComputeObjectiveFunction(Optimisation,FEM,Bc,Quadrature,Mesh,Solution,MatInfo);
if Iteration==1 
   ObjFunc0           =  ObjFunc; 
end
ObjFunc               =  ObjFunc/ObjFunc0; 
%--------------------------------------------------------------------------
% COMPUTE p (adjoint problem)       
%--------------------------------------------------------------------------  
[p,StabilisationFactor]  =  TestFunctionOptimisationComputation(ObjFunc0,...
                             Solution,Bc,NR,Geometry,Mesh,FEM,Quadrature,...
                             Assembly,MatInfo,Optimisation,Data,...
                             TimeIntegrator,'~',Iteration);
%--------------------------------------------------------------------------
% COMPUTE DERIVATIVE OF THE OBJECTIVE FUNCTION  
%--------------------------------------------------------------------------  
DIDrho                =  ComputeDerivativeObjectiveFunction(p,Mesh,...
                                 Optimisation,Solution,MatInfo,Geometry,...
                              NR,FEM,Quadrature,ObjFunc0,TimeIntegrator,StabilisationFactor);
%--------------------------------------------------------------------------
% SAVE AS WELL THE CONVERGED SOLUTION FOR THE NEXT OPTIMISATION ITERATION
%--------------------------------------------------------------------------  
Solution.old_Post     =  Solution.old;
Solution.old          =  Solution;
