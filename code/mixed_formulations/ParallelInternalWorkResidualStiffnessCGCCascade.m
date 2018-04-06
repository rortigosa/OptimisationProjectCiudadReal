%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the elemental residual vectors and stiffness
% matrices for the formulation with fields: x-phi-p
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function element_assembly     =  ParallelInternalWorkResidualStiffnessCGCCascade(ielem,quadrature,solution,geometry,mesh,fem,...
                                                                                           vectorisation,material_information)

%--------------------------------------------------------------------------
% Number of Gauss points
%--------------------------------------------------------------------------
ngauss                        =  size(quadrature.volume.bilinear.Chi,1);
%--------------------------------------------------------------------------
% Initialise assembled residuals per element 
%--------------------------------------------------------------------------
element_assembly              =  ElementResidualMatricesInitialisationCGC(geometry,mesh);        
%--------------------------------------------------------------------------
% Obtain gradients of kinematics and electrical variables
%--------------------------------------------------------------------------
[kinematics,DN_X_x]           =  KinematicsFunctionVolume(geometry.dim,...
                                                          solution.x.Eulerian_x(:,mesh.volume.x.connectivity(:,ielem)),...
                                                          solution.x.Lagrangian_X(:,mesh.volume.x.connectivity(:,ielem)),...
                                                          fem.volume.bilinear.x.DN_chi);
Cx                            =  MatrixMatrixMultiplication(geometry.dim,ngauss,permute(kinematics.F,[2 1 3]),kinematics.F);
Cx_vectorised                 =  Matrix2Vector(geometry.dim^2,ngauss,Gx);
%--------------------------------------------------------------------------
% Obtain the fields (F,H,J,D0,d) and (SigmaF,SigmaH,SigmaJ,Sigmad) at each
% Gauss points
%--------------------------------------------------------------------------
[C,Cvectorised,G,Gvectorised,c,...
 SigmaC,SigmaCvectorised,SigmaG,...
 SigmaGvectorised,Sigmac]     =  CGCFEMFieldsInterpolation(ielem,geometry.dim,ngauss,fem,solution,...
                                                   mesh.volume.C,mesh.volume.G,mesh.volume.c);
%--------------------------------------------------------------------------
% Compute G based on C:  G  =  0.5*C x C
%--------------------------------------------------------------------------
G_C                           =  CofactorGauss(geometry.dim,ngauss,C);  %  Cofactor of C field
G_C_vectorised                =  Matrix2Vector(geometry.dim^2,ngauss,G_C);
%--------------------------------------------------------------------------
% Compute c based on C and G:  c  =  1/3*(C : G)
%--------------------------------------------------------------------------
CG                            =  MatrixMatrixContraction(ngauss,C,G);
c_CG                          =  1/3*CG;
%--------------------------------------------------------------------------
% First and second derivatives of the model. 
%--------------------------------------------------------------------------
material_information          =  GetDerivativesModelMechanicsC(ielem,geometry.dim,ngauss,C,G,c,material_information);
DUDC_vectorised               =  reshape(permute(material_information.derivatives.DU.DUDC,[2 1 3]),geometry.dim^2,[]);
DUDG_vectorised               =  reshape(permute(material_information.derivatives.DU.DUDG,[2 1 3]),geometry.dim^2,[]);
DUDc                          =  material_information.derivatives.DU.DUDc;
%--------------------------------------------------------------------------
% Matrix BF   
%--------------------------------------------------------------------------
BC                            =  BCMatrix(ngauss,geometry.dim,mesh.volume.x.n_node_elem,...
                                         kinematics.F,DN_X_x,vectorisation.BC);
