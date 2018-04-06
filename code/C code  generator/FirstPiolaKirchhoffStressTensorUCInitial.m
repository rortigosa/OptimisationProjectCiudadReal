
%
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
Piola                =  zeros(2,2,4);
ngauss               =  4;
dim                  =  2;
F                    =  zeros(2,2,4);
H                    =  zeros(2,2,4);
J                    =  zeros(4,1);
DUDF                 =  zeros(2,2,4);
DUDH                 =  zeros(2,2,4);
DUDJ                 =  zeros(4,1);

% init_kinematics.F  =  kinematics.F;
% init_kinematics.H  =  kinematics.H;
% init_kinematics.J  =  kinematics.J;
%--------------------------------------------------------------------------
% Call the function
%--------------------------------------------------------------------------
%init_kinematics    =  KinematicsFunctionVolumeC(init_kinematics,dim,x_elem,DNX);    
Piola       =  FirstPiolaKirchhoffStressTensorUC(Piola,ngauss,dim,F,H,DUDF,DUDH,DUDJ);



