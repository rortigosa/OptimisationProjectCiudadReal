%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Kinematics of the continuum
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [kinematics,DN_X_x]            =  KinematicsFunctionSurface(dim,x_elem,X_elem,xvolume,N,DN_chi) 

n_gauss                                 =  size(DN_chi,3);
DN_chi_complete                         =  zeros(size(DN_chi,1)+1,size(DN_chi,2),size(DN_chi,3));
DN_chi_complete(1:dim-1,:,:)            =  DN_chi;                

xcenter                                 =  sum(xvolume,2)/size(xvolume,2);

n_node_elem                             =  size(x_elem,2);
kinematics.F                            =  zeros(dim,dim,n_gauss);
kinematics.H                            =  zeros(dim,dim,n_gauss);
kinematics.J                            =  zeros(n_gauss,1);
kinematics.FminusT                      =  zeros(dim,dim,n_gauss);
kinematics.DX_chi_Jacobian              =  zeros(n_gauss,1);
kinematics.DX_chi                       =  zeros(dim,dim,n_gauss);
kinematics.Normal_vector                =  zeros(dim,n_gauss);
DN_X_x                                  =  zeros(dim,n_node_elem,n_gauss);
for igauss=1:n_gauss
    xgauss                              =  x_elem*N(:,igauss);
    r                                   =  xgauss - xcenter;
    %----------------------------------------------------------------------
    % Compute derivative of displacements (Dx0DX)
    %----------------------------------------------------------------------
    DX_chi                              =  X_elem*DN_chi_complete(:,:,igauss)';    
    %Normal_vector                      =  CrossProduct(dim,DX_chi(:,1),DX_chi(:,2));  
    Normal_vector                       =  NormalVectorSurface(dim,DX_chi(:,1),DX_chi(:,2));  
    Normal_vector                       =  sign(Normal_vector'*r)*Normal_vector;    
    DX_chi(:,dim)                       =  Normal_vector;
    DN_X                                =  (DX_chi')\DN_chi_complete(:,:,igauss);
    Dx0DX                               =  x_elem*DN_X';
    %----------------------------------------------------------------------
    % Invertible deformation gradient tensor
    %----------------------------------------------------------------------
    Dx_chi                              =  X_elem*DN_chi_complete(:,:,igauss)';    
    normal_vector                       =  NormalVectorSurface(dim,Dx_chi(:,1),Dx_chi(:,2));  
    normal_vector                       =  sign(normal_vector'*r)*normal_vector;    
    Finvertible                         =  Dx0DX + normal_vector*Normal_vector';
    FminusT                             =  (Finvertible\eye(dim))';
    %----------------------------------------------------------------------
    % Compute deformation gradient tensor
    %----------------------------------------------------------------------
    F                                   =  Dx0DX;
    H                                   =  Cofactor(Finvertible,dim);
    J                                   =  det(Finvertible);
    %----------------------------------------------------------------------
    %  Storing information.
    %----------------------------------------------------------------------
    kinematics.F(:,:,igauss)            =  F;
    kinematics.H(:,:,igauss)            =  H;
    kinematics.J(igauss)                =  J;
    kinematics.FminusT(:,:,igauss)      =  FminusT;
    kinematics.DX_chi(:,:,igauss)       =  DX_chi;
    kinematics.DX_chi_Jacobian(igauss)  =  abs(det(DX_chi));
    DN_X_x(:,:,igauss)                  =  DN_X;
    kinematics.Normal_vector(:,igauss)  =  Normal_vector;
end




