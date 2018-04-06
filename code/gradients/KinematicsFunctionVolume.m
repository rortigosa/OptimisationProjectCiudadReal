%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Kinematics of the continuum
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function kinematics                     =  KinematicsFunctionVolume(dim,x_elem,DNX) 

n_gauss                                 =  size(DNX,3);
kinematics.F                            =  zeros(dim,dim,n_gauss);
kinematics.H                            =  zeros(dim,dim,n_gauss);
kinematics.J                            =  zeros(n_gauss,1);
for igauss=1:n_gauss
    %----------------------------------------------------------------------
    % Compute derivative of displacements (Dx0DX)
    %----------------------------------------------------------------------
    Dx0DX                               =  x_elem*DNX(:,:,igauss)';
    %----------------------------------------------------------------------
    % Compute deformation gradient tensor
    %----------------------------------------------------------------------
    F                                   =  Dx0DX;
    H                                   =  Cofactor(F,dim);
    J                                   =  det(F);
    %----------------------------------------------------------------------
    %  Storing information.
    %----------------------------------------------------------------------
    kinematics.F(:,:,igauss)            =  F;
    kinematics.H(:,:,igauss)            =  H;
    kinematics.J(igauss)                =  J;
end




