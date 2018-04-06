N                                      =  50000;
dim                                    =  2;
ngauss                                 =  4;
n_node_elem                            =  4;
x_elem                                 =  rand(dim,n_node_elem);
X_elem                                 =  rand(dim,n_node_elem);
DN_chi                                 =  rand(dim,n_node_elem,ngauss);

tic
for i=1:N
[FFF,HHH,JJJ,DNXXX,dttt]               =  KinematicsFunctionVolumeCVersion(dim,ngauss,x_elem,X_elem,DN_chi);
% kinematics.F                           =  FF;
% kinematics.H                           =  HH;
% kinematics.J                           =  JJ;
end
toc
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Kinematics with Matlab
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
tic
for i=1:N
n_gauss                                 =  size(DN_chi,3);
n_node_elem                             =  size(x_elem,2);
kinematics.F                            =  zeros(dim,dim,n_gauss);
kinematics.H                            =  zeros(dim,dim,n_gauss);
kinematics.J                            =  zeros(n_gauss,1);
kinematics.DX_chi_Jacobian              =  zeros(n_gauss,1);
kinematics.DX_chi                       =  zeros(dim,dim,n_gauss);
DN_X_x                                  =  zeros(dim,n_node_elem,n_gauss);
for igauss=1:n_gauss
    %----------------------------------------------------------------------
    % Compute derivative of displacements (Dx0DX)
    %----------------------------------------------------------------------
    DX_chi                              =  X_elem*DN_chi(:,:,igauss)';    
    DN_X                                =  (DX_chi')\DN_chi(:,:,igauss);
    Dx0DX                               =  x_elem*DN_X';
    %------------------------------------------------------------------
    % Compute deformation gradient tensor
    %------------------------------------------------------------------
    F                                   =  Dx0DX;
    H                                   =  Cofactor(F,dim);
    J                                   =  det(F);
    %------------------------------------------------------------------
    %  Storing information.
    %------------------------------------------------------------------
    kinematics.F(:,:,igauss)            =  F;
    kinematics.H(:,:,igauss)            =  H;
    kinematics.J(igauss)                =  J;
    kinematics.DX_chi(:,:,igauss)       =  DX_chi;
    kinematics.DX_chi_Jacobian(igauss)  =  abs(det(DX_chi));
    DN_X_x(:,:,igauss)                  =  DN_X;
end
end
toc

