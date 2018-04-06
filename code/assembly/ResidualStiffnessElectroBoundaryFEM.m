%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the elemental residual vectors and stiffness
% matrices for the formulation with fields: x-phi-p
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function asmb       =  ResidualStiffnessElectroBoundaryFEM(iedge,dim,quadrature,fem,mesh,solution,...
                                                                   vectorisation,mat_info)
%--------------------------------------------------------------------------
% Number of Gauss points
%--------------------------------------------------------------------------
ngauss              =  size(quadrature.surface.bilinear.Chi,1);
%--------------------------------------------------------------------------
% Initialise residuals and stiffness matrices for each element
%--------------------------------------------------------------------------
asmb                =  ElementResidualMatricesInitialisationElectroBoundary(dim,mesh);
%--------------------------------------------------------------------------
% Permittivity of vaccum
%--------------------------------------------------------------------------
e0                  =  mat_info.vacuum_electric_permittivity;
%--------------------------------------------------------------------------
% Obtain the value of the flux field q0
%--------------------------------------------------------------------------
q0                  =  ScalarFEMInterpolation(fem.surface.bilinear.q.N,solution.q(mesh.surface.q.connectivity(:,iedge)));
%---------------------------------------------------------- ----------------
% Obtain gradients of kinematics and electrical variables
%--------------------------------------------------------------------------
[kinematics,DN_X_x] =  KinematicsFunctionSurface(dim,solution.x.Eulerian_x(:,mesh.surface.x.boundary_edges(:,iedge)),...
                                solution.x.Lagrangian_X(:,mesh.surface.x.boundary_edges(:,iedge)),...
                                solution.x.Lagrangian_X(:,mesh.volume.x.connectivity(:,mesh.surface.x.volume_elements(iedge))),...
                                fem.surface.bilinear.x.N,fem.surface.bilinear.x.DN_chi);                                         
[E0,DN_X_phi]       =  ElectricFieldSurfaceComputation(dim,solution.phi(mesh.surface.x.boundary_edges(:,iedge)),...
                                        fem.surface.bilinear.phi.DN_chi,kinematics.DX_chi);
H_vectorised        =  reshape(permute(kinematics.H,[2 1 3]),dim^2,1,[]);                                         
H_vectorisedT       =  reshape(H_vectorised,1,dim^2,[]);                                         
HN                  =  MatrixVectorMultiplication(dim,ngauss,kinematics.H,kinematics.Normal_vector);
HN_norm             =  VectorNorm(HN);
%--------------------------------------------------------------------------
% Spatial electric field 
%--------------------------------------------------------------------------
E                   =  MatrixVectorMultiplication(dim,ngauss,kinematics.FminusT,E0);
%--------------------------------------------------------------------------
% Matrix BF   
%--------------------------------------------------------------------------
BF                  =  BMatrix(ngauss,dim,size(mesh.surface.x.boundary_edges,1),DN_X_x,...
                               vectorisation.Bx_matrix_boundary.LHS_indices,...
                               vectorisation.Bx_matrix_boundary.RHS_indices);
%--------------------------------------------------------------------------
% Required vectorisations 
%--------------------------------------------------------------------------
N_matrix            =  Vector2MatrixVectorisation(kinematics.Normal_vector,ngauss,vectorisation.vector2matrix_rowwise_Gauss_points_boundary);
N_matrixT           =  permute(N_matrix,[2 1 3]);
E0_matrix           =  Vector2MatrixVectorisation(E0,ngauss,vectorisation.vector2matrix_rowwise_Gauss_points_boundary);
E0_matrixT          =  permute(E0_matrix,[2 1 3]);
Finv                =  permute(kinematics.FminusT,[2 1 3]);
invCE0              =  MatrixVectorMultiplication(dim,ngauss,Finv,E);
QF                  =  QMatrixComputation(kinematics.F,dim,ngauss);
Nx_vectorised       =  fem.surface.bilinear.x.N_vectorised;
Nx_vectorisedT      =  permute(Nx_vectorised,[2 1 3]);
HE0                 =  MatrixVectorMultiplication(dim,ngauss,kinematics.H,E0);
%--------------------------------------------------------------------------
% Residuals 
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Int_weight      =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.surface.bilinear.W_v(igauss);
    %----------------------------------------------------------------------
    % Residual conservation of linear momentum.
    %----------------------------------------------------------------------
    Tx1             =  e0*q0(igauss)*E(:,igauss);
    Tx2             =  e0/2*(E(:,igauss)'*E(:,igauss) - (q0(igauss)/HN_norm(igauss))^2)*HN(:,igauss);    
    asmb.Tx         =  asmb.Tx   +  Nx_vectorisedT(:,:,igauss)*(Tx1 + Tx2)*Int_weight;
    %----------------------------------------------------------------------
    % Residual Gauss' law.- (D0'*DN_X*W*J_t)'
    %----------------------------------------------------------------------
    asmb.Tphi       =  asmb.Tphi   +  e0*(q0(igauss)*fem.surface.bilinear.phi.N(:,igauss))*Int_weight;
