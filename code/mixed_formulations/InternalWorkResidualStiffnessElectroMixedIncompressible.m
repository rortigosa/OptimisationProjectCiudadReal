%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the elemental residual vectors and stiffness
% matrices for the formulation with fields: x-phi-p
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str                  =  InternalWorkResidualStiffnessElectroMixedIncompressible(ielem,str)

%--------------------------------------------------------------------------
% Obtain gradients of kinematics and electrical variables
%--------------------------------------------------------------------------
[kinematics,DN_X_x]           =  KinematicsFunctionVolume(str.mesh.dim,...
                                                          str.solution.x.Eulerian_x(:,str.mesh.volume.x.connectivity(:,ielem)),...
                                                          str.solution.x.Lagrangian_X(:,str.mesh.volume.x.connectivity(:,ielem)),...
                                                          str.fem.volume.bilinear.x.DN_chi);
[E0,DN_X_phi]                 =  ElectricFieldComputation(str.mesh.dim,...
                                                          str.solution.phi(str.mesh.volume.phi.connectivity(:,ielem)),...
                                                          str.fem.volume.bilinear.phi.DN_chi,...
                                                          kinematics.DX_chi);
Fx_vectorised                 =  reshape(permute(kinematics.F,[2 1 3]),str.mesh.dim^2,[]);
Hx_vectorised                 =  reshape(permute(kinematics.H,[2 1 3]),str.mesh.dim^2,[]);
%--------------------------------------------------------------------------
% Obtain the fields (F,H,J,D0,d) and (SigmaF,SigmaH,SigmaJ,Sigmad) at each
% Gauss points
%--------------------------------------------------------------------------
[F,Fvectorised,H,Hvectorised,J,D0,d,...
    SigmaF,SigmaFvectorised,SigmaH,...
    SigmaHvectorised,SigmaJ,...
    Sigmad,pressure]          =  ElectroMixedIncompressibleFEMFieldsInterpolation(str.mesh.dim,str.fem,str.solution,...
                                                   str.mesh.volume.F,str.mesh.volume.H,str.mesh.volume.J,str.mesh.volume.D0,...
                                                   str.mesh.volume.d,str.mesh.volume.pressure);
D0_matrix                     =  Vector2MatrixVectorisation(D0,n_gauss,str.vectorisation.vector2matrix_rowwise_Gauss_points);
Sigmad_matrix                 =  Vector2MatrixVectorisation(d,n_gauss,str.vectorisation.vector2matrix_colwise_Gauss_points);
%--------------------------------------------------------------------------
% Variable d
%--------------------------------------------------------------------------
d                             =  MatrixVectorMultiplication(F,D0);
%--------------------------------------------------------------------------
% First and second derivatives of the model. 
%--------------------------------------------------------------------------
str.material_information      =  GetDerivativesModelElectroMixed(ielem,F,H,J,D0,d,str.material_information);
DUDF_vectorised               =  reshape(permute(str.material_information.derivatives.DU.DUDF,[2 1 3]),str.mesh.dim^2,[]);
DUDH_vectorised               =  reshape(permute(str.material_information.derivatives.DU.DUDH,[2 1 3]),str.mesh.dim^2,[]);
DUDJ                          =  str.material_information.derivatives.DU.DUDJ;
DUDD0                         =  str.material_information.derivatives.DU.DUDD0;
DUDd                          =  str.material_information.derivatives.DU.DUDd;
%--------------------------------------------------------------------------
% First Piola-Kirchhoff stress tensor.       
%--------------------------------------------------------------------------
Piola                         =  FirstPiolaKirchhoffStressTensorElectroMixed(str.mesh.dim,kinematics,...
                                                                SigmaF,SigmaH,SigmaJ,Sigmad,D0,pressure);
Piola_vectorised              =  reshape(permute(Piola,[2 1 3]),str.mesh.dim^2,[]);
%--------------------------------------------------------------------------
% Matrix BF   
%--------------------------------------------------------------------------
BF                            =  BMatrix(str.mesh.dim,str.mesh.volume.x.n_node_elem,DN_X_x,...
                                         str.vectorisation.Bx_matrix.LHS_indices,...
                                         str.vectorisation.Bx_matrix.RHS_indices);
