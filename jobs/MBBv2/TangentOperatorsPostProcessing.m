function TangentOperatorsPostProcessing

CodePath  =  'P:\TopologyCode\code'; 
JobsPath  =  'P:\TopologyCode\jobs\MBBv2';
InputPath =  'P:\TopologyCode\jobs\MBBv2\input_file';
%--------------------------------------------------------------------------
% Path to the code  
%--------------------------------------------------------------------------
if ~exist(CodePath,'dir')
    error('No such folder or directory');
end
addpath(genpath(fullfile(CodePath,'code')));
addpath(JobsPath);
addpath(InputPath);


%--------------------------------------------------------------------------
% Simulation 1  
%--------------------------------------------------------------------------
jobfolder  =  'P:\TopologyCode\jobs\MBBv2\Results for Meeting Friday\resultsVolume_fraction_0.4_MooneyRivlin_model_load_factor_0.0304';
addpath(genpath(fullfile(jobfolder)));

for iload=110:200
cd(jobfolder);  
load(['Results_Optimisation_Iteration_' num2str(iload) '.mat']);
fprintf('\n---------------')                 
fprintf('\n Load number %d\n',iload)                 
fprintf('---------------\n')                 
%--------------------------------------------------------------------------
% Solve again the problem using linearised incremental approach
%---------------------------------------------------------------------------
Solution.old.x.Eulerian_x   =  Solution.x.Lagrangian_X;
[Solution,...
    Optimisation]           =  LinearisedConvexifiedSolver(Data,NR,Geometry,Mesh,...
                                   FEM,Quadrature,Assembly,MatInfo,Optimisation,...
                                   Bc,Solution,UserDefinedFuncs,TimeIntegrator,'~');

%--------------------------------------------------------------------------
% Plot Tangent Operator
%---------------------------------------------------------------------------
PlotTangentOperators(Geometry,Mesh,FEM,MatInfo,Solution,...
                     8,1,['Tensors_' num2str(iload) '.vtk']);
end
                  