%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Adjust the stabilisation for the solution process
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function [Assembly,StabilisationFactor,...
    NIncrements]  =  StabilisationTuningProcedure(Contact,Solution,Bc,NR,...
                              Data,Geometry,Mesh,FEM,Quadrature,Assembly,...
                              MatInfo,Optimisation,TimeIntegrator,Stage)

NR.iteration      =  1;
[~,fixdof]        =  DeterminationVariableFreeFixedDofs(Contact,...
                                                           Solution,Bc,NR);
%--------------------------------------------------------------------------
% Check stabilisation factor 1
%--------------------------------------------------------------------------
StabilisationFactor        =  1;                         
Assembly0                  =  FEMAssembly(Data,NR.nonlinearity,Geometry,...
                                           Mesh,FEM,Quadrature,Assembly,...
                                          MatInfo,Optimisation,Solution,...
                                       TimeIntegrator,StabilisationFactor);
reduced_matrix             =  Assembly0.total_matrix;
reduced_matrix(fixdof,:)   =  [];
reduced_matrix(:,fixdof)   =  [];
condNumber0                =  condest(reduced_matrix);                                       
UserDefinedFactor          =  1.2;
%--------------------------------------------------------------------------
% Check stabilisation factor 1/5
%--------------------------------------------------------------------------
StabilisationFactor        =  1/5;                         
Assembly                   =  FEMAssembly(Data,NR.nonlinearity,Geometry,...
                                           Mesh,FEM,Quadrature,Assembly,...
                                          MatInfo,Optimisation,Solution,...
                                       TimeIntegrator,StabilisationFactor);
reduced_matrix             =  Assembly.total_matrix;
reduced_matrix(fixdof,:)   =  [];
reduced_matrix(:,fixdof)   =  [];
condNumber                 =  condest(reduced_matrix);                                       
NIncrements                =  NR.instability_load_incr_min;
%--------------------------------------------------------------------------
% Bisection prodecure to adjust the stabilisation pasrameter
%--------------------------------------------------------------------------
if condNumber>UserDefinedFactor*condNumber0
   Assembly                =  Assembly0;
   StabilisationFactor     =  1;
   NIncrements             =  NR.instability_load_incr;
end
       
switch Stage
    case 'Solution'
         fprintf('\n Stabilisation Factor scaled by = %f\n',StabilisationFactor)   
    case 'Sensitivity'
         fprintf('\n Stabilisation Factor for Adjoint problem scaled by = %f\n',StabilisationFactor)           
end
        

