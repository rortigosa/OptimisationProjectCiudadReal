function DIDrho       =  ParallelDerivativeULinear(ielem,quadrature,solution,geometry,mesh,fem,...
                                                  mat_info,mat_info_void,p,vectorisation)

ngauss                =  size(quadrature.volume.bilinear.Chi,1);
%--------------------------------------------------------------------------
% Obtain gradients of kinematics and electrical variables
%--------------------------------------------------------------------------
kinematics            =  KinematicsFunctionVolume(geometry.dim,...
                               solution.x.Eulerian_x(:,mesh.volume.x.connectivity(:,ielem)),...
                               fem.volume.bilinear.x.DN_X);
%--------------------------------------------------------------------------
% First and second derivatives of the model for the solid
%--------------------------------------------------------------------------
mat_info              =  GetDerivativesModelMechanics(ielem,geometry.dim,ngauss,kinematics.F,kinematics.H,kinematics.J,...
                                                         mat_info,mat_info.material_model{mat_info.material_identifier(ielem)});
%--------------------------------------------------------------------------
% First and second derivatives of the model for the void
%--------------------------------------------------------------------------
mat_info_void         =  GetDerivativesModelMechanics(ielem,geometry.dim,ngauss,kinematics.F,kinematics.H,kinematics.J,...
                                                         mat_info_void,mat_info_void.material_model);
%--------------------------------------------------------------------------
% Sum both contributions (rho^qDWDF_solid + (0 - rho^q)*DWDF_void)
%--------------------------------------------------------------------------
mat_info.derivatives  =  SumDerivativesU(mat_info.derivatives,mat_info_void.derivatives,...
                                             mat_info.optimisation.rho(ielem),mat_info.optimisation.penal,0); 
%--------------------------------------------------------------------------
% Matrix BF    
%--------------------------------------------------------------------------
BF                     =  BMatrix(ngauss,geometry.dim,mesh.volume.x.n_node_elem,...
                                  fem.volume.bilinear.x.DN_X,...
                                  vectorisation.Bx_matrix.LHS_indices,...
                                  vectorisation.Bx_matrix.RHS_indices);
%--------------------------------------------------------------------------
% Q matrices arising from the linearisation of H: DH[].SigmaH = Q*DF[]. and
%--------------------------------------------------------------------------
QF                     =  QMatrixComputation(kinematics.F,geometry.dim,ngauss);
QSigmaH                =  QMatrixComputation(mat_info.derivatives.DU.DUDH,geometry.dim,ngauss);    
if geometry.dim==2
   QSigmaH             =  QSigmaH*0;
end
%--------------------------------------------------------------------------
% Derivative
%--------------------------------------------------------------------------
DIDrho                 =  0;
pelem                  =  reshape(p(:,mesh.volume.x.connectivity(:,ielem)),[],1);
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    IntWeight          =  (fem.volume.bilinear.x.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices
    %----------------------------------------------------------------------
    vect_mat           =  VectorisedStiffnessMatricesU(igauss,BF(:,:,igauss),...
                                                      mat_info.derivatives.D2U,...
                                                      mat_info.derivatives.DU,...
                                                      QF(:,:,igauss),QSigmaH(:,:,igauss),...
                                                      kinematics.H(:,:,igauss));
    %----------------------------------------------------------------------
    % Stiffness matrices 
    %----------------------------------------------------------------------
    DIDrho             =  DIDrho  -  (pelem'*vect_mat.Kxx*pelem)*IntWeight;
    %DIDrho       =  DIDrho   -  trace(Piola(:,:,igauss)'*gradp(:,:,igauss))*IntWeight;
end


