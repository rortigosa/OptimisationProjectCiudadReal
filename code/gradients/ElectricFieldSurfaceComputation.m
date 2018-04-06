%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Kinematics of the continuum
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [E0,DN_X_phi]       =  ElectricFieldSurfaceComputation(dim,phi_elem,DN_chi,DX_chi) 

n_gauss                      =  size(DN_chi,3);
n_node_elem                  =  size(phi_elem,1);
DN_chi_complete              =  zeros(size(DN_chi,1)+1,size(DN_chi,2),size(DN_chi,3));
DN_chi_complete(1:dim-1,:,:) =  DN_chi;                

E0                           =  zeros(dim,n_gauss);
DN_X_phi                     =  zeros(dim,n_node_elem,n_gauss);
for igauss=1:n_gauss
    %----------------------------------------------------------------------
    % Compute derivative of displacements (Dx0DX)
    %----------------------------------------------------------------------
    DN_X_phi(:,:,igauss)     =  (DX_chi(:,:,igauss)')\DN_chi_complete(:,:,igauss);
    E0(:,igauss)             =  -DN_X_phi(:,:,igauss)*phi_elem;
end




