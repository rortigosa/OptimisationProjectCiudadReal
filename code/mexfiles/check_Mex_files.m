%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Compute elemental residuals and stiffness matrices for U formulation
% using Mex files. Combination of nonlinear and linear models
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
    basedir_fem        =  'C:\SoftwareDevelopment\OPTIMISATION_CODE\';
    addpath(genpath(fullfile(basedir_fem,'code')));
    addpath(genpath(fullfile(basedir_fem,'main')));




ndim         =  2;
ngauss       =  4;
n_node_elem  =  4;
x_elem       =  rand(ndim,n_node_elem);
X_elem       =  rand(ndim,n_node_elem);
DN_chi       =  rand(ndim,n_node_elem,ngauss);
Weight       =  rand(ngauss,1);
mat_parameters.MRivlin.mu1    =  1.1;
mat_parameters.MRivlin.mu2    =  1.2;
mat_parameters.MRivlin.kappa  =  1.3;
density                       =  0.7;
Klinear                       =  rand(ndim*n_node_elem);
tic
for i=1:200*200
%--------------------------------------------------------------------------
% kinematics
%--------------------------------------------------------------------------
%kinematics         =  KinematicsFunctionVolume(ndim,x_elem,DN_chi);  


[F,H,J,DNX,...
  IntWeight]  =  KinematicsFunctionMexC(x_elem,X_elem,DN_chi,Weight);
%--------------------------------------------------------------------------
% Compute Piola and the Elasticity tensor for the nonlinear model
%--------------------------------------------------------------------------
% [Piola,...
%  Elasticity]  =  MooneyRivlinMexC(mat_parameters.MRivlin.mu1,...
%                                   mat_parameters.MRivlin.mu2,...
%                                   mat_parameters.MRivlin.kappa,F,H,J);
% %--------------------------------------------------------------------------
% % Compute the residuals for the nonlinear model
% %--------------------------------------------------------------------------
% Rx            =  ResidualsUFormulationMexC(DNX,Piola,IntWeight);
% %--------------------------------------------------------------------------
% % Compute the stiffness matrix for the nonlinear model
% %--------------------------------------------------------------------------
% Kxx           =  TangentOperatorUFormulationMexC(DNX,Elasticity,IntWeight);
% %--------------------------------------------------------------------------
% % Compute displacements in the element
% %--------------------------------------------------------------------------
% u             =  x_elem - X_elem;
% %--------------------------------------------------------------------------
% % Determine residual and stiffness combining nonlinear and linear models
% %--------------------------------------------------------------------------
% Rx            =  density*Rx + (1 - density)*(Klinear*u(:));
% Kxx           =  density*Kxx + (1 - density)*Klinear;
end
toc

