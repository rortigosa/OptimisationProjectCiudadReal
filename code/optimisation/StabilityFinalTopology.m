function StabilityFinalTopology(Optimisation,Data,NR,Geometry,Mesh,FEM,...
                     Quadrature,Assembly,MatInfo,Bc,Solution,UserDefinedFuncs,...
                     TimeIntegrator)

%--------------------------------------------------------------------------
% Select nonlinear analysis
%--------------------------------------------------------------------------
NR.load_increments          =  300;
NR.nonlinearity             =  'nonlinear';
%--------------------------------------------------------------------------
% Extreme filter for densities
%--------------------------------------------------------------------------
cutoff  =  0.1;
Optimisation.density(Optimisation.density>=cutoff) =  1;
Optimisation.density(Optimisation.density<cutoff)  =  0;
%--------------------------------------------------------------------------
% Nonlinear analysis
%--------------------------------------------------------------------------
[Solution,~]  =  IncrementalNewtonRaphson(Data,NR,Geometry,Mesh,...
                           FEM,Quadrature,Assembly,MatInfo,Optimisation,...
                           Bc,Solution,UserDefinedFuncs,TimeIntegrator,'~');
%--------------------------------------------------------------------------                       
% Criteria for instability
%--------------------------------------------------------------------------                       
if Solution.instability
    fprintf('-------------------------------------------\n')
    fprintf('The current topological design is unstable \n');
    fprintf('-------------------------------------------\n')
else
    fprintf('-------------------------------------------\n')
    fprintf('The current topological design is stable \n');
    fprintf('-------------------------------------------\n')    
end