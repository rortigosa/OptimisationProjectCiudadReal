function [jobfolder,results_folder]  =  JobFolderID(dir_name)
%--------------------------------------------------------------------------
% Directory for current filename
%--------------------------------------------------------------------------
n_dir_sep  =  0;
for ichar=1:length(dir_name)
    if dir_name(ichar)==dirsep()
       n_dir_sep    =  n_dir_sep + 1;
       dir_sep_loc  =  ichar;
    end
end
%--------------------------------------------------------------------------
% Create results folder
%--------------------------------------------------------------------------   
%filename  =  dir_name(dir_sep_loc+1:length(dir_name));
jobfolder =  dir_name(1:dir_sep_loc-1);
results_folder  =  'results';
mkdir(jobfolder,results_folder);
