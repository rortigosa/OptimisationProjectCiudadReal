%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the elemental residual vectors and stiffness
% matrices for the formulation with fields: x-phi-p
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str                      =  InternalWorkResidualStiffnessElectro(ielem,str)

%--------------------------------------------------------------------------
% Value of the electric displacement field
%--------------------------------------------------------------------------
D0                                =  str.solution.D0(:,:,ielem);
%--------------------------------------------------------------------------
% Obtain gradients of kinematics and electrical variables
%--------------------------------------------------------------------------
[kinematics,DN_X_x]               =  KinematicsFunctionVolume(str.mesh.dim,...
                                             str.solution.x.Eulerian_x(:,str.mesh.volume.x.connectivity(:,ielem)),...
                                             str.solution.x.Lagrangian_X(:,str.mesh.volume.x.connectivity(:,ielem)),...
                                             str.fem.volume.bilinear.x.DN_chi);
[E0,DN_X_phi]                     =  ElectricFieldComputation(str.mesh.dim,...
                                             str.solution.phi(str.mesh.volume.phi.connectivity(:,ielem)),...
                                             str.fem.volume.bilinear.phi.DN_chi,...
                                             kinematics.DX_chi);
%--------------------------------------------------------------------------
% Obtain D0 give E0 (and F,H, J)
%--------------------------------------------------------------------------
D0                                =  NewtonRaphsonLegendreTransformElectro(kinematics,D0,E0,str.vectorisation,...
                                                 str.material_information.derivatives.DU,...
                                                 str.material_information.derivatives.D2U,...
                                                 str.material_information.derivatives.D2Uhat);                                                                                                              
%--------------------------------------------------------------------------
% d variable. 
%--------------------------------------------------------------------------
d                                 =  MatrixVectorMultiplication(kinematics.F,D0);
%--------------------------------------------------------------------------
% First and second derivatives of the model. 
%--------------------------------------------------------------------------
str.material_information          =  GetDerivativesModelElectro(ielem,kinematics.F,kinematics.H,kinematics.J,D0,d,str.material_information);
%--------------------------------------------------------------------------
% First Piola-Kirchhoff stress tensor.       
%--------------------------------------------------------------------------
Piola                             =  FirstPiolaKirchhoffStressTensorElectro(str.mesh.dim,kinematics,...
                                                          zeros(size(str.quadrature.volume.bilinear,Chi,1),1),...
                                                          str.material_information.derivatives.DU,D0);
Piola_vectorised                  =  reshape(permute(Piola,[2 1 3]),str.mesh.dim^2,[]);
%--------------------------------------------------------------------------
% Matrix BF   
%--------------------------------------------------------------------------
BF                                =  BMatrix(str.mesh.dim,str.mesh.volume.x.n_node_elem,DN_X_x,...
                                             str.vectorisation.Bx_matrix.LHS_indices,...
                                             str.vectorisation.Bx_matrix.RHS_indices);
%--------------------------------------------------------------------------
% Q matrices arising from the linearisation of H: DH[].SigmaH = Q*DF[]. and
%--------------------------------------------------------------------------
QF                                =  QMatrixComputation(kinematics.F);
QSigmaH                           =  QMatrixComputation(str.material_information.derivatives.DU.DUDH);    
%--------------------------------------------------------------------------
% Residuals 
%--------------------------------------------------------------------------
for igauss=1:size(str.quadrature.volume.bilinear.Chi,1)
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Integration_weight            =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Residual conservation of linear momentum.
    %----------------------------------------------------------------------
    element_assembly.Tx           =  element_assembly.Tx   +  ...
                                     (BF'*Piola_vectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual Gauss' law.- (D0'*DN_X*W*J_t)'
    %----------------------------------------------------------------------
    element_assembly.Tphi         =  element_assembly.Tphi   -  ...
                                     (DN_X_phi'*D0(:,igauss))*Integration_weight;
end 
     
%--------------------------------------------------------------------------
% Stiffness matrices 
%--------------------------------------------------------------------------
switch str.mesh.dim
    case 2
         for igauss=1:size(str.quadrature.volume.bilinear.Chi,1)
             %-------------------------------------------------------------
             % Integration weight
             %-------------------------------------------------------------
             Integration_weight   =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
             %-------------------------------------------------------------
             % Vectorisation of stiffness matrices
             %-------------------------------------------------------------
             vectorised_matrices  =  VectorisedStiffnessMatricesElectroTwoD(igauss,BF(:,igauss),DN_X_phi(:,:,igauss),...
                                                str.material_information.derivatives.D2Psi,...
                                                str.material_information.derivatives.DU,...
                                                QF(:,:,igauss),kinematics.H(:,:,igauss));
             %-------------------------------------------------------------
             % Stiffness matrices
             %-------------------------------------------------------------
             str.assembly.element_assembly.Kxx      =  str.assembly.element_assembly.Kxx      +  vectorised_matrices.Kxx*Integration_weight;
             str.assembly.element_assembly.Kxphi    =  str.assembly.element_assembly.Kxphi    +  vectorised_matrices.Kxphi*Integration_weight;
             str.assembly.element_assembly.Kphix    =  str.assembly.element_assembly.Kphix    +  vectorised_matrices.Kphix*Integration_weight;
             str.assembly.element_assembly.Kphiphi  =  str.assembly.element_assembly.Kphiphi  +  vectorised_matrices.Kphiphi*Integration_weight;
         end 
    case 3
         for igauss=1:size(str.quadrature.volume.bilinear.Chi,1)
             %-------------------------------------------------------------
             % Integration weight
             %-------------------------------------------------------------
             Integration_weight   =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
             %-------------------------------------------------------------
             % Vectorisation of stiffness matrices
             %-------------------------------------------------------------
             vectorised_matrices  =  VectorisedStiffnessMatricesElectroThreeD(igauss,BF(:,igauss),DN_X_phi(:,:,igauss),...
                                            str.material_information.derivatives.D2Psi,...
                                            str.material_information.derivatives.DU,...
                                            QF(:,:,igauss),QSigmaH(:,:,igauss),...
                                            kinematics.H(:,:,igauss));
             %-------------------------------------------------------------
             % Stiffness matrices
             %-------------------------------------------------------------
             str.assembly.element_assembly.Kxx      =  str.assembly.element_assembly.Kxx      +  vectorised_matrices.Kxx*Integration_weight;
             str.assembly.element_assembly.Kxphi    =  str.assembly.element_assembly.Kxphi    +  vectorised_matrices.Kxphi*Integration_weight;
             str.assembly.element_assembly.Kphix    =  str.assembly.element_assembly.Kphix    +  vectorised_matrices.Kphix*Integration_weight;
             str.assembly.element_assembly.Kphiphi  =  str.assembly.element_assembly.Kphiphi  +  vectorised_matrices.Kphiphi*Integration_weight;
         end
end




