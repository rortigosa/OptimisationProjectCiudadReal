%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the elemental residual vectors and stiffness
% matrices for the formulation with fields: x-phi-p
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function element_assembly     =  ParallelInternalWorkResidualStiffnessFHJ(ielem,quadrature,solution,geometry,mesh,fem,...
                                                                                           vectorisation,material_information)

%--------------------------------------------------------------------------
% Number of Gauss points
%--------------------------------------------------------------------------
ngauss                        =  size(quadrature.volume.bilinear.Chi,1);
%--------------------------------------------------------------------------
% Initialise assembled residuals per element 
%--------------------------------------------------------------------------
element_assembly              =  ElementResidualMatricesInitialisationFHJ(geometry,mesh);        
%--------------------------------------------------------------------------
% Obtain gradients of kinematics and electrical variables
%--------------------------------------------------------------------------
[kinematics,DN_X_x]           =  KinematicsFunctionVolume(geometry.dim,...
                                                          solution.x.Eulerian_x(:,mesh.volume.x.connectivity(:,ielem)),...
                                                          solution.x.Lagrangian_X(:,mesh.volume.x.connectivity(:,ielem)),...
                                                          fem.volume.bilinear.x.DN_chi);
Fx_vectorised                 =  Matrix2Vector(geometry.dim^2,ngauss,kinematics.F);
Hx_vectorised                 =  Matrix2Vector(geometry.dim^2,ngauss,kinematics.H);
%--------------------------------------------------------------------------
% Obtain the fields (F,H,J,D0,d) and (SigmaF,SigmaH,SigmaJ,Sigmad) at each
% Gauss points
%--------------------------------------------------------------------------
[F,Fvectorised,H,Hvectorised,J,...
 SigmaF,SigmaFvectorised,SigmaH,...
 SigmaHvectorised,SigmaJ]     =  FHJFEMFieldsInterpolation(ielem,geometry.dim,ngauss,fem,solution,...
                                                   mesh.volume.F,mesh.volume.H,mesh.volume.J);
%--------------------------------------------------------------------------
% First and second derivatives of the model.  
%--------------------------------------------------------------------------
material_information          =  GetDerivativesModelMechanics(ielem,geometry.dim,ngauss,F,H,J,material_information);
DUDF_vectorised               =  Matrix2Vector(geometry.dim^2,ngauss,material_information.derivatives.DU.DUDF);
DUDH_vectorised               =  Matrix2Vector(geometry.dim^2,ngauss,material_information.derivatives.DU.DUDH);
DUDJ                          =  material_information.derivatives.DU.DUDJ;
%--------------------------------------------------------------------------
% First Piola-Kirchhoff stress tensor.       
%--------------------------------------------------------------------------
Piola                         =  FirstPiolaKirchhoffStressTensorU(ngauss,geometry.dim,kinematics.F,kinematics.H,...
                                                                SigmaF,SigmaH,SigmaJ);
Piola_vectorised              =  Matrix2Vector(geometry.dim^2,ngauss,Piola);
%--------------------------------------------------------------------------
% Matrix BF   
%--------------------------------------------------------------------------
BF                            =  BMatrix(ngauss,geometry.dim,mesh.volume.x.n_node_elem,DN_X_x,...
                                         vectorisation.Bx_matrix.LHS_indices,...
                                         vectorisation.Bx_matrix.RHS_indices);
