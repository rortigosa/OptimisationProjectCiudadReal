%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the elemental residual vectors and stiffness
% matrices for the formulation with fields: x-phi-p
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str                   =  InternalWorkResidualStiffnessElectroIncompressible(ielem,str)

%--------------------------------------------------------------------------
% Initialise assembled residuals per element 
%--------------------------------------------------------------------------
str.assembly.element_assembly  =  ElementResidualMatricesInitialisationElectroIncompressible(str.geometry,str.mesh);
%--------------------------------------------------------------------------
% Number of Gauss points
%--------------------------------------------------------------------------
ngauss                     =  size(str.quadrature.volume.bilinear.Chi,1);
%--------------------------------------------------------------------------
% Value of the electric displacement field
%--------------------------------------------------------------------------
D0                         =  str.solution.D0(:,:,ielem);
%--------------------------------------------------------------------------
% Obtain gradients of kinematics and electrical variables
%--------------------------------------------------------------------------
[kinematics,DN_X_x]        =  KinematicsFunctionVolume(str.geometry.dim,...
                                          str.solution.x.Eulerian_x(:,str.mesh.volume.x.connectivity(:,ielem)),...
                                          str.solution.x.Lagrangian_X(:,str.mesh.volume.x.connectivity(:,ielem)),...
                                          str.fem.volume.bilinear.x.DN_chi);
[E0,DN_X_phi]              =  ElectricFieldComputation(str.geometry.dim,...
                                          str.solution.phi(str.mesh.volume.phi.connectivity(:,ielem)),...
                                          str.fem.volume.bilinear.phi.DN_chi,...
                                          kinematics.DX_chi);
%--------------------------------------------------------------------------
% Obtain pressure at every gauss point 
%--------------------------------------------------------------------------
pressure                   =  ScalarFEMInterpolation(str.fem.volume.bilinear.pressure.N,...
                                               str.solution.pressure(str.mesh.volume.pressure.connectivity(:,ielem)));                                         
%--------------------------------------------------------------------------
% Obtain D0 give E0 (and F,H, J)
%--------------------------------------------------------------------------
D0                         =  NewtonRaphsonLegendreTransformElectro(ielem,str.geometry.dim,ngauss,kinematics,D0,E0,str.vectorisation,...
                                                                     str.material_information);                                                                                                              
%--------------------------------------------------------------------------
% d variable. 
%--------------------------------------------------------------------------
d                          =  MatrixVectorMultiplication(str.geometry.dim,ngauss,kinematics.F,D0);
%--------------------------------------------------------------------------
% First and second derivatives of the model. 
%--------------------------------------------------------------------------
str.material_information   =  GetDerivativesModelElectro(ielem,str.geometry.dim,ngauss,kinematics.F,kinematics.H,kinematics.J,D0,d,...
                                                         str.material_information,str.vectorisation);
%--------------------------------------------------------------------------
% First Piola-Kirchhoff stress tensor.        
%--------------------------------------------------------------------------
Piola                      =  FirstPiolaKirchhoffStressTensorElectro(ngauss,str.geometry.dim,kinematics,pressure,...
                                                               str.material_information.derivatives.DU,D0);
Piola_vectorised           =  Matrix2Vector(str.geometry.dim^2,ngauss,Piola);
%--------------------------------------------------------------------------
% Matrix BF    
%--------------------------------------------------------------------------
BF                         =  BMatrix(ngauss,str.geometry.dim,str.mesh.volume.x.n_node_elem,DN_X_x,...
                                      str.vectorisation.Bx_matrix.LHS_indices,...
                                      str.vectorisation.Bx_matrix.RHS_indices);
