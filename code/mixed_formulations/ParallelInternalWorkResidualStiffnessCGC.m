%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the elemental residual vectors and stiffness
% matrices for the formulation with fields: x-phi-p
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function element_assembly     =  ParallelInternalWorkResidualStiffnessCGC(ielem,quadrature,solution,geometry,mesh,fem,...
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
Gx                            =  MatrixMatrixMultiplication(geometry.dim,ngauss,permute(kinematics.H,[2 1 3]),kinematics.H);
Cx_vectorised                 =  Matrix2Vector(geometry.dim^2,ngauss,Cx);
Gx_vectorised                 =  Matrix2Vector(geometry.dim^2,ngauss,Gx);
cx                            =  kinematics.J.*kinematics.J;
%--------------------------------------------------------------------------
% Obtain the fields (F,H,J,D0,d) and (SigmaF,SigmaH,SigmaJ,Sigmad) at each
% Gauss points
%--------------------------------------------------------------------------
[C,Cvectorised,G,Gvectorised,c,...
 SigmaC,SigmaCvectorised,SigmaG,...
 SigmaGvectorised,Sigmac]     =  CGCFEMFieldsInterpolation(ielem,geometry.dim,ngauss,fem,solution,...
                                                   mesh.volume.C,mesh.volume.G,mesh.volume.c);
%--------------------------------------------------------------------------
% First and second derivatives of the model. 
%--------------------------------------------------------------------------
material_information          =  GetDerivativesModelMechanicsC(ielem,geometry.dim,ngauss,C,G,c,material_information);
DUDC_vectorised               =  reshape(permute(material_information.derivatives.DU.DUDC,[2 1 3]),geometry.dim^2,[]);
DUDG_vectorised               =  reshape(permute(material_information.derivatives.DU.DUDG,[2 1 3]),geometry.dim^2,[]);
DUDc                          =  material_information.derivatives.DU.DUDc;
%--------------------------------------------------------------------------
% First Piola-Kirchhoff stress tensor.        
%--------------------------------------------------------------------------
S                             =  FirstPiolaKirchhoffStressTensorU(ngauss,geometry.dim,Cx,Gx,...
                                                                SigmaC,SigmaG,Sigmac);
S                             =  2*S;
S_vectorised                  =  Matrix2Vector(geometry.dim^2,ngauss,S);
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
% Obtain S vectorised for the geometric term
%--------------------------------------------------------------------------
Sgeom                         =  VectorisationSGeom(geometry.dim,ngauss,S,vectorisation.S);
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
                                (BC(:,:,igauss)'*S_vectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for F.
    %----------------------------------------------------------------------
    element_assembly.TC       =  element_assembly.TC   +  ...
                                 fem.volume.bilinear.C.N_vectorised(:,:,igauss)'*(DUDC_vectorised(:,igauss) - SigmaCvectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for H.
    %----------------------------------------------------------------------
    element_assembly.TG       =  element_assembly.TG   +  ...
                                 fem.volume.bilinear.G.N_vectorised(:,:,igauss)'*(DUDG_vectorised(:,igauss) - SigmaGvectorised(:,igauss))*Integration_weight;
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
                                 fem.volume.bilinear.G.N_vectorised(:,:,igauss)'*(Gx_vectorised(:,igauss) - Gvectorised(:,igauss))*Integration_weight;
    %----------------------------------------------------------------------
    % Residual for SigmaJ.
    %----------------------------------------------------------------------
    element_assembly.TSigmac  =  element_assembly.TSigmac  +  ...
                                 fem.volume.bilinear.c.N(:,igauss)*(cx(igauss) - c(igauss))*Integration_weight;
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
                                                material_information.derivatives.D2U,Sgeom(:,:,igauss));
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