end      
%--------------------------------------------------------------------------
% Stiffness matrices 
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Int_weight      =  (kinematics.DX_chi_Jacobian(igauss))*quadrature.surface.bilinear.W_v(igauss);
    BH              =  QF(:,:,igauss)*BF(:,:,igauss);    
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices Kxx
    %----------------------------------------------------------------------
    vector1         =  Nx_vectorisedT(:,:,igauss)*E0_matrix(:,:,igauss)*H_vectorised(:,:,igauss);
    vector2         =  H_vectorisedT(:,:,igauss)*BF(:,:,igauss);    
    Kxx1            =  (-e0*q0(igauss)/kinematics.J(igauss)^2)*(vector1*vector2);    
    Kxx2            =  (e0*q0(igauss)/kinematics.J(igauss))*(Nx_vectorisedT(:,:,igauss)*E0_matrix(:,:,igauss)*BH);
    
    vector3         =  Nx_vectorisedT(:,:,igauss)*N_matrix(:,:,igauss)*H_vectorised(:,:,igauss);
    vector4         =  H_vectorisedT(:,:,igauss)*N_matrixT(:,:,igauss)*N_matrix(:,:,igauss)*BH;
    Kxx3            =  (e0*q0(igauss)^2/HN_norm(igauss)^4)*(vector3*vector4);
    vector5         =  (Nx_vectorisedT(:,:,igauss)*N_matrix(:,:,igauss)*BH);
    Kxx4            =  -(e0*q0(igauss)^2/HN_norm(igauss)^2)/2*vector5;
    
    Kxx5            =  -e0/(kinematics.J(igauss)^3)*(HE0(:,igauss)'*HE0(:,igauss))*(vector3*vector2);
    vector6         =  H_vectorisedT(:,:,igauss)*E0_matrixT(:,:,igauss)*E0_matrix(:,:,igauss)*BH;
    Kxx6            =  e0/(kinematics.J(igauss)^2)*(vector3*vector6);
    Kxx7            =  e0/(2*kinematics.J(igauss)^2)*(HE0(:,igauss)'*HE0(:,igauss))*vector5;
        
    Kxx             =  (Kxx1 + Kxx2 + Kxx3 + Kxx4 + Kxx5 + Kxx6 + Kxx7);

    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices Kxphi
    %----------------------------------------------------------------------
    vector7         =  Nx_vectorisedT(:,:,igauss)*kinematics.H(:,:,igauss)*DN_X_phi(:,:,igauss);
    Kxphi1          =  (-e0*q0(igauss)/kinematics.J(igauss))*vector7;
    
    vector8         =  (Nx_vectorisedT(:,:,igauss)*HN(:,igauss));
    vector9         =  invCE0(:,igauss)'*DN_X_phi(:,:,igauss);
    Kxphi2          =  (-e0)*(vector8*vector9);

    Kxphi           =  (Kxphi1 + Kxphi2);
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices Kxq
    %----------------------------------------------------------------------
    Kxq1            =  e0*(Nx_vectorisedT(:,:,igauss)*E(:,igauss))*fem.surface.bilinear.q.N(:,igauss)';
    Kxq2            =  -e0*q0(igauss)/HN_norm(igauss)^2*(Nx_vectorisedT(:,:,igauss)*HN(:,igauss))*fem.surface.bilinear.q.N(:,igauss)';
    Kxq             =  (Kxq1 + Kxq2);
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices Kphiq
    %----------------------------------------------------------------------
    Kphiq           =  e0*(fem.surface.bilinear.phi.N(:,igauss)*fem.surface.bilinear.q.N(:,igauss)');
    %----------------------------------------------------------------------
    % Stiffness matrices
    %----------------------------------------------------------------------
    asmb.Kxx      =  asmb.Kxx      +  Kxx*Int_weight;
    asmb.Kxphi    =  asmb.Kxphi    +  Kxphi*Int_weight;
    asmb.Kxq      =  asmb.Kxq      +  Kxq*Int_weight;    
    asmb.Kphiq    =  asmb.Kphiq    +  Kphiq*Int_weight;
end


