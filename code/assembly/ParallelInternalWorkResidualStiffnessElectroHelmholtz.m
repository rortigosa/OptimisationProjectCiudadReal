function asmb        =  ParallelInternalWorkResidualStiffnessElectroHelmholtz(ielem,quadrature,solution,geometry,mesh,fem,...
                                                                     vectorisation,mat_info)                                                                     
%--------------------------------------------------------------------------
% Number of Gauss points
%--------------------------------------------------------------------------
ngauss               =  size(quadrature.volume.bilinear.Chi,1);
%--------------------------------------------------------------------------
% Initialise assembled residuals per element 
%--------------------------------------------------------------------------
asmb                 =  ElementResidualMatricesInitialisationElectro(geometry,mesh);
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
%--------------------------------------------------------------------------
% First and second derivatives of the model. 
%--------------------------------------------------------------------------
mat_info             =  GetDerivativesModelElectroHelmholtz(ielem,geometry.dim,ngauss,kinematics.F,kinematics.H,kinematics.J,E0,...
                                                     mat_info,vectorisation);
%--------------------------------------------------------------------------
% First Piola-Kirchhoff stress tensor.        
%--------------------------------------------------------------------------
Piola                =  FirstPiolaKirchhoffStressTensorElectroHelmholtz(ngauss,geometry.dim,kinematics.F,kinematics.H,...
                                                     mat_info.derivatives.DPsi.DPsiDF,...
                                                               mat_info.derivatives.DPsi.DPsiDH,...
                                                               mat_info.derivatives.DPsi.DPsiDJ);
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
QSigmaH              =  QMatrixComputation(mat_info.derivatives.DPsi.DPsiDH,geometry.dim,ngauss);    
%--------------------------------------------------------------------------
% Electric displacement field
%--------------------------------------------------------------------------
D0                   =  -mat_info.derivatives.DPsi.DPsiDE0;
%--------------------------------------------------------------------------
% Residuals and Stiffness matrices 
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Int_weight       =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Residual conservation of linear momentum.
    %----------------------------------------------------------------------
    asmb.Tx          =  asmb.Tx   +  (BF(:,:,igauss)'*Piola_vectorised(:,igauss))*Int_weight;
    %----------------------------------------------------------------------
    % Residual Gauss' law.- (D0'*DN_X*W*J_t)'
    %----------------------------------------------------------------------
    asmb.Tphi        =  asmb.Tphi   +  (DN_X_phi(:,:,igauss)'*D0(:,igauss))*Int_weight;
end      
%--------------------------------------------------------------------------
% Residuals and Stiffness matrices 
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Int_weight       =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices
    %----------------------------------------------------------------------
    vect_mat         =  VectorisedStiffnessMatricesElectroHelmholtz(igauss,BF(:,:,igauss),DN_X_phi(:,:,igauss),...
                                                       mat_info.derivatives.D2Psi,mat_info.derivatives.DPsi,...
                                                       QF(:,:,igauss),QSigmaH(:,:,igauss),...
                                                       kinematics.H(:,:,igauss));
    %----------------------------------------------------------------------
    % Stiffness matrices
    %----------------------------------------------------------------------
    asmb.Kxx         =  asmb.Kxx      +  vect_mat.Kxx*Int_weight;
    asmb.Kxphi       =  asmb.Kxphi    -  vect_mat.Kxphi*Int_weight;
    asmb.Kphix       =  asmb.Kphix    -  vect_mat.Kphix*Int_weight;
    asmb.Kphiphi     =  asmb.Kphiphi  +  vect_mat.Kphiphi*Int_weight;
end





