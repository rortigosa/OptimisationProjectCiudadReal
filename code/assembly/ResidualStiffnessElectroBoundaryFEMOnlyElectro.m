%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the elemental residual vectors and stiffness
% matrices for the formulation with fields: x-phi-p
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function asmb       =  ResidualStiffnessElectroBoundaryFEMOnlyElectro(iedge,dim,quadrature,fem,mesh,solution,...
                                                                      mat_info)
%--------------------------------------------------------------------------
% Number of Gauss points 
%--------------------------------------------------------------------------
ngauss              =  size(quadrature.surface.bilinear.Chi,1);
%--------------------------------------------------------------------------
% Initialise residuals and stiffness matrices for each element
%--------------------------------------------------------------------------
asmb                =  ElementResidualMatricesInitialisationOnlyElectroBoundary(mesh);
%--------------------------------------------------------------------------
% Permittivity of vaccum
%--------------------------------------------------------------------------
e0                  =  mat_info.vacuum_electric_permittivity;
%--------------------------------------------------------------------------
% Obtain the value of the flux field q0
%--------------------------------------------------------------------------
q                   =  ScalarFEMInterpolation(fem.surface.bilinear.q.N,solution.q(mesh.surface.q.connectivity(:,iedge)));
%---------------------------------------------------------- ----------------
% Obtain gradients of kinematics and electrical variables
%--------------------------------------------------------------------------
kinematics          =  KinematicsFunctionSurface(dim,solution.x.Lagrangian_X(:,mesh.surface.x.boundary_edges(:,iedge)),...
                                solution.x.Lagrangian_X(:,mesh.surface.x.boundary_edges(:,iedge)),...
                                solution.x.Lagrangian_X(:,mesh.volume.x.connectivity(:,mesh.surface.x.volume_elements(iedge))),...
                                fem.surface.bilinear.x.N,fem.surface.bilinear.x.DN_chi);                                         
%--------------------------------------------------------------------------
% Residuals 
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Int_weight      =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.surface.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Residual Gauss' law.- (D0'*DN_X*W*J_t)'
    %----------------------------------------------------------------------
    asmb.Tphi       =  asmb.Tphi   +  e0*(q(igauss)*fem.surface.bilinear.phi.N(:,igauss))*Int_weight;
end      
%--------------------------------------------------------------------------
% Stiffness matrices 
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Int_weight      =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.surface.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices Kphiq
    %----------------------------------------------------------------------
    Kphiq           =  e0*(fem.surface.bilinear.phi.N(:,igauss)*fem.surface.bilinear.q.N(:,igauss)');
    %----------------------------------------------------------------------
    % Stiffness matrices
    %----------------------------------------------------------------------
    asmb.Kphiq    =  asmb.Kphiq    +  Kphiq*Int_weight;
end


