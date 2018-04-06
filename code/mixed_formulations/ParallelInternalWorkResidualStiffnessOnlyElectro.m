function asmb     =  ParallelInternalWorkResidualStiffnessOnlyElectro(ielem,quadrature,solution,...
                                                                      geometry,mesh,fem,vectorisation,mat_info)
%--------------------------------------------------------------------------
% Number of Gauss points
%--------------------------------------------------------------------------
ngauss            =  size(quadrature.volume.bilinear.Chi,1);
%--------------------------------------------------------------------------
% Initialise assembled residuals per element 
%--------------------------------------------------------------------------
asmb              =  ElementResidualMatricesInitialisationOnlyElectro(mesh);
%--------------------------------------------------------------------------
% Value of the electric displacement field
%--------------------------------------------------------------------------
D0                =  solution.D0(:,:,ielem);
%--------------------------------------------------------------------------
% Obtain gradients of kinematics and electrical variables
%--------------------------------------------------------------------------
kinematics        =  KinematicsFunctionVolume(geometry.dim,...
                                          solution.x.Lagrangian_X(:,mesh.volume.x.connectivity(:,ielem)),...
                                          solution.x.Lagrangian_X(:,mesh.volume.x.connectivity(:,ielem)),...
                                          fem.volume.bilinear.phi.DN_chi);
[E0,DN_X_phi]     =  ElectricFieldComputation(geometry.dim,solution.phi(mesh.volume.phi.connectivity(:,ielem)),...                                          
                                          fem.volume.bilinear.phi.DN_chi,kinematics.DX_chi);
%--------------------------------------------------------------------------
% Obtain D0 give E0 (and F,H, J)
%--------------------------------------------------------------------------
D0                =  NewtonRaphsonLegendreTransformOnlyElectro(ielem,geometry.dim,ngauss,...
                                                           D0,E0,vectorisation,mat_info);  
%--------------------------------------------------------------------------
% First and second derivatives of the model. 
%--------------------------------------------------------------------------
mat_info          =  GetDerivativesModelOnlyElectro(ielem,geometry.dim,ngauss,D0,mat_info);
%--------------------------------------------------------------------------
% Residuals and Stiffness matrices 
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Int_weight    =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Residual Gauss' law.- (D0'*DN_X*W*J_t)'
    %----------------------------------------------------------------------
    asmb.Tphi     =  asmb.Tphi  + (DN_X_phi(:,:,igauss)'*D0(:,igauss))*Int_weight;
end      
%--------------------------------------------------------------------------
% Residuals and Stiffness matrices 
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Int_weight    =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    % Stiffness matrices
    %----------------------------------------------------------------------
    asmb.Kphiphi  =  asmb.Kphiphi  + (DN_X_phi(:,:,igauss)'*(mat_info.derivatives.D2Psi.D2PsiDE0DE0(:,:,igauss)*DN_X_phi(:,:,igauss)))*Int_weight;
end 




