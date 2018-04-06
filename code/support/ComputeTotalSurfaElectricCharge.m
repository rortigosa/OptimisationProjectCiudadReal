function Q          =  ComputeTotalSurfaElectricCharge(dim,fem,solution,mesh,quadrature)

%--------------------------------------------------------------------------
% Initialise the charge Q
%--------------------------------------------------------------------------
Q                   =  0;
ngauss              =  
%--------------------------------------------------------------------------
% Integral of the charge 
%--------------------------------------------------------------------------
for iedge=1:size(mesh.surface.x.boundary_edges,2)
    q               =  ScalarFEMInterpolation(fem.surface.BEM_FEM.q.N,solution.q(mesh.surface.q.connectivity(:,iedge)));
    %----------------------------------------------------------------------
    % Obtain gradients of kinematics and electrical variables 
    %----------------------------------------------------------------------
    volume_element  =  mesh.surface.phi.volume_elements(:,iedge);
    kinematics      =  KinematicsFunctionSurface(dim,...
                       solution.x.Lagrangian_X(:,mesh.surface.phi.boundary_edges(:,iedge)),...
                       solution.x.Lagrangian_X(:,mesh.surface.phi.boundary_edges(:,iedge)),...
                       solution.x.Lagrangian_X(:,mesh.volume.phi.connectivity(:,volume_element)),...
                       fem.surface.BEM_FEM.phi.N,fem.surface.BEM_FEM.phi.DN_chi);                                         
    for igauss=1:ngauss
        %------------------------------------------------------------------
        % Integration weight
        %------------------------------------------------------------------
        Int_weight  =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.surface.BEM_FEM.W_v(igauss);
        Q           =  Q  +  q(igauss)*Int_weight;
    end
end
