function asmb          =  ParallelInternalWorkResidualStiffnessU(ielem,quadrature,solution,geometry,mesh,fem,...
                                                                     vectorisation,mat_info,mat_info_void,...
                                                                     kinematics)
ngauss                 =  size(quadrature.volume.bilinear.Chi,1);
%--------------------------------------------------------------------------
% Initialise assembled residuals per element 
%--------------------------------------------------------------------------
asmb                   =  ElementResidualMatricesInitialisationU(geometry,mesh);
%--------------------------------------------------------------------------
% Obtain gradients of kinematics and electrical variables
%--------------------------------------------------------------------------
kinematics             =  KinematicsFunctionVolume(geometry.dim,...
                                   solution.x.Eulerian_x(:,mesh.volume.x.connectivity(:,ielem)),...
                                   fem.volume.bilinear.x.DN_X);  
% kinematics        =  KinematicsFunctionVolumeCMex(kinematics,geometry.dim,...
%                                    solution.x.Eulerian_x(:,mesh.volume.x.connectivity(:,ielem)),...
%                                    fem.volume.bilinear.x.DN_X);
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
Piola                  =  FirstPiolaKirchhoffStressTensorU(ngauss,geometry.dim,kinematics.F,kinematics.H,...
                                                                mat_info.derivatives.DU.DUDF,...
                                                                mat_info.derivatives.DU.DUDH,...
                                                                mat_info.derivatives.DU.DUDJ);
Piola_vectorised       =  Matrix2Vector(geometry.dim^2,ngauss,Piola);
% mat_info.Piola           =  FirstPiolaKirchhoffStressTensorUCMex(mat_info.Piola,ngauss,geometry.dim,kinematics.F,kinematics.H,...
%                                                                mat_info.derivatives.DU.DUDF,...
%                                                                mat_info.derivatives.DU.DUDH,...
%                                                                mat_info.derivatives.DU.DUDJ);
% Piola_vectorised       =  Matrix2Vector(geometry.dim^2,ngauss,mat_info.Piola);
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
% Integration weights
%--------------------------------------------------------------------------
IntWeight              =  quadrature.volume.bilinear.W_v.*fem.volume.bilinear.x.DX_chi_Jacobian;
% vect_kin.BF            =  BF;
% vect_kin.QF            =  QF;
% vect_kin.QSigmaH       =  QSigmaH;
% if LE_flag  
%    asmb                =  ResidualsMatricesULECMex(asmb,mat_info_void.derivatives.DU,mat_info_void.derivatives.D2U,vect_kin,...
%                                                    kinematics,IntWeight,geometry.dim,...
%                                                    mesh.volume.x.n_node_elem,ngauss,u);
% else
%    asmb                =  ResidualsMatricesUCMex(asmb,mat_info.derivatives.DU,mat_info.derivatives.D2U,Piola_vectorised,vect_kin,kinematics,...
%                                                  IntWeight,geometry.dim,mesh.volume.x.n_node_elem,ngauss);
% end

% 
if LE_flag
   %-----------------------------------------------------------------------
   %-----------------------------------------------------------------------
   % Residuals and Stiffness matrices for linearelasticity regions
   %-----------------------------------------------------------------------
   %-----------------------------------------------------------------------
   for igauss=1:ngauss
       %-------------------------------------------------------------------
       % Vectorisation of stiffness matrices
       %-------------------------------------------------------------------
       vect_mat        =  VectorisedStiffnessMatricesU(igauss,BF(:,:,igauss),...
                                               mat_info.derivatives.D2U,...
                                               mat_info.derivatives.DU,...
                                               QF(:,:,igauss),QSigmaH(:,:,igauss),...
                                               kinematics.H(:,:,igauss));
       %-------------------------------------------------------------------
       % Residual and stiffness matrices
       %-------------------------------------------------------------------
       asmb.Tx         =  asmb.Tx   +  (vect_mat.Kxx*u(:))*IntWeight(igauss);
       asmb.Kxx        =  asmb.Kxx  +  vect_mat.Kxx*IntWeight(igauss);
   end
   
else
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    % Residuals and Stiffness matrices for nonlinear elasticity regions
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    for igauss=1:ngauss
        %------------------------------------------------------------------
        % Residual conservation of linear momentum.
        %------------------------------------------------------------------
        asmb.Tx        =  asmb.Tx  +  (BF(:,:,igauss)'*Piola_vectorised(:,igauss))*IntWeight(igauss);
        %------------------------------------------------------------------
        % Vectorisation of stiffness matrices
        %------------------------------------------------------------------
        vect_mat       =  VectorisedStiffnessMatricesU(igauss,BF(:,:,igauss),...
                                        mat_info.derivatives.D2U,...
                                        mat_info.derivatives.DU,...
                                        QF(:,:,igauss),QSigmaH(:,:,igauss),...
                                        kinematics.H(:,:,igauss));
        %------------------------------------------------------------------
        % Stiffness matrices
        %------------------------------------------------------------------
        asmb.Kxx       =  asmb.Kxx  +  vect_mat.Kxx*IntWeight(igauss);
    end
end



