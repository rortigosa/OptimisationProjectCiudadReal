%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Kinematics of the continuum
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [FEM,Quadrature]    =  MaterialGradientShapeFunctions(dim,FEM,Quadrature,Solution,Mesh) 

DN_chi                       =  FEM.DN_chi;
Xelem                        =  Solution.x.Lagrangian_X(:,Mesh.connectivity(:,1));
n_gauss                      =  size(DN_chi,3);
n_node_elem                  =  size(Xelem,2);
DX_chi_Jacobian              =  zeros(n_gauss,1);
DN_X                         =  zeros(dim,n_node_elem,n_gauss);
for igauss=1:n_gauss
    %----------------------------------------------------------------------
    % Compute derivative of displacements (Dx0DX)
    %----------------------------------------------------------------------
    DX_chi                   =  Xelem*DN_chi(:,:,igauss)';    
    DNX                      =  (DX_chi')\DN_chi(:,:,igauss);
    %----------------------------------------------------------------------
    %  Storing information.   
    %----------------------------------------------------------------------
    DX_chi_Jacobian(igauss)  =  abs(det(DX_chi));
    DN_X(:,:,igauss)         =  DNX;
end

FEM.DN_X                     =  DN_X;
Quadrature.IntWeight         =  Quadrature.W_v.*DX_chi_Jacobian;
FEM.DX_chi_Jacobian          =  DX_chi_Jacobian;