%--------------------------------------------------------------------------
% Q matrices arising from the linearisation of H: DH[].SigmaH = Q*DF[]. and
%--------------------------------------------------------------------------
QC                            =  QMatrixComputation(Cx,geometry.dim,ngauss);
QSigmaG                       =  QMatrixComputation(material_information.derivatives.DU.DUDG,geometry.dim,ngauss);    
%--------------------------------------------------------------------------
% New tensors featuring in the residuals
%--------------------------------------------------------------------------
SigmaGxC                      =  JavierDoubleCrossProductGauss(geometry.dim,ngauss,SigmaG,C);
SigmaGxCvectorised            =  Matrix2Vector(geometry.dim,ngauss,SigmaGxC);
SigmacG                       =  MatrixScalarMultiplication(geometry.dim,ngauss,G,Sigmac);
SigmacGvectorised             =  Matrix2Vector(geometry.dim,ngauss,SigmacG);
SigmacC                       =  MatrixScalarMultiplication(geometry.dim,ngauss,C,Sigmac);
SigmacCvectorised             =  Matrix2Vector(geometry.dim,ngauss,SigmacC);
%--------------------------------------------------------------------------
% Obtain SigmaC vectorised for the geometric term
%--------------------------------------------------------------------------
Sgeom                         =  VectorisationSGeom(geometry.dim,ngauss,SigmaC,vectorisation.S);
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
                                (BC(:,:,igauss)'*SigmaCvectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for F.
    %----------------------------------------------------------------------
    element_assembly.TC       =  element_assembly.TC   +  ...
                                 fem.volume.bilinear.C.N_vectorised(:,:,igauss)'*(DUDC_vectorised(:,igauss) -...
                                                                                  SigmaCvectorised(:,igauss) +...
                                                                                  SigmaGxCvectorised(:,igauss) + ...
                                                                                  1/3*SigmacGvectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for H.
    %----------------------------------------------------------------------
    element_assembly.TG       =  element_assembly.TG   +  ...
                                 fem.volume.bilinear.G.N_vectorised(:,:,igauss)'*(DUDG_vectorised(:,igauss) -...
                                                                                  SigmaGvectorised(:,igauss) + ...
                                                                                  1/3*SigmacCvectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for J.
    %----------------------------------------------------------------------
    element_assembly.Tc       =  element_assembly.Tc  +  ...
                                 fem.volume.bilinear.c.N(:,igauss)*(DUDc(igauss) - Sigmac(igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for SigmaF.
    %----------------------------------------------------------------------
    element_assembly.TSigmaC  =  element_assembly.TSigmaC   +  ...
                                 fem.volume.bilinear.C.N_vectorised(:,:,igauss)'*(Cx_vectorised(:,igauss) - Cvectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for SigmaH.
    %----------------------------------------------------------------------
    element_assembly.TSigmaG  =  element_assembly.TSigmaG   +  ...
                                 fem.volume.bilinear.G.N_vectorised(:,:,igauss)'*(G_C_vectorised(:,igauss) - Gvectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for SigmaJ.
    %----------------------------------------------------------------------
    element_assembly.TSigmac  =  element_assembly.TSigmac  +  ...
                                 fem.volume.bilinear.c.N(:,igauss)*(c_CG(igauss) - c(igauss))*Integration_weight;
end      
%--------------------------------------------------------------------------
% Stiffness matrices
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Integration_weight    =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.volume.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices
    %----------------------------------------------------------------------
    vectorised_matrices   =  VectorisedStiffnessMatricesCGC(igauss,BC(:,:,igauss),...
                                                material_information.derivatives.DU.DUDc(igauss),...        
                                                QC(:,:,igauss),QSigmaG(:,:,igauss),...
                                                fem.volume.bilinear,Gx_vectorised(:,igauss),...
                                                material_information.derivatives.D2U,Sgeom);
    %----------------------------------------------------------------------
    % Stiffness matrices
    %----------------------------------------------------------------------
    element_assembly.Kxx        =  element_assembly.Kxx      +  vectorised_matrices.Kxx*Integration_weight;
    element_assembly.KxSigmaC   =  element_assembly.KxSigmaC +  vectorised_matrices.KxSigmaC*Integration_weight;
    element_assembly.KxSigmaG   =  element_assembly.KxSigmaG +  vectorised_matrices.KxSigmaG*Integration_weight;
    element_assembly.KxSigmac   =  element_assembly.KxSigmac +  vectorised_matrices.KxSigmac*Integration_weight;
        
    element_assembly.KCC        =  element_assembly.KCC      +  vectorised_matrices.KCC*Integration_weight;
    element_assembly.KCG        =  element_assembly.KCG      +  vectorised_matrices.KCG*Integration_weight;
    element_assembly.KCc        =  element_assembly.KCc      +  vectorised_matrices.KCc*Integration_weight;
    element_assembly.KCSigmaC   =  element_assembly.KCSigmaC +  vectorised_matrices.KCSigmaC*Integration_weight;
    
    element_assembly.KGG        =  element_assembly.KGG      +  vectorised_matrices.KGG*Integration_weight;
    element_assembly.KGc        =  element_assembly.KGc      +  vectorised_matrices.KGc*Integration_weight;
    element_assembly.KGSigmaG   =  element_assembly.KGSigmaG +  vectorised_matrices.KGSigmaG*Integration_weight;
    
    element_assembly.Kcc        =  element_assembly.Kcc      +  vectorised_matrices.Kcc*Integration_weight;
    element_assembly.KcSigmac   =  element_assembly.KcSigmac +  vectorised_matrices.KcSigmac*Integration_weight;
end
%--------------------------------------------------------------------------
% Static condensation procedure in order to get the equivalent
% stiffness matrices and residual vectors 
%--------------------------------------------------------------------------
element_assembly                =  ResidualStiffnessStaticCondensCGC(element_assembly);





