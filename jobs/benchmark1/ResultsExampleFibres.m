function ResultsExampleFibres

%CodePath  =  'C:\SoftwareDevelopment\OptimisationProjectCiudadReal';
%JobsPath  =  'C:\SoftwareDevelopment\OptimisationProjectCiudadReal\jobs\MBBv2';
CodePath  =  'P:\TopologyCode';
JobsPath  =  'P:\TopologyCode\jobs\MBBv2\Results for Meeting Friday\resultsVolume_fraction_0.4_MooneyRivlinTI_model_load_factor_2.5333\N10';
%--------------------------------------------------------------------------
% Path to the code  
%--------------------------------------------------------------------------
if ~exist(CodePath,'dir')
    error('No such folder or directory');
end
addpath(genpath(fullfile(CodePath,'code')));
addpath(JobsPath);
%--------------------------------------------------------------------------
% Simulation 1  
%--------------------------------------------------------------------------
jobfolder  =  'P:\TopologyCode\jobs\MBBv2\Results for Meeting Friday\resultsVolume_fraction_0.4_MooneyRivlinTI_model_load_factor_2.5333\N10';
addpath(genpath(fullfile(jobfolder)));
load_    =  245;
cd(jobfolder);
load(['Results_Optimisation_Iteration_' num2str(load_) '.mat']);
PostProcessorMBBPlaneStress(jobfolder,Mesh,Solution,Optimisation,...
                      Geometry,FEM,MatInfo,Quadrature,PostProc);
%--------------------------------------------------------------------------
% Simulation 2
%--------------------------------------------------------------------------
jobfolder  =  'P:\TopologyCode\jobs\MBBv2\Results for Meeting Friday\resultsVolume_fraction_0.4_MooneyRivlinTI_model_load_factor_2.5333\N01';
addpath(genpath(fullfile(jobfolder)));
load_   =  300;
cd(jobfolder);
load(['Results_Optimisation_Iteration_' num2str(load_) '.mat']);
PostProcessorMBBPlaneStress(jobfolder,Mesh,Solution,Optimisation,...
                      Geometry,FEM,MatInfo,Quadrature,PostProc);
%--------------------------------------------------------------------------
% Simulation 3
%--------------------------------------------------------------------------
jobfolder  =  'P:\TopologyCode\jobs\MBBv2\Results for Meeting Friday\resultsVolume_fraction_0.4_MooneyRivlinTI_model_load_factor_2.5333\N11';
addpath(genpath(fullfile(jobfolder)));
load_   =  228;
cd(jobfolder);
load(['Results_Optimisation_Iteration_' num2str(load_) '.mat']);
PostProcessorMBBPlaneStress(jobfolder,Mesh,Solution,Optimisation,...
                      Geometry,FEM,MatInfo,Quadrature,PostProc);

                  