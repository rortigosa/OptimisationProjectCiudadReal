%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Input file of the problem
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% function run_example_v2(CodePath,GeometryPreprocessor,UserDefinedNodalLoads,UserDefinedModel)
%function run_example_v2(CodePath)
CodePath=  'C:\SoftwareDevelopment\OPTIMISATION_CODE';

clc                              
% %--------------------------------------------------------------------------
% % Path to the code 
% %--------------------------------------------------------------------------
% CodePath  =  'C:\SoftwareDevelopment\OPTIMISATION_CODE\code';
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
% Different load factors to be used 
%--------------------------------------------------------------------------
max_load_factor         =  7;    %  Maximum load factor applied on the constant force
N_load_increments       =  1e2;  %  Number of load factors
Volfrac                 =  0.4;
rmin                    =  2;
%--------------------------------------------------------------------------
%  
%--------------------------------------------------------------------------
str                                          =  InitialData;
str.UserDefinedFuncs.Geometry                =  @ GeometryPreprocessor;
str.UserDefinedFuncs.MechanicalDirichletBCs  =  @ UserDefinedDirichlet;
str.UserDefinedFuncs.NodalLoads              =  @ UserDefinedNodalLoads;
str.UserDefinedFuncs.MaterialParameters      =  @ UserDefinedModel;
%--------------------------------------------------------------------------
% Select material parameters               
%--------------------------------------------------------------------------
model{1}                =  'Mooney_Rivlin';
% model{2}              =  'Neo_Hookean';
% model{3}              =  'Arruda_Boyce';
% model{4}              =  'Gent';
% model{5}              =  'Yeoh';   
model_void{1}           =  'Mooney_Rivlin';
% model_void{2}         =  'MooneyRivlin';  
% model_void{3}         =  'MooneyRivlin'; 
% model_void{4}         =  'MooneyRivlin';
% model_void{5}         =  'MooneyRivlin';
%--------------------------------------------------------------------------
% Run Optimisation solver          
%--------------------------------------------------------------------------
OptimisationSolver(str,model,model_void,max_load_factor,...
                   N_load_increments,Volfrac,rmin,[jobfolder dirsep() results_folder]);

% OptimisationSolver(str,GeometryPreprocessor,MechanicalDirichletConstraints,UserDefinedNodalLoads,...
%                    UserDefinedModel,model,model_void,max_load_factor,...
%                    N_load_increments,Volfrac,rmin,jobfolder,results_folder);


