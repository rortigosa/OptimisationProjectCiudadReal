function asmb     =  ParallelInternalWorkResidualStiffnessUP(ielem,quadrature,solution,geometry,mesh,fem,...
                                                                     vectorisation,mat_info,mat_info_void)
                                                                                                                  
ngauss            =  size(quadrature.volume.bilinear.Chi,1);
%--------------------------------------------------------------------------
% Initialise assembled residuals per element 
%--------------------------------------------------------------------------
asmb              =  ElementResidualMatricesInitialisationUP(geometry,mesh);
%--------------------------------------------------------------------------
% Obtain gradients of kinematics and electrical variables
%--------------------------------------------------------------------------
kinematics        =  KinematicsFunctionVolume(geometry.dim,...
                                   solution.x.Eulerian_x(:,mesh.volume.x.connectivity(:,ielem)),...
                                   fem.volume.bilinear.x.DN_X);                                      
%--------------------------------------------------------------------------
% Obtain pressure at every gauss point 
%--------------------------------------------------------------------------
pressure          =  ScalarFEMInterpolation(fem.volume.bilinear.pressure.N,...
                                            solution.pressure(mesh.volume.pressure.connectivity(:,ielem)));                                         
%--------------------------------------------------------------------------
% Determine if linear elasticity or nonlinear elasticity shall be applied
% on the current element
%--------------------------------------------------------------------------
if mat_info.optimisation.rho(ielem)<0.9
   LE_flag             =  1; 
   Identity            =  repmat(eye(geometry.dim),1,1,ngauss);
   u                   =  solution.x.Eulerian_x(:,mesh.volume.x.connectivity(:,ielem)) - ...
                          solution.x.Lagrangian_X(:,mesh.volume.x.connectivity(:,ielem));
   kinematics.F        =  Identity;
   kinematics.H        =  Identity;
   kinematics.J        =  ones(ngauss,1);
else 
   LE_flag             =  0; 
end
%--------------------------------------------------------------------------
% First and second derivatives of the model for the solid
%--------------------------------------------------------------------------
mat_info               =  GetDerivativesModelMechanics(ielem,geometry.dim,ngauss,kinematics.F,kinematics.H,kinematics.J,...
                                                         mat_info,mat_info.material_model{mat_info.material_identifier(ielem)});
%--------------------------------------------------------------------------
% First and second derivatives of the model for the void
%--------------------------------------------------------------------------
mat_info_void          =  GetDerivativesModelMechanics(ielem,geometry.dim,ngauss,kinematics.F,kinematics.H,kinematics.J,...
                                                  mat_info_void,mat_info_void.material_model);
%--------------------------------------------------------------------------
% Sum both contributions (rho^qDWDF_solid + (1 - rho^q)*DWDF_void)
%--------------------------------------------------------------------------
mat_info.derivatives   =  SumDerivativesU(mat_info.derivatives,mat_info_void.derivatives,...
                                             mat_info.optimisation.rho(ielem),mat_info.optimisation.penal,1); 
%--------------------------------------------------------------------------
% First Piola-Kirchhoff stress tensor.        
%--------------------------------------------------------------------------
Piola             =  FirstPiolaKirchhoffStressTensorUP(ngauss,geometry.dim,kinematics.F,kinematics.H,...
                                                       mat_info.derivatives.DU.DUDF,...
                                                       mat_info.derivatives.DU.DUDH,...
                                                       mat_info.derivatives.DU.DUDJ,...
                                                       pressure);
Piola_vectorised  =  Matrix2Vector(geometry.dim^2,ngauss,Piola);
%--------------------------------------------------------------------------
% Matrix BF    
%--------------------------------------------------------------------------
BF                =  BMatrix(ngauss,geometry.dim,mesh.volume.x.n_node_elem,DN_X_x,...
                             vectorisation.Bx_matrix.LHS_indices,...
                             vectorisation.Bx_matrix.RHS_indices);
%--------------------------------------------------------------------------
% Q matrices arising from the linearisation of H: DH[].SigmaH = Q*DF[]. and
%--------------------------------------------------------------------------
QF                =  QMatrixComputation(kinematics.F,geometry.dim,ngauss);
QSigmaH           =  QMatrixComputation(mat_info.derivatives.DU.DUDH,geometry.dim,ngauss);    
if geometry.dim==2
   QSigmaH             =  QSigmaH*0;
end
%--------------------------------------------------------------------------
% Integration weights
%--------------------------------------------------------------------------
IntWeight              =  quadrature.volume.bilinear.W_v.*fem.volume.bilinear.x.DX_chi_Jacobian;
%--------------------------------------------------------------------------
% Residuals and Stiffness matrices 
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Int_weight    =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Residual conservation of linear momentum.
    %----------------------------------------------------------------------
    asmb.Tx       =  asmb.Tx   +  (BF(:,:,igauss)'*Piola_vectorised(:,igauss))*Int_weight;
    %----------------------------------------------------------------------
    % Residual pressure (incompressibility). 
    %----------------------------------------------------------------------
    asmb.Tp       =  asmb.Tp  +  fem.volume.bilinear.pressure.N(:,igauss)*(kinematics.J(igauss) - 1)*Int_weight;
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
    vect_mat      =  VectorisedStiffnessMatricesUP(igauss,BF(:,:,igauss),...
                                                   mat_info.derivatives.D2U,...
                                                   mat_info.derivatives.DU,...
                                                   pressure,QF(:,:,igauss),QSigmaH(:,:,igauss),...
                                                   kinematics.H(:,:,igauss),...
                                                   fem.volume.bilinear.pressure.N(:,igauss));
    %----------------------------------------------------------------------
    % Stiffness matrices
    %----------------------------------------------------------------------
    asmb.Kxx      =  asmb.Kxx  +  vect_mat.Kxx*Int_weight;
    asmb.Kxp      =  asmb.Kxp  +  vect_mat.Kxp*Int_weight;
    asmb.Kpx      =  asmb.Kpx  +  vect_mat.Kpx*Int_weight;
    asmb.Kpp      =  asmb.Kpp  +  vect_mat.Kpp*Int_weight;
end