%--------------------------------------------------------------------------
% Q matrices arising from the linearisation of H: DH[].SigmaH = Q*DF[]. and
%--------------------------------------------------------------------------
QF                            =  QMatrixComputation(kinematics.F);
QSigmaH                       =  QMatrixComputation(str.material_information.derivatives.DU.DUDH);    
%--------------------------------------------------------------------------
% Residuals and Stiffness matrices 
%--------------------------------------------------------------------------
for igauss=1:size(str.quadrature.volume.bilinear.Chi,1)
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Integration_weight        =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Residual conservation of linear momentum.
    %----------------------------------------------------------------------
    str.assembly.element_assembly.Tx       =  str.assembly.element_assembly.Tx   +  ...
                                (BF'*Piola_vectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual Gauss' law.- (D0'*DN_X*W*J_t)'
    %----------------------------------------------------------------------
    str.assembly.element_assembly.Tphi     =  str.assembly.element_assembly.Tphi   -  ...
                                (DN_X_phi'*D0(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual pressure (incompressibility).
    %----------------------------------------------------------------------
    str.assembly.element_assembly.Tp       =  str.assembly.element_assembly.Tp  +  ...
                                 str.fem.volume.bilinear.pressure.N(:,igauss)*(kinematics.J(igauss) - 1)*Integration_weight;                                          
    %----------------------------------------------------------------------
    % Residual for F.
    %----------------------------------------------------------------------
    str.assembly.element_assembly.TF       =  str.assembly.element_assembly.TF   +  ...
                                 str.fem.volume.bilinear.F.N_vectorised(:,:,igauss)'*(DUDF_vectorised(:,igauss) - SigmaFvectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for H.
    %----------------------------------------------------------------------
    str.assembly.element_assembly.TH       =  str.assembly.element_assembly.TH   +  ...
                                 str.fem.volume.bilinear.H.N_vectorised(:,:,igauss)'*(DUDH_vectorised(:,igauss) - SigmaHvectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for J.
    %----------------------------------------------------------------------
    str.assembly.element_assembly.TJ       =  str.assembly.element_assembly.TJ  +  ...
                                 str.fem.volume.bilinear.J.N(:,igauss)*(DUDJ(igauss) - SigmaJ(igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for D0.
    %----------------------------------------------------------------------
    str.assembly.element_assembly.TD0      =  str.assembly.element_assembly.TD0   +  ...
                                 str.fem.volume.bilinear.D0.N_vectorised(:,:,igauss)'*(DUDD0(:,igauss) + kinematics.F(:,:,igauss)'*Sigmad(:,igauss) - E0(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for d.
    %----------------------------------------------------------------------
    element_assembly.Td       =  element_assembly.Td   +  ...
                                 str.fem.volume.bilinear.d.N_vectorised(:,:,igauss)'*(DUDd(:,igauss)  - Sigmad(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for SigmaF.
    %----------------------------------------------------------------------
    element_assembly.TSigmaF  =  element_assembly.TSigmaF   +  ...
                                 str.fem.volume.bilinear.F.N_vectorised(:,:,igauss)'*(Fx_vectorised(:,igauss) - Fvectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for SigmaH.
    %----------------------------------------------------------------------
    element_assembly.TSigmaH  =  element_assembly.TSigmaH   +  ...
                                 str.fem.volume.bilinear.H.N_vectorised(:,:,igauss)'*(Hx_vectorised(:,igauss) - Hvectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for SigmaJ.
    %----------------------------------------------------------------------
    element_assembly.TSigmaJ  =  element_assembly.TSigmaJ  +  ...
                                 str.fem.volume.bilinear.J.N(:,igauss)*(kinematics.J(igauss) - J(igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for Sigmad.
    %----------------------------------------------------------------------
    element_assembly.TSigmad  =  element_assembly.TSigmad   +  ...
                                 str.fem.volume.bilinear.d.N_vectorised(:,:,igauss)'*(kinematics.F(:,:,igauss)*D0(:,igauss) - d(:,igauss))*Integration_weight;                                          
end 
     
%--------------------------------------------------------------------------
% Residuals
%--------------------------------------------------------------------------
switch str.mesh.dim
    case 2
         for igauss=1:size(str.quadrature.volume.bilinear.Chi,1)
             %-------------------------------------------------------------
             % Integration weight
             %-------------------------------------------------------------
             Integration_weight    =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
             %-------------------------------------------------------------
             % Vectorisation of stiffness matrices
             %-------------------------------------------------------------
             vectorised_matrices   =  VectorisedStiffnessMatricesElectroMixedIncompTwoD(igauss,BF(:,igauss),DN_X_phi(:,:,igauss),...
                                                     str.material_information.derivatives.D2Psi,...
                                                     str.material_information.derivatives.DU,...
                                                     pressure,QF(:,:,igauss),kinematics.H(:,:,igauss),...
                                                     str.fem.volume.bilinear.pressure.N(:,igauss));
             %-------------------------------------------------------------
             % Stiffness matrices
             %-------------------------------------------------------------
             str.assembly.element_assembly.Kxx        =  str.assembly.element_assembly.Kxx      +  vectorised_matrices.Kxx*Integration_weight;
             str.assembly.element_assembly.Kxphi      =  str.assembly.element_assembly.Kxphi    +  vectorised_matrices.Kxphi*Integration_weight;
             str.assembly.element_assembly.Kxp        =  str.assembly.element_assembly.Kxp      +  vectorised_matrices.Kxp*Integration_weight;
             str.assembly.element_assembly.KxSigmaF   =  str.assembly.element_assembly.KxSigmaF +  vectorised_matrices.KxSigmaF*Integration_weight;
             str.assembly.element_assembly.KxSigmaJ   =  str.assembly.element_assembly.KxSigmaJ +  vectorised_matrices.KxSigmaJ*Integration_weight;
             str.assembly.element_assembly.KxD0       =  str.assembly.element_assembly.KxD0     +  vectorised_matrices.KxD0*Integration_weight;
             
             str.assembly.element_assembly.KphiD0     =  str.assembly.element_assembly.KphiD0   +  vectorised_matrices.KphiD0*Integration_weight;
             
             str.assembly.element_assembly.Kpp        =  str.assembly.element_assembly.Kpp      +  vectorised_matrices.Kpp*Integration_weight;
             
             str.assembly.element_assembly.KFF        =  str.assembly.element_assembly.KFF      +  vectorised_matrices.KFF*Integration_weight;
             str.assembly.element_assembly.KFJ        =  str.assembly.element_assembly.KFJ      +  vectorised_matrices.KFJ*Integration_weight;
             str.assembly.element_assembly.KFD0       =  str.assembly.element_assembly.KFD0     +  vectorised_matrices.KFD0*Integration_weight;
             str.assembly.element_assembly.KFd        =  str.assembly.element_assembly.KFd      +  vectorised_matrices.KFd*Integration_weight;
             str.assembly.element_assembly.KFSigmaF   =  str.assembly.element_assembly.KFSigmaF +  vectorised_matrices.KFSigmaF*Integration_weight;
             
             str.assembly.element_assembly.KJJ        =  str.assembly.element_assembly.KJJ      +  vectorised_matrices.KJJ*Integration_weight;
             str.assembly.element_assembly.KJD0       =  str.assembly.element_assembly.KJD0     +  vectorised_matrices.KJD0*Integration_weight;
             str.assembly.element_assembly.KJd        =  str.assembly.element_assembly.KJd      +  vectorised_matrices.KJd*Integration_weight;
             str.assembly.element_assembly.KJSigmaJ   =  str.assembly.element_assembly.KJSigmaJ +  vectorised_matrices.KJSigmaJ*Integration_weight;
             
             str.assembly.element_assembly.KD0D0      =  str.assembly.element_assembly.KD0D0     +  vectorised_matrices.KD0D0*Integration_weight;
             str.assembly.element_assembly.KD0d       =  str.assembly.element_assembly.KD0d      +  vectorised_matrices.KD0d*Integration_weight;
             str.assembly.element_assembly.KD0Sigmad  =  str.assembly.element_assembly.KD0Sigmad +  vectorised_matrices.KD0Sigmad*Integration_weight;
             
             str.assembly.element_assembly.Kdd        =  str.assembly.element_assembly.Kdd      +  vectorised_matrices.Kdd*Integration_weight;
             str.assembly.element_assembly.KdSigmad   =  str.assembly.element_assembly.KdSigmad +  vectorised_matrices.KdSigmad*Integration_weight;
         end
         %-----------------------------------------------------------------
         % Static condensation procedure in order to get the equivalent
         % stiffness matrices and residual vectors
         %-----------------------------------------------------------------
         str.assembly.element_assembly   =  ResidualStiffnessStaticCondensElectroMixedIncompTwoD(str.assembly.element_assembly);           
    case 3
         for igauss=1:size(str.quadrature.volume.bilinear.Chi,1)
             %-------------------------------------------------------------
             % Integration weight
             %-------------------------------------------------------------
             Integration_weight    =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
             %-------------------------------------------------------------
             % Vectorisation of stiffness matrices
             %-------------------------------------------------------------
             vectorised_matrices   =  VectorisedStiffnessMatricesElectroMixedIncompThreeD(igauss,BF(:,igauss),DN_X_phi(:,:,igauss),...
                                                     str.material_information.derivatives.D2Psi,...
                                                     str.material_information.derivatives.DU,...
                                                     pressure,QF(:,:,igauss),QSigmaH(:,:,igauss),...
                                                     kinematics.H(:,:,igauss),...
                                                     str.fem.volume.bilinear.pressure.N(:,igauss));
             %-------------------------------------------------------------
             % Stiffness matrices
             %-------------------------------------------------------------
             str.assembly.element_assembly.Kxx        =  str.assembly.element_assembly.Kxx      +  vectorised_matrices.Kxx*Integration_weight;
             str.assembly.element_assembly.Kxphi      =  str.assembly.element_assembly.Kxphi    +  vectorised_matrices.Kxphi*Integration_weight;
             str.assembly.element_assembly.Kxp        =  str.assembly.element_assembly.Kxp      +  vectorised_matrices.Kxp*Integration_weight;
             str.assembly.element_assembly.KxSigmaF   =  str.assembly.element_assembly.KxSigmaF +  vectorised_matrices.KxSigmaF*Integration_weight;
             str.assembly.element_assembly.KxSigmaH   =  str.assembly.element_assembly.KxSigmaH +  vectorised_matrices.KxSigmaH*Integration_weight;
             str.assembly.element_assembly.KxSigmaJ   =  str.assembly.element_assembly.KxSigmaJ +  vectorised_matrices.KxSigmaJ*Integration_weight;
             str.assembly.element_assembly.KxD0       =  str.assembly.element_assembly.KxD0     +  vectorised_matrices.KxD0*Integration_weight;
             
             str.assembly.element_assembly.KphiD0     =  str.assembly.element_assembly.KphiD0   +  vectorised_matrices.KphiD0*Integration_weight;
             
             str.assembly.element_assembly.Kpp        =  str.assembly.element_assembly.Kpp      +  vectorised_matrices.Kpp*Integration_weight;
             
             str.assembly.element_assembly.KFF        =  str.assembly.element_assembly.KFF      +  vectorised_matrices.KFF*Integration_weight;
             str.assembly.element_assembly.KFH        =  str.assembly.element_assembly.KFH      +  vectorised_matrices.KFH*Integration_weight;
             str.assembly.element_assembly.KFJ        =  str.assembly.element_assembly.KFJ      +  vectorised_matrices.KFJ*Integration_weight;
             str.assembly.element_assembly.KFD0       =  str.assembly.element_assembly.KFD0     +  vectorised_matrices.KFD0*Integration_weight;
             str.assembly.element_assembly.KFd        =  str.assembly.element_assembly.KFd      +  vectorised_matrices.KFd*Integration_weight;
             str.assembly.element_assembly.KFSigmaF   =  str.assembly.element_assembly.KFSigmaF +  vectorised_matrices.KFSigmaF*Integration_weight;
             
             str.assembly.element_assembly.KHH        =  str.assembly.element_assembly.KHH      +  vectorised_matrices.KHH*Integration_weight;
             str.assembly.element_assembly.KHJ        =  str.assembly.element_assembly.KHJ      +  vectorised_matrices.KHJ*Integration_weight;
             str.assembly.element_assembly.KHD0       =  str.assembly.element_assembly.KHD0     +  vectorised_matrices.KHD0*Integration_weight;
             str.assembly.element_assembly.KHd        =  str.assembly.element_assembly.KHd      +  vectorised_matrices.KHd*Integration_weight;
             str.assembly.element_assembly.KHSigmaH   =  str.assembly.element_assembly.KHSigmaF +  vectorised_matrices.KHSigmaH*Integration_weight;
             
             str.assembly.element_assembly.KJJ        =  str.assembly.element_assembly.KJJ      +  vectorised_matrices.KJJ*Integration_weight;
             str.assembly.element_assembly.KJD0       =  str.assembly.element_assembly.KJD0     +  vectorised_matrices.KJD0*Integration_weight;
             str.assembly.element_assembly.KJd        =  str.assembly.element_assembly.KJd      +  vectorised_matrices.KJd*Integration_weight;
             str.assembly.element_assembly.KJSigmaJ   =  str.assembly.element_assembly.KJSigmaJ +  vectorised_matrices.KJSigmaJ*Integration_weight;
             
             str.assembly.element_assembly.KD0D0      =  str.assembly.element_assembly.KD0D0     +  vectorised_matrices.KD0D0*Integration_weight;
             str.assembly.element_assembly.KD0d       =  str.assembly.element_assembly.KD0d      +  vectorised_matrices.KD0d*Integration_weight;
             str.assembly.element_assembly.KD0Sigmad  =  str.assembly.element_assembly.KD0Sigmad +  vectorised_matrices.KD0Sigmad*Integration_weight;
             
             str.assembly.element_assembly.Kdd        =  str.assembly.element_assembly.Kdd      +  vectorised_matrices.Kdd*Integration_weight;
             str.assembly.element_assembly.KdSigmad   =  str.assembly.element_assembly.KdSigmad +  vectorised_matrices.KdSigmad*Integration_weight;
         end        
         %-----------------------------------------------------------------
         % Static condensation procedure in order to get the equivalent
         % stiffness matrices and residual vectors
         %-----------------------------------------------------------------
         str.assembly.element_assembly   =  ResidualStiffnessStaticCondensElectroMixedIncompThreeD(str.assembly.element_assembly);           
end





