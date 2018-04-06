
function   [init_kinematics,dim,x_elem,DNX]  =  KinematicsFunctionVolumeCInitial(dim,x_elem,DNX)
%--------------------------------------------------------------------------
% Initialise inputs
%--------------------------------------------------------------------------
% dim                =  2;
% x_elem             =  zeros(dim,4);
% DNX                =  zeros(dim,4,4);
% kinematics.F       =  zeros(dim,dim,4);
% kinematics.H       =  zeros(dim,dim,4);
% kinematics.J       =  zeros(4,1);
%--------------------------------------------------------------------------
% Initialise outputs
%--------------------------------------------------------------------------
init_kinematics.F  =  zeros(dim,dim,4);
init_kinematics.H  =  init_kinematics.F;
init_kinematics.J  =  zeros(4,1);


% init_kinematics.F  =  kinematics.F;
% init_kinematics.H  =  kinematics.H;
% init_kinematics.J  =  kinematics.J;
%--------------------------------------------------------------------------
% Call the function
%--------------------------------------------------------------------------
%init_kinematics    =  KinematicsFunctionVolumeC(init_kinematics,dim,x_elem,DNX);    
