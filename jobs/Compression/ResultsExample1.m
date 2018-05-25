function ResultsExample1

CodePath  =  'C:\SoftwareDevelopment\OptimisationProjectCiudadReal';
JobsPath  =  'C:\SoftwareDevelopment\OptimisationProjectCiudadReal\jobs\MBBv2';
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
jobfolder  =  'C:\SoftwareDevelopment\OptimisationProjectCiudadReal\jobs\MBBv2\Results for Meeting Friday\resultsVolume_fraction_0.4_MooneyRivlin_model_load_factor_5.0667e-05';
addpath(genpath(fullfile(jobfolder)));
load_    =  204;
cd(jobfolder);
load(['Results_Optimisation_Iteration_' num2str(load_) '.mat']);
PostProcessorMBBPlaneStress(jobfolder,Mesh,Solution,Optimisation,...
                      Geometry,FEM,MatInfo,Quadrature,PostProc);
%--------------------------------------------------------------------------
% Simulation 2
%--------------------------------------------------------------------------
jobfolder  =  'C:\SoftwareDevelopment\OptimisationProjectCiudadReal\jobs\MBBv2\Results for Meeting Friday\resultsVolume_fraction_0.4_MooneyRivlin_model_load_factor_0.0050667';
addpath(genpath(fullfile(jobfolder)));
load_   =  290;
cd(jobfolder);
load(['Results_Optimisation_Iteration_' num2str(load_) '.mat']);
PostProcessorMBBPlaneStress(jobfolder,Mesh,Solution,Optimisation,...
                      Geometry,FEM,MatInfo,Quadrature,PostProc);
%--------------------------------------------------------------------------
% Simulation 3
%--------------------------------------------------------------------------
jobfolder  =  'C:\SoftwareDevelopment\OptimisationProjectCiudadReal\jobs\MBBv2\Results for Meeting Friday\resultsVolume_fraction_0.4_MooneyRivlin_model_load_factor_0.0025333';
addpath(genpath(fullfile(jobfolder)));
load_   =  200;
cd(jobfolder);
load(['Results_Optimisation_Iteration_' num2str(load_) '.mat']);
PostProcessorMBBPlaneStress(jobfolder,Mesh,Solution,Optimisation,...
                      Geometry,FEM,MatInfo,Quadrature,PostProc);
%--------------------------------------------------------------------------
% Simulation 4
%--------------------------------------------------------------------------
jobfolder  =  'C:\SoftwareDevelopment\OptimisationProjectCiudadReal\jobs\MBBv2\Results for Meeting Friday\resultsVolume_fraction_0.4_MooneyRivlin_model_load_factor_0.0152';
addpath(genpath(fullfile(jobfolder)));
load_   =  260;
cd(jobfolder);
load(['Results_Optimisation_Iteration_' num2str(load_) '.mat']);
PostProcessorMBBPlaneStress(jobfolder,Mesh,Solution,Optimisation,...
                      Geometry,FEM,MatInfo,Quadrature,PostProc);
%--------------------------------------------------------------------------
% Simulation 5
%--------------------------------------------------------------------------
jobfolder  =  'C:\SoftwareDevelopment\OptimisationProjectCiudadReal\jobs\MBBv2\Results for Meeting Friday\resultsVolume_fraction_0.4_MooneyRivlin_model_load_factor_0.0304';
addpath(genpath(fullfile(jobfolder)));
load_   =  301;
cd(jobfolder);
load(['Results_Optimisation_Iteration_' num2str(load_) '.mat']);
PostProcessorMBBPlaneStress(jobfolder,Mesh,Solution,Optimisation,...
                      Geometry,FEM,MatInfo,Quadrature,PostProc);
%--------------------------------------------------------------------------
% Simulation 6
%--------------------------------------------------------------------------
jobfolder  =  'C:\SoftwareDevelopment\OptimisationProjectCiudadReal\jobs\MBBv2\Results for Meeting Friday\resultsVolume_fraction_0.4_MooneyRivlin_model_load_factor_0.0456';
addpath(genpath(fullfile(jobfolder)));
load_   =  267;
cd(jobfolder);
load(['Results_Optimisation_Iteration_' num2str(load_) '.mat']);
PostProcessorMBBPlaneStress(jobfolder,Mesh,Solution,Optimisation,...
                      Geometry,FEM,MatInfo,Quadrature,PostProc);
%--------------------------------------------------------------------------
% Simulation 7
%--------------------------------------------------------------------------
jobfolder  =  'C:\SoftwareDevelopment\OptimisationProjectCiudadReal\jobs\MBBv2\Results for Meeting Friday\resultsVolume_fraction_0.4_MooneyRivlin_model_load_factor_0.0608';
addpath(genpath(fullfile(jobfolder)));
load_   =  301;
cd(jobfolder);
load(['Results_Optimisation_Iteration_' num2str(load_) '.mat']);
PostProcessorMBBPlaneStress(jobfolder,Mesh,Solution,Optimisation,...
                      Geometry,FEM,MatInfo,Quadrature,PostProc);

                  