%--------------------------------------------------------------------------
% Q matrices arising from the linearisation of H: DH[].SigmaH = Q*DF[]. and
%--------------------------------------------------------------------------
QF                            =  QMatrixComputation(kinematics.F,geometry.dim,ngauss);
QSigmaH                       =  QMatrixComputation(material_information.derivatives.DU.DUDH,geometry.dim,ngauss);    
%--------------------------------------------------------------------------
% Residuals and Stiffness matrices 
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Integration_weight        =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Residual conservation of linear momentum.
    %----------------------------------------------------------------------
    element_assembly.Tx       =  element_assembly.Tx   +  ...
                                (BF(:,:,igauss)'*Piola_vectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for F.
    %----------------------------------------------------------------------
    element_assembly.TF       =  element_assembly.TF   +  ...
                                 fem.volume.bilinear.F.N_vectorised(:,:,igauss)'*(DUDF_vectorised(:,igauss) - SigmaFvectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for H.
    %----------------------------------------------------------------------
    element_assembly.TH       =  element_assembly.TH   +  ...
                                 fem.volume.bilinear.H.N_vectorised(:,:,igauss)'*(DUDH_vectorised(:,igauss) - SigmaHvectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for J.
    %----------------------------------------------------------------------
    element_assembly.TJ       =  element_assembly.TJ  +  ...
                                 fem.volume.bilinear.J.N(:,igauss)*(DUDJ(igauss) - SigmaJ(igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for SigmaF.
    %----------------------------------------------------------------------
    element_assembly.TSigmaF  =  element_assembly.TSigmaF   +  ...
                                 fem.volume.bilinear.F.N_vectorised(:,:,igauss)'*(Fx_vectorised(:,igauss) - Fvectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for SigmaH.
    %----------------------------------------------------------------------
    element_assembly.TSigmaH  =  element_assembly.TSigmaH   +  ...
                                 fem.volume.bilinear.H.N_vectorised(:,:,igauss)'*(Hx_vectorised(:,igauss) - Hvectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for SigmaJ.
    %----------------------------------------------------------------------
    element_assembly.TSigmaJ  =  element_assembly.TSigmaJ  +  ...
                                 fem.volume.bilinear.J.N(:,igauss)*(kinematics.J(igauss) - J(igauss))*Integration_weight;
end      
%--------------------------------------------------------------------------
% Matrices
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Integration_weight    =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices
    %----------------------------------------------------------------------
    vectorised_matrices   =  VectorisedStiffnessMatricesFHJ(igauss,BF(:,:,igauss),...
                                                material_information.derivatives.DU.DUDJ(igauss),...        
                                                QF(:,:,igauss),QSigmaH(:,:,igauss),...
                                                Hx_vectorised(:,igauss),fem.volume.bilinear,...
                                                material_information.derivatives.D2U);
    %----------------------------------------------------------------------
    % Stiffness matrices
    %----------------------------------------------------------------------
    element_assembly.Kxx        =  element_assembly.Kxx      +  vectorised_matrices.Kxx*Integration_weight;
    element_assembly.KxSigmaF   =  element_assembly.KxSigmaF +  vectorised_matrices.KxSigmaF*Integration_weight;
    element_assembly.KxSigmaH   =  element_assembly.KxSigmaH +  vectorised_matrices.KxSigmaH*Integration_weight;
    element_assembly.KxSigmaJ   =  element_assembly.KxSigmaJ +  vectorised_matrices.KxSigmaJ*Integration_weight;
%         
    element_assembly.KFF        =  element_assembly.KFF      +  vectorised_matrices.KFF*Integration_weight;
    element_assembly.KFH        =  element_assembly.KFH      +  vectorised_matrices.KFH*Integration_weight;
    element_assembly.KFJ        =  element_assembly.KFJ      +  vectorised_matrices.KFJ*Integration_weight;
    element_assembly.KFSigmaF   =  element_assembly.KFSigmaF +  vectorised_matrices.KFSigmaF*Integration_weight;
    
    element_assembly.KHH        =  element_assembly.KHH      +  vectorised_matrices.KHH*Integration_weight;
    element_assembly.KHJ        =  element_assembly.KHJ      +  vectorised_matrices.KHJ*Integration_weight;
    element_assembly.KHSigmaH   =  element_assembly.KHSigmaH +  vectorised_matrices.KHSigmaH*Integration_weight;
    
    element_assembly.KJJ        =  element_assembly.KJJ      +  vectorised_matrices.KJJ*Integration_weight;
    element_assembly.KJSigmaJ   =  element_assembly.KJSigmaJ +  vectorised_matrices.KJSigmaJ*Integration_weight;
end
%--------------------------------------------------------------------------
% Static condensation procedure in order to get the equivalent
% stiffness matrices and residual vectors
%--------------------------------------------------------------------------
element_assembly   =  ResidualStiffnessStaticCondensFHJ(element_assembly);





