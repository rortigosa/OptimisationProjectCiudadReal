function asmb      =  ParallelInternalWorkLinearElasticityResidualStiffnessU(ielem,quadrature,solution,geometry,mesh,fem,...
                                                                     vectorisation,mat_info,mat_info_void)
ngauss             =  size(quadrature.volume.bilinear.Chi,1);
dim                =  geometry.dim;
%--------------------------------------------------------------------------
% Initialise assembled residuals per element 
%--------------------------------------------------------------------------
asmb               =  ElementResidualMatricesInitialisationU(geometry,mesh);
%--------------------------------------------------------------------------
% Obtain gradients of kinematics and electrical variables
%--------------------------------------------------------------------------
kinematics         =  KinematicsFunctionVolume(dim,...
                                   solution.x.Eulerian_x(:,mesh.volume.x.connectivity(:,ielem)),...
                                   fem.volume.bilinear.x.DN_X);  
%--------------------------------------------------------------------------
% Determine if linear elasticity or nonlinear elasticity shall be applied
% on the current element
%--------------------------------------------------------------------------
u                  =  solution.x.Eulerian_x(:,mesh.volume.x.connectivity(:,ielem)) - ...
                                                solution.x.Lagrangian_X(:,mesh.volume.x.connectivity(:,ielem));
Identity           =  repmat(eye(dim),1,1,ngauss);
kinematics_void.F  =  Identity;
kinematics_void.H  =  Identity;
kinematics_void.J  =  ones(ngauss,1);
%--------------------------------------------------------------------------
% First and second derivatives of the model for the solid
%--------------------------------------------------------------------------
mat_info           =  GetDerivativesModelMechanics(ielem,dim,ngauss,kinematics.F,kinematics.H,kinematics.J,...
                                                       mat_info,mat_info.material_model{mat_info.material_identifier(ielem)});
%--------------------------------------------------------------------------
% First and second derivatives of the model for the void
%--------------------------------------------------------------------------
mat_info_void      =  GetDerivativesModelMechanics(ielem,dim,ngauss,kinematics_void.F,kinematics_void.H,kinematics_void.J,...
                                                  mat_info_void,mat_info_void.material_model);
%--------------------------------------------------------------------------
% First Piola-Kirchhoff stress tensor.        
%--------------------------------------------------------------------------
Piola              =  FirstPiolaKirchhoffStressTensorU(ngauss,dim,kinematics.F,kinematics.H,...
                                                         mat_info.derivatives.DU.DUDF,...
                                                         mat_info.derivatives.DU.DUDH,...
                                                         mat_info.derivatives.DU.DUDJ);
Piola_vect         =  Matrix2Vector(dim^2,ngauss,Piola);
%--------------------------------------------------------------------------
% Matrix BF    
%--------------------------------------------------------------------------
BF                 =  BMatrix(ngauss,dim,mesh.volume.x.n_node_elem,...
                             fem.volume.bilinear.x.DN_X,...
                             vectorisation.Bx_matrix.LHS_indices,...
                             vectorisation.Bx_matrix.RHS_indices);
%--------------------------------------------------------------------------
% Q matrices arising from the linearisation of H: DH[].SigmaH = Q*DF[]. and
%--------------------------------------------------------------------------
QF                 =  QMatrixComputation(kinematics.F,dim,ngauss);
QSigmaH            =  QMatrixComputation(mat_info.derivatives.DU.DUDH,dim,ngauss);    
if dim==2
   QSigmaH         =  QSigmaH*0;
end
%--------------------------------------------------------------------------
% Q matrices arising from the linearisation of H: DH[].SigmaH = Q*DF[] in
% the void
%--------------------------------------------------------------------------
QF_void            =  QMatrixComputation(kinematics_void.F,dim,ngauss);
QSigmaH_void       =  QMatrixComputation(mat_info_void.derivatives.DU.DUDH,dim,ngauss);    
if dim==2
   QSigmaH_void    =  QSigmaH_void*0;
end
%--------------------------------------------------------------------------
% Integration weights
%--------------------------------------------------------------------------
IntWeight          =  quadrature.volume.bilinear.W_v.*fem.volume.bilinear.x.DX_chi_Jacobian;
%--------------------------------------------------------------------------
% Residuals and Stiffness matrices for linearelasticity regions
%--------------------------------------------------------------------------
density            =  mat_info.optimisation.rho(ielem)^mat_info.optimisation.penal;
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices
    %----------------------------------------------------------------------
    vect_mat       =  VectorisedStiffnessMatricesU(igauss,BF(:,:,igauss),...
                                               mat_info.derivatives.D2U,...
                                               mat_info.derivatives.DU,...
                                               QF(:,:,igauss),QSigmaH(:,:,igauss),...
                                               kinematics.H(:,:,igauss));
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices
    %----------------------------------------------------------------------
    vect_mat_void  =  VectorisedStiffnessMatricesU(igauss,BF(:,:,igauss),...
                                        mat_info_void.derivatives.D2U,...
                                        mat_info_void.derivatives.DU,...
                                        QF_void(:,:,igauss),QSigmaH_void(:,:,igauss),...
                                        kinematics_void.H(:,:,igauss));
    %----------------------------------------------------------------------
    % Residual and stiffness matrices 
    %----------------------------------------------------------------------
    asmb.Tx        =  asmb.Tx   +  density*(BF(:,:,igauss)'*Piola_vect(:,igauss))*IntWeight(igauss);
    asmb.Kxx       =  asmb.Kxx  +  density*vect_mat.Kxx*IntWeight(igauss);
    %----------------------------------------------------------------------
    % Residual and stiffness matrices in the void
    %----------------------------------------------------------------------
    asmb.Tx        =  asmb.Tx   +  (1 - density)*(vect_mat_void.Kxx*u(:))*IntWeight(igauss);
    asmb.Kxx       =  asmb.Kxx  +  (1 - density)*vect_mat_void.Kxx*IntWeight(igauss);
end
