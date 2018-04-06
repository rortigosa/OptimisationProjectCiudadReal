%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the elemental residual vectors and stiffness
% matrices for the formulation with fields: x-phi-p
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function assmb       =  ParallelInternalWorkResidualStiffnessElectroMixedIncompressible(ielem,quadrature,solution,geometry,mesh,fem,...
                                                                                           vectorisation,material_information)
%--------------------------------------------------------------------------
% Number of Gauss points
%--------------------------------------------------------------------------
ngauss               =  size(quadrature.volume.bilinear.Chi,1);
%--------------------------------------------------------------------------
% Initialise assembled residuals per element 
%--------------------------------------------------------------------------
assmb                =  ElementResidualMatricesInitialisationElectroMixedIncompressible(geometry,mesh);
%--------------------------------------------------------------------------
% Obtain gradients of kinematics and electrical variables
%--------------------------------------------------------------------------
[kinematics,DN_X_x]  =  KinematicsFunctionVolume(geometry.dim,...
                                                 solution.x.Eulerian_x(:,mesh.volume.x.connectivity(:,ielem)),...
                                                 solution.x.Lagrangian_X(:,mesh.volume.x.connectivity(:,ielem)),...
                                                 fem.volume.bilinear.x.DN_chi);
[E0,DN_X_phi]        =  ElectricFieldComputation(geometry.dim,...
                                                 solution.phi(mesh.volume.phi.connectivity(:,ielem)),...
                                                 fem.volume.bilinear.phi.DN_chi,...
                                                 kinematics.DX_chi);
Fx_vectorised        =  Matrix2Vector(geometry.dim^2,ngauss,kinematics.F);
Hx_vectorised        =  Matrix2Vector(geometry.dim^2,ngauss,kinematics.H);
%--------------------------------------------------------------------------
% Obtain the fields (F,H,J,D0,d) and (SigmaF,SigmaH,SigmaJ,Sigmad) at each
% Gauss points
%--------------------------------------------------------------------------
[F,Fvectorised,H,Hvectorised,J,D0,d,...
 SigmaF,SigmaFvectorised,SigmaH,...
 SigmaHvectorised,SigmaJ,...
 Sigmad,pressure]    =  ElectroMixedIncompressibleFEMFieldsInterpolation(ielem,geometry.dim,ngauss,fem,solution,...
                                                   mesh.volume.F,mesh.volume.H,mesh.volume.J,mesh.volume.D0,...
                                                   mesh.volume.d,mesh.volume.pressure);
D0_matrix            =  Vector2MatrixVectorisation(D0,ngauss,vectorisation.vector2matrix_rowwise_Gauss_points);
Sigmad_matrix        =  Vector2MatrixVectorisation(d,ngauss,vectorisation.vector2matrix_colwise_Gauss_points);
%--------------------------------------------------------------------------
% Field d
%--------------------------------------------------------------------------
FxD0                 =  MatrixVectorMultiplication(geometry.dim,ngauss,kinematics.F,D0);
FxSigmad             =  MatrixVectorMultiplication(geometry.dim,ngauss,kinematics.F,Sigmad);
%--------------------------------------------------------------------------
% First and second derivatives of the model. 
%--------------------------------------------------------------------------
material_information =  GetDerivativesModelElectroMixed(ielem,geometry.dim,ngauss,F,H,J,D0,d,material_information);
DUDF_vectorised      =  reshape(permute(material_information.derivatives.DU.DUDF,[2 1 3]),geometry.dim^2,[]);
DUDH_vectorised      =  reshape(permute(material_information.derivatives.DU.DUDH,[2 1 3]),geometry.dim^2,[]);
DUDJ                 =  material_information.derivatives.DU.DUDJ;
DUDD0                =  material_information.derivatives.DU.DUDD0;
DUDd                 =  material_information.derivatives.DU.DUDd;
%--------------------------------------------------------------------------
% First Piola-Kirchhoff stress tensor.       
%--------------------------------------------------------------------------
Piola                =  FirstPiolaKirchhoffStressTensorElectroIncompressible(ngauss,geometry.dim,kinematics.F,kinematics.H,...
                                                          SigmaF,SigmaH,SigmaJ,Sigmad,D0,pressure);
