%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Stabilisation adjoint problem 
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function [Assembly,StabilisationFactor] =  StabilisationAdjointProblem(Contact,Solution,Bc,NR,...
                              Data,Geometry,Mesh,FEM,Quadrature,...
                              Assembly,MatInfo,Optimisation,TimeIntegrator)

NR.iteration      =  1;
[~,fixdof]        =  DeterminationVariableFreeFixedDofs(Contact,...
                                                           Solution,Bc,NR);

%--------------------------------------------------------------------------
% Check stabilisation factor 1
%--------------------------------------------------------------------------
StabilisationFactor        =  1;                         
Assembly                   =  FEMAssembly(Data,NR.nonlinearity,Geometry,...
                                           Mesh,FEM,Quadrature,Assembly,...
                                          MatInfo,Optimisation,Solution,...
                                       TimeIntegrator,StabilisationFactor);
reduced_matrix             =  Assembly.total_matrix;
reduced_matrix(fixdof,:)   =  [];
reduced_matrix(:,fixdof)   =  [];
condNumber0                =  condest(reduced_matrix);                                       

%--------------------------------------------------------------------------
% Check stabilisation factor 0
%--------------------------------------------------------------------------
StabilisationFactor        =  0;                         
Assembly                   =  FEMAssembly(Data,NR.nonlinearity,Geometry,...
                                           Mesh,FEM,Quadrature,Assembly,...
                                          MatInfo,Optimisation,Solution,...
                                       TimeIntegrator,StabilisationFactor);
reduced_matrix             =  Assembly.total_matrix;
reduced_matrix(fixdof,:)   =  [];
reduced_matrix(:,fixdof)   =  [];
condNumber                 =  condest(reduced_matrix);                                       
UserDefinedFactor          =  1.6;
%--------------------------------------------------------------------------
% Bisection prodecure to adjust the stabilisation pasrameter
%--------------------------------------------------------------------------
if condNumber>UserDefinedFactor*condNumber0
   convergence  =  0;
   maxfactor  =  1;
   minfactor  =  0;
   Niter  =  5;
   iter   =  0;
   while ~convergence
       iter                 =  iter + 1;
       StabilisationFactor  =  0.5*(maxfactor + minfactor);
       Assembly             =  FEMAssembly(Data,NR.nonlinearity,Geometry,...
                                           Mesh,FEM,Quadrature,Assembly,...
                                           MatInfo,Optimisation,Solution,...
                                        TimeIntegrator,StabilisationFactor);
       reduced_matrix             =  Assembly.total_matrix;
       reduced_matrix(fixdof,:)   =  [];
       reduced_matrix(:,fixdof)   =  [];
       condNumber                 =  condest(reduced_matrix);   
       %-------------------------------------------------------------------
       % Determine new bounds for bisection
       %-------------------------------------------------------------------
       if condNumber>UserDefinedFactor*condNumber0
          minfactor  =  StabilisationFactor; 
       else
          maxfactor  =  StabilisationFactor;            
       end       
       %-------------------------------------------------------------------
       % Convergence criterion
       %-------------------------------------------------------------------
       if (iter>Niter && condNumber<UserDefinedFactor*condNumber0)
           convergence = 1;
       end
   end
end
   
fprintf('\n Stabilisation Factor for Adjoint problem = %f\n',StabilisationFactor)   

