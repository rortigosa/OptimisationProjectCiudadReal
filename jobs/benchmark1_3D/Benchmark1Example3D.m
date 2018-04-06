%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Input file of the problem
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
CodePath=  'C:\SoftwareDevelopment\OptimisationProjectCiudadReal';

clc                              
%--------------------------------------------------------------------------
% Path to the code 
%--------------------------------------------------------------------------
if ~exist(CodePath,'dir')
    error('No such folder or directory');
end
addpath(genpath(fullfile(CodePath,'code')));
%--------------------------------------------------------------------------
% Directory name      
%--------------------------------------------------------------------------
dir_name   =  mfilename('fullpath');
[jobfolder, results_folder]  =  JobFolderID(dir_name); 
addpath(genpath(fullfile(jobfolder)));
%--------------------------------------------------------------------------
%  User-Defined Functions           
%--------------------------------------------------------------------------
ExampleData                              =  UserDefinedExampleData;
Optimisation                             =  UserDefinedOptimisation;
Data                                     =  UserDefinedInitialData;
[FEM,Quadrature]                         =  UserDefinedFEMGaussQuadrature;
NR                                       =  UserDefinedNR;
  
UserDefinedFuncs.Geometry                =  @ GeometryPreprocessor;
UserDefinedFuncs.MechanicalDirichletBCs  =  @ UserDefinedDirichlet;
UserDefinedFuncs.NodalLoads              =  @ UserDefinedNodalLoads;
MatInfo                                  =  UserDefinedModel;
%--------------------------------------------------------------------------
% Run Optimisation solver                
%--------------------------------------------------------------------------
OptimisationSolver(ExampleData,Optimisation,Data,FEM,Quadrature,NR,UserDefinedFuncs,MatInfo,'~',[jobfolder dirsep() results_folder]);

