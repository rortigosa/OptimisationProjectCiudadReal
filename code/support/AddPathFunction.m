%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Add to path function
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function str                            =  AddPathFunction(str,input) 

addpath(genpath(fullfile(basedir_fem,'code')));
addpath(genpath(fullfile(basedir_fem,'main')));   
addpath((fullfile(basedir_fem,'jobs'))); 
jobfolder                               =  input.jobfolder;
str.jobfolder                           =  input.jobfolder;
addpath (genpath(jobfolder))
str.jobfolder                           =  jobfolder;