Piola_vectorised     =  Matrix2Vector(geometry.dim^2,ngauss,Piola);
%--------------------------------------------------------------------------
% Matrix BF   
%--------------------------------------------------------------------------
BF                   =  BMatrix(ngauss,geometry.dim,mesh.volume.x.n_node_elem,DN_X_x,...
                                vectorisation.Bx_matrix.LHS_indices,...
                                vectorisation.Bx_matrix.RHS_indices);
%--------------------------------------------------------------------------
% Q matrices arising from the linearisation of H: DH[].SigmaH = Q*DF[]. and
%--------------------------------------------------------------------------
QF                   =  QMatrixComputation(kinematics.F,geometry.dim,ngauss);
QSigmaH              =  QMatrixComputation(material_information.derivatives.DU.DUDH,geometry.dim,ngauss);    
%--------------------------------------------------------------------------
% Residuals 
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Int_weight       =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Residual conservation of linear momentum.
    %----------------------------------------------------------------------
    assmb.Tx         =  assmb.Tx   +  (BF(:,:,igauss)'*Piola_vectorised(:,igauss))*Int_weight;
    %----------------------------------------------------------------------
    % Residual Gauss' law.- (D0'*DN_X*W*J_t)'
    %----------------------------------------------------------------------
    assmb.Tphi       =  assmb.Tphi   -  (DN_X_phi(:,:,igauss)'*D0(:,igauss))*Int_weight;
    %----------------------------------------------------------------------
    % Residual pressure (incompressibility).
    %----------------------------------------------------------------------
    assmb.Tp         =  assmb.Tp  +  fem.volume.bilinear.pressure.N(:,igauss)*(kinematics.J(igauss) - 1)*Int_weight;                                          
    %----------------------------------------------------------------------
    % Residual for F.
    %----------------------------------------------------------------------
    assmb.TF         =  assmb.TF   +  fem.volume.bilinear.F.N_vectorised(:,:,igauss)'*(DUDF_vectorised(:,igauss) - SigmaFvectorised(:,igauss))*Int_weight;
    %----------------------------------------------------------------------
    % Residual for H.
    %----------------------------------------------------------------------
    assmb.TH         =  assmb.TH   +  fem.volume.bilinear.H.N_vectorised(:,:,igauss)'*(DUDH_vectorised(:,igauss) - SigmaHvectorised(:,igauss))*Int_weight;
    %----------------------------------------------------------------------
    % Residual for J.
    %----------------------------------------------------------------------
    assmb.TJ         =  assmb.TJ  + fem.volume.bilinear.J.N(:,igauss)*(DUDJ(igauss) - SigmaJ(igauss))*Int_weight;
    %----------------------------------------------------------------------
    % Residual for D0.
    %----------------------------------------------------------------------
    assmb.TD0        =  assmb.TD0 + fem.volume.bilinear.D0.N_vectorised(:,:,igauss)'*(DUDD0(:,igauss) + FxSigmad(:,igauss) + E0(:,igauss))*Int_weight;
    %----------------------------------------------------------------------
    % Residual for d.
    %----------------------------------------------------------------------
    assmb.Td         =  assmb.Td  + fem.volume.bilinear.d.N_vectorised(:,:,igauss)'*(DUDd(:,igauss)  - Sigmad(:,igauss))*Int_weight;
    %----------------------------------------------------------------------
    % Residual for SigmaF.
    %----------------------------------------------------------------------
    assmb.TSigmaF    =  assmb.TSigmaF + fem.volume.bilinear.F.N_vectorised(:,:,igauss)'*(Fx_vectorised(:,igauss) - Fvectorised(:,igauss))*Int_weight;
    %----------------------------------------------------------------------
    % Residual for SigmaH.
    %----------------------------------------------------------------------
    assmb.TSigmaH    =  assmb.TSigmaH + fem.volume.bilinear.H.N_vectorised(:,:,igauss)'*(Hx_vectorised(:,igauss) - Hvectorised(:,igauss))*Int_weight;
    %----------------------------------------------------------------------
    % Residual for SigmaJ.
    %----------------------------------------------------------------------
    assmb.TSigmaJ    =  assmb.TSigmaJ + fem.volume.bilinear.J.N(:,igauss)*(kinematics.J(igauss) - J(igauss))*Int_weight;
    %----------------------------------------------------------------------
    % Residual for Sigmad.
    %----------------------------------------------------------------------
    assmb.TSigmad    =  assmb.TSigmad + fem.volume.bilinear.d.N_vectorised(:,:,igauss)'*(FxD0(:,igauss) - d(:,igauss))*Int_weight;                                          
end 
%--------------------------------------------------------------------------
% Stiffness matrices
%--------------------------------------------------------------------------     
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Int_weight       =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices
    %----------------------------------------------------------------------
    vect_mat         =  VectorisedStiffnessMatricesElectroMixedIncomp(igauss,BF(:,:,igauss),SigmaJ(igauss),...
                                            QF(:,:,igauss),QSigmaH(:,:,igauss),pressure(igauss),fem.volume.bilinear,...
                                            D0_matrix(:,:,igauss),Sigmad_matrix(:,:,igauss),DN_X_phi(:,:,igauss),...
                                            material_information.derivatives.D2U,kinematics.F(:,:,igauss),Hx_vectorised(:,igauss));
    %----------------------------------------------------------------------
    % Stiffness matrices
    %----------------------------------------------------------------------
    assmb.Kxx        =  assmb.Kxx      +  vect_mat.Kxx*Int_weight;
    assmb.Kxp        =  assmb.Kxp      +  vect_mat.Kxp*Int_weight;
    assmb.KxSigmaF   =  assmb.KxSigmaF +  vect_mat.KxSigmaF*Int_weight;
    assmb.KxSigmaH   =  assmb.KxSigmaH +  vect_mat.KxSigmaH*Int_weight;
    assmb.KxSigmaJ   =  assmb.KxSigmaJ +  vect_mat.KxSigmaJ*Int_weight;
    assmb.KxD0       =  assmb.KxD0     +  vect_mat.KxD0*Int_weight;
    
    assmb.KphiD0     =  assmb.KphiD0   +  vect_mat.KphiD0*Int_weight;
    
    assmb.Kpp        =  assmb.Kpp      +  vect_mat.Kpp*Int_weight;
    
    assmb.KFF        =  assmb.KFF      +  vect_mat.KFF*Int_weight;
    assmb.KFH        =  assmb.KFH      +  vect_mat.KFH*Int_weight;
    assmb.KFJ        =  assmb.KFJ      +  vect_mat.KFJ*Int_weight;
    assmb.KFD0       =  assmb.KFD0     +  vect_mat.KFD0*Int_weight;
    assmb.KFd        =  assmb.KFd      +  vect_mat.KFd*Int_weight;
    assmb.KFSigmaF   =  assmb.KFSigmaF +  vect_mat.KFSigmaF*Int_weight;
    
    assmb.KHH        =  assmb.KHH      +  vect_mat.KHH*Int_weight;
    assmb.KHJ        =  assmb.KHJ      +  vect_mat.KHJ*Int_weight;
    assmb.KHD0       =  assmb.KHD0     +  vect_mat.KHD0*Int_weight;
    assmb.KHd        =  assmb.KHd      +  vect_mat.KHd*Int_weight;
    assmb.KHSigmaH   =  assmb.KHSigmaH +  vect_mat.KHSigmaH*Int_weight;
    
    assmb.KJJ        =  assmb.KJJ      +  vect_mat.KJJ*Int_weight;
    assmb.KJD0       =  assmb.KJD0     +  vect_mat.KJD0*Int_weight;
    assmb.KJd        =  assmb.KJd      +  vect_mat.KJd*Int_weight;
    assmb.KJSigmaJ   =  assmb.KJSigmaJ +  vect_mat.KJSigmaJ*Int_weight;
    
    assmb.KD0D0      =  assmb.KD0D0     +  vect_mat.KD0D0*Int_weight;
    assmb.KD0d       =  assmb.KD0d      +  vect_mat.KD0d*Int_weight;
    assmb.KD0Sigmad  =  assmb.KD0Sigmad +  vect_mat.KD0Sigmad*Int_weight;
    
    assmb.Kdd        =  assmb.Kdd      +  vect_mat.Kdd*Int_weight;
    assmb.KdSigmad   =  assmb.KdSigmad +  vect_mat.KdSigmad*Int_weight;
end
%--------------------------------------------------------------------------
% Static condensation procedure in order to get the equivalent
% stiffness matrices and residual vectors
%--------------------------------------------------------------------------
assmb                =  ResidualStiffnessStaticCondensElectroMixedIncomp(assmb);





