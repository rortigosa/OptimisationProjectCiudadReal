function Kxx = ResidualStiffnessMatlabVersion(ielem,dim,xelem,DNX,ngauss,mat_info,B_LHS,B_RHS,n_node_elem,Weight,DetDXChi)

kinematics         =  KinematicsFunctionVolume(dim,xelem,DNX);  
%--------------------------------------------------------------------------
% First and second derivatives of the model for the solid
%--------------------------------------------------------------------------
mat_info           =  GetDerivativesModelMechanics(ielem,dim,ngauss,kinematics.F,kinematics.H,kinematics.J,...
                                                       mat_info,'Mooney_Rivlin');
%--------------------------------------------------------------------------
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
BF                 =  BMatrix(ngauss,dim,n_node_elem,...
                              DNX,B_LHS,B_RHS);
%BF(B_LHS)   =  DNX(B_RHS);
                         
%--------------------------------------------------------------------------
% Q matrices arising from the linearisation of H: DH[].SigmaH = Q*DF[]. and
%--------------------------------------------------------------------------
QF                 =  QMatrixComputation(kinematics.F,dim,ngauss);
QSigmaH            =  QMatrixComputation(mat_info.derivatives.DU.DUDH,dim,ngauss);    
if dim==2
   QSigmaH         =  QSigmaH*0;
end
%--------------------------------------------------------------------------
% Integration weights
%--------------------------------------------------------------------------
IntWeight          =  Weight.*DetDXChi;
Kxx                =  zeros(n_node_elem*dim);
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices
    %----------------------------------------------------------------------
    vect_mat       =  VectorisedStiffnessMatricesU(igauss,BF(:,:,igauss),...
                                               mat_info.derivatives.D2U,...
                                               mat_info.derivatives.DU,...
                                               QF(:,:,igauss),QSigmaH(:,:,igauss),...
                                               kinematics.H(:,:,igauss));
%     %----------------------------------------------------------------------
%     % Residual and stiffness matrices
%     %----------------------------------------------------------------------
%     asmb.Tx        =  asmb.Tx   +  density*(BF(:,:,igauss)'*Piola_vect(:,igauss))*IntWeight(igauss);
     Kxx       =  Kxx  +  vect_mat.Kxx*IntWeight(igauss);
    %----------------------------------------------------------------------
    % Residual and stiffness matrices in the void
    %----------------------------------------------------------------------
%    asmb.Tx        =  asmb.Tx   +  (1 - density)*(vect_mat_void.Kxx*u(:))*IntWeight(igauss);
%    Kxx       =  Kxx  +  *vect_mat_void.Kxx*IntWeight(igauss);
end




