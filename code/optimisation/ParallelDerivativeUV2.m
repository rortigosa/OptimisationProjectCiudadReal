function DIDrho     =  ParallelDerivativeUV2(ielem,quadrature,solution,geometry,mesh,fem,...
                                                  mat_info,mat_info_void,p,vectorisation)

ngauss              =  size(quadrature.volume.bilinear.Chi,1);
%--------------------------------------------------------------------------
% Obtain gradients of kinematics and electrical variables
%--------------------------------------------------------------------------
kinematics          =  KinematicsFunctionVolume(geometry.dim,...
                               solution.x.Eulerian_x(:,mesh.volume.x.connectivity(:,ielem)),...
                               fem.volume.bilinear.x.DN_X);
%--------------------------------------------------------------------------
% Obtain gradient of the test function p
%--------------------------------------------------------------------------
gradp               =  GradpAdjoint(geometry.dim,p(:,mesh.volume.x.connectivity(:,ielem)),...                                
                                fem.volume.bilinear.x.DN_X);                                
%--------------------------------------------------------------------------
% Determine if linear elasticity or nonlinear elasticity shall be applied
% on the current element
%--------------------------------------------------------------------------
Identity            =  repmat(eye(geometry.dim),1,1,ngauss);
u                   =  solution.x.Eulerian_x(:,mesh.volume.x.connectivity(:,ielem)) - ...
                        solution.x.Lagrangian_X(:,mesh.volume.x.connectivity(:,ielem));
kinematics_void.F   =  Identity;
kinematics_void.H   =  Identity;
kinematics_void.J   =  ones(ngauss,1);
%--------------------------------------------------------------------------
% First and second derivatives of the model for the solid
%--------------------------------------------------------------------------
mat_info            =  GetDerivativesModelMechanics(ielem,geometry.dim,ngauss,kinematics.F,kinematics.H,kinematics.J,...
                                                         mat_info,mat_info.material_model{mat_info.material_identifier(ielem)});
%--------------------------------------------------------------------------
% First and second derivatives of the model for the void
%--------------------------------------------------------------------------
mat_info_void       =  GetDerivativesModelMechanics(ielem,geometry.dim,ngauss,kinematics_void.F,kinematics_void.H,kinematics_void.J,...
                                                         mat_info_void,mat_info_void.material_model);
%--------------------------------------------------------------------------
% First Piola-Kirchhoff stress tensor.        
%--------------------------------------------------------------------------
Piola               =  FirstPiolaKirchhoffStressTensorU(ngauss,geometry.dim,kinematics.F,kinematics.H,...
                                                    mat_info.derivatives.DU.DUDF,...
                                                    mat_info.derivatives.DU.DUDH,...
                                                    mat_info.derivatives.DU.DUDJ);
%--------------------------------------------------------------------------
% Matrix BF    
%--------------------------------------------------------------------------
BF                  =  BMatrix(ngauss,geometry.dim,mesh.volume.x.n_node_elem,...
                             fem.volume.bilinear.x.DN_X,...
                             vectorisation.Bx_matrix.LHS_indices,...
                             vectorisation.Bx_matrix.RHS_indices);
%--------------------------------------------------------------------------
% Q matrices arising from the linearisation of H: DH[].SigmaH = Q*DF[]. and
%--------------------------------------------------------------------------
QF                  =  QMatrixComputation(kinematics.F,geometry.dim,ngauss);
QSigmaH             =  QMatrixComputation(mat_info.derivatives.DU.DUDH,geometry.dim,ngauss);    
if geometry.dim==2
   QSigmaH          =  QSigmaH*0;
end
%--------------------------------------------------------------------------
% Q matrices arising from the linearisation of H: DH[].SigmaH = Q*DF[] for
% the void
%--------------------------------------------------------------------------
QF_void             =  QMatrixComputation(kinematics_void.F,geometry.dim,ngauss);
QSigmaH_void        =  QMatrixComputation(mat_info_void.derivatives.DU.DUDH,geometry.dim,ngauss);    
if geometry.dim==2
   QSigmaH_void     =  QSigmaH_void*0;
end
%--------------------------------------------------------------------------
% Integration weights
%--------------------------------------------------------------------------
IntWeight           =  quadrature.volume.bilinear.W_v.*fem.volume.bilinear.x.DX_chi_Jacobian;
%--------------------------------------------------------------------------
% Elemental value of the test function p
%--------------------------------------------------------------------------
pelem               =  p(:,mesh.volume.x.connectivity(:,ielem));
%--------------------------------------------------------------------------
% Derivative
%--------------------------------------------------------------------------
DIDrho              =  0;
density             =  mat_info.optimisation.rho(ielem)^mat_info.optimisation.penal;
for igauss=1:ngauss
        %------------------------------------------------------------------
        % Vectorisation of stiffness matrices
        %------------------------------------------------------------------
       DIDrho       =  DIDrho   -  density*trace(Piola(:,:,igauss)'*gradp(:,:,igauss))*IntWeight(igauss);
end
DIDrho_void          =  0;
for igauss=1:ngauss
        %------------------------------------------------------------------
        % Vectorisation of stiffness matrices
        %------------------------------------------------------------------
        vect_mat    =  VectorisedStiffnessMatricesU(igauss,BF(:,:,igauss),...
                                        mat_info_void.derivatives.D2U,...
                                        mat_info_void.derivatives.DU,...
                                        QF_void(:,:,igauss),QSigmaH_void(:,:,igauss),...
                                        kinematics_void.H(:,:,igauss));
       DIDrho_void  =  DIDrho_void   -  (-density)*(pelem(:)'*vect_mat.Kxx*u(:))*IntWeight(igauss);
end

DIDrho   =  DIDrho + DIDrho_void;




