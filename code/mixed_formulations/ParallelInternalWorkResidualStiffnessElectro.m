function element_assembly  =  ParallelInternalWorkResidualStiffnessElectro(ielem,quadrature,solution,geometry,mesh,fem,...
                                                                                           vectorisation,material_information)

ngauss                     =  size(quadrature.volume.bilinear.Chi,1);
%--------------------------------------------------------------------------
% Initialise assembled residuals per element 
%--------------------------------------------------------------------------
element_assembly           =  ElementResidualMatricesInitialisationElectro(geometry,mesh);
%--------------------------------------------------------------------------
% Value of the electric displacement field
%--------------------------------------------------------------------------
D0                         =  solution.D0(:,:,ielem);
%--------------------------------------------------------------------------
% Obtain gradients of kinematics and electrical variables
%--------------------------------------------------------------------------
[kinematics,DN_X_x]        =  KinematicsFunctionVolume(geometry.dim,...
                                          solution.x.Eulerian_x(:,mesh.volume.x.connectivity(:,ielem)),...
                                          solution.x.Lagrangian_X(:,mesh.volume.x.connectivity(:,ielem)),...
                                          fem.volume.bilinear.x.DN_chi);
[E0,DN_X_phi]              =  ElectricFieldComputation(geometry.dim,...
                                          solution.phi(mesh.volume.phi.connectivity(:,ielem)),...
                                          fem.volume.bilinear.phi.DN_chi,...
                                          kinematics.DX_chi);
%--------------------------------------------------------------------------
% Obtain D0 give E0 (and F,H, J)
%--------------------------------------------------------------------------
D0                         =  NewtonRaphsonLegendreTransformElectro(ielem,geometry.dim,ngauss,kinematics,D0,E0,vectorisation,...
                                                                     material_information);                                                                                                              
%--------------------------------------------------------------------------
% d variable. 
%--------------------------------------------------------------------------
d                          =  MatrixVectorMultiplication(geometry.dim,ngauss,kinematics.F,D0);
%--------------------------------------------------------------------------
% First and second derivatives of the model. 
%--------------------------------------------------------------------------
material_information       =  GetDerivativesModelElectro(ielem,geometry.dim,ngauss,kinematics.F,kinematics.H,kinematics.J,D0,d,...
                                                         material_information,vectorisation);
%--------------------------------------------------------------------------
% First Piola-Kirchhoff stress tensor.        
%--------------------------------------------------------------------------
Piola                      =  FirstPiolaKirchhoffStressTensorElectro(ngauss,geometry.dim,kinematics.F,kinematics.H,...
                                                               material_information.derivatives.DU.DUDF,...
                                                               material_information.derivatives.DU.DUDH,...
                                                               material_information.derivatives.DU.DUDJ,...
                                                               material_information.derivatives.DU.DUDd,...
                                                               D0);
Piola_vectorised           =  Matrix2Vector(geometry.dim^2,ngauss,Piola);
%--------------------------------------------------------------------------
% Matrix BF    
%--------------------------------------------------------------------------
BF                         =  BMatrix(ngauss,geometry.dim,mesh.volume.x.n_node_elem,DN_X_x,...
                                      vectorisation.Bx_matrix.LHS_indices,...
                                      vectorisation.Bx_matrix.RHS_indices);
%--------------------------------------------------------------------------
% Q matrices arising from the linearisation of H: DH[].SigmaH = Q*DF[]. and
%--------------------------------------------------------------------------
QF                         =  QMatrixComputation(kinematics.F,geometry.dim,ngauss);
QSigmaH                    =  QMatrixComputation(material_information.derivatives.DU.DUDH,geometry.dim,ngauss);    
%--------------------------------------------------------------------------
% Residuals and Stiffness matrices 
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Integration_weight     =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Residual conservation of linear momentum.
    %----------------------------------------------------------------------
    element_assembly.Tx    =  element_assembly.Tx   +  ...
                              (BF(:,:,igauss)'*Piola_vectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual Gauss' law.- (D0'*DN_X*W*J_t)'
    %----------------------------------------------------------------------
    element_assembly.Tphi  =  element_assembly.Tphi   -  ...
                              (DN_X_phi(:,:,igauss)'*D0(:,igauss))*Integration_weight;
end      
%--------------------------------------------------------------------------
% Residuals and Stiffness matrices 
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Integration_weight        =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices
    %----------------------------------------------------------------------
    vectorised_matrices       =  VectorisedStiffnessMatricesElectro(igauss,BF(:,:,igauss),DN_X_phi(:,:,igauss),...
                                                    material_information.derivatives.D2Psi,...
                                                    material_information.derivatives.DU,...
                                                    QF(:,:,igauss),QSigmaH(:,:,igauss),...
                                                    kinematics.H(:,:,igauss));
    %----------------------------------------------------------------------
    % Stiffness matrices
    %----------------------------------------------------------------------
    element_assembly.Kxx      =  element_assembly.Kxx      +  vectorised_matrices.Kxx*Integration_weight;
    element_assembly.Kxphi    =  element_assembly.Kxphi    +  vectorised_matrices.Kxphi*Integration_weight;
    element_assembly.Kphix    =  element_assembly.Kphix    +  vectorised_matrices.Kphix*Integration_weight;
    element_assembly.Kphiphi  =  element_assembly.Kphiphi  +  vectorised_matrices.Kphiphi*Integration_weight;
end 