%--------------------------------------------------------------------------
% Q matrices arising from the linearisation of H: DH[].SigmaH = Q*DF[]. and
%--------------------------------------------------------------------------
QF                         =  QMatrixComputation(kinematics.F,str.geometry.dim,ngauss);
QSigmaH                    =  QMatrixComputation(str.material_information.derivatives.DU.DUDH,str.geometry.dim,ngauss);    
%--------------------------------------------------------------------------
% Residuals and Stiffness matrices 
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Integration_weight     =  (kinematics.DX_chi_Jacobian(igauss))*str.quadrature.volume.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Residual conservation of linear momentum.
    %----------------------------------------------------------------------
    str.assembly.element_assembly.Tx    =  str.assembly.element_assembly.Tx   +  ...
                                          (BF(:,:,igauss)'*Piola_vectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual Gauss' law.- (D0'*DN_X*W*J_t)'
    %----------------------------------------------------------------------
    str.assembly.element_assembly.Tphi  =  str.assembly.element_assembly.Tphi   -  ...
                                           (DN_X_phi(:,:,igauss)'*D0(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual pressure (incompressibility). 
    %----------------------------------------------------------------------
    str.assembly.element_assembly.Tp    =  str.assembly.element_assembly.Tp  +  ...
                                           str.fem.volume.bilinear.pressure.N(:,igauss)*(kinematics.J(igauss) - 1)*Integration_weight;
end 
     
%--------------------------------------------------------------------------
% Residuals and Stiffness matrices 
%--------------------------------------------------------------------------
switch str.geometry.dim
    case 2
         for igauss=1:ngauss
             %-------------------------------------------------------------
             % Integration weight
             %-------------------------------------------------------------
             Integration_weight     =  (kinematics.DX_chi_Jacobian(igauss))*str.quadrature.volume.bilinear.W_v(igauss);
             %-------------------------------------------------------------
             % Vectorisation of stiffness matrices
             %-------------------------------------------------------------
             vectorised_matrices    =  VectorisedStiffnessMatricesElectroIncompressibleTwoD(igauss,BF(:,igauss),DN_X_phi(:,:,igauss),...
                                                              str.material_information.derivatives.D2Psi,...
                                                              str.material_information.derivatives.DU,...
                                                              pressure,QF(:,:,igauss),QSigmaH(:,:,igauss),...
                                                              kinematics.H(:,:,igauss),...
                                                              str.fem.volume.bilinear.pressure.N(:,igauss));
             %-------------------------------------------------------------
             % Stiffness matrices
             %-------------------------------------------------------------
             str.assembly.element_assembly.Kxx      =  str.assembly.element_assembly.Kxx      +  vectorised_matrices.Kxx*Integration_weight;
             str.assembly.element_assembly.Kxphi    =  str.assembly.element_assembly.Kxphi    +  vectorised_matrices.Kxphi*Integration_weight;
             str.assembly.element_assembly.Kxp      =  str.assembly.element_assembly.Kxp      +  vectorised_matrices.Kxp*Integration_weight;
             str.assembly.element_assembly.Kphix    =  str.assembly.element_assembly.Kphix    +  vectorised_matrices.Kphix*Integration_weight;
             str.assembly.element_assembly.Kphiphi  =  str.assembly.element_assembly.Kphiphi  +  vectorised_matrices.Kphiphi*Integration_weight;
             str.assembly.element_assembly.Kpx      =  str.assembly.element_assembly.Kpx      +  vectorised_matrices.Kpx*Integration_weight;
             str.assembly.element_assembly.Kpp      =  str.assembly.element_assembly.Kpp      +  vectorised_matrices.Kpp*Integration_weight;
         end
    case 3
         for igauss=1:ngauss
             %-------------------------------------------------------------
             % Integration weight
             %-------------------------------------------------------------
             Integration_weight     =  (kinematics.DX_chi_Jacobian(igauss))*str.quadrature.volume.bilinear.W_v(igauss);
             %-------------------------------------------------------------
             % Vectorisation of stiffness matrices
             %-------------------------------------------------------------
             vectorised_matrices    =  VectorisedStiffnessMatricesElectroIncompressibleThreeD(igauss,BF(:,:,igauss),DN_X_phi(:,:,igauss),...
                                                              str.material_information.derivatives.D2Psi,...
                                                              str.material_information.derivatives.DU,...
                                                              pressure,QF(:,:,igauss),QSigmaH(:,:,igauss),...
                                                              kinematics.H(:,:,igauss),...
                                                              str.fem.volume.bilinear.pressure.N(:,igauss));
             %-------------------------------------------------------------
             % Stiffness matrices 
             %-------------------------------------------------------------
             str.assembly.element_assembly.Kxx      =  str.assembly.element_assembly.Kxx      +  vectorised_matrices.Kxx*Integration_weight;
             str.assembly.element_assembly.Kxphi    =  str.assembly.element_assembly.Kxphi    +  vectorised_matrices.Kxphi*Integration_weight;
             str.assembly.element_assembly.Kxp      =  str.assembly.element_assembly.Kxp      +  vectorised_matrices.Kxp*Integration_weight;
             str.assembly.element_assembly.Kphix    =  str.assembly.element_assembly.Kphix    +  vectorised_matrices.Kphix*Integration_weight;
             str.assembly.element_assembly.Kphiphi  =  str.assembly.element_assembly.Kphiphi  +  vectorised_matrices.Kphiphi*Integration_weight;
             str.assembly.element_assembly.Kpx      =  str.assembly.element_assembly.Kpx      +  vectorised_matrices.Kpx*Integration_weight;
             str.assembly.element_assembly.Kpp      =  str.assembly.element_assembly.Kpp      +  vectorised_matrices.Kpp*Integration_weight;
         end        
end



