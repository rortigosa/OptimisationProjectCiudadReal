% %--------------------------------------------------------------------------
% %--------------------------------------------------------------------------
% %
% % This function computes the elemental residual vectors and stiffness
% % matrices for the formulation with fields: x-phi-p
% % 
% %--------------------------------------------------------------------------
% %--------------------------------------------------------------------------
% 
% function asmb          =  ResidualStiffnessElectroBoundaryBEM(inode,iedge,dim,mesh,fem,solution,quadrature,vectorisation)
% 
% 
% %--------------------------------------------------------------------------
% % Initialise assembled residuals per element
% %--------------------------------------------------------------------------
% asmb                   =  ElementResidualInitialisationFormulationBoundaryBEM(dim,mesh);
% %--------------------------------------------------------------------------
% % Find one of the elements that xprime belongs to and its local numbering
% % within that element 
% %--------------------------------------------------------------------------
% switch fem.degree.q
%     case 0
% q_elem                =  inode;        
% local_node            =  1;
% xprime                =  mesh.surface.q.nodes(:,inode);
%     otherwise
% connectivity          =  mesh.surface.q.connectivity;
% q_elem                =  ceil(find(connectivity==inode)/dim);
% local_node            =  find(mesh.surface.q.connectivity(:,q_elem(1))==inode);
% xprime_elem           =  solution.x.Lagrangian_X(:,mesh.surface.x.boundary_edges(:,q_elem(1)));
% xprime                =  VectorFEMInterpolation(1,fem.surface.nodes.phi.N_q(:,local_node(1)),xprime_elem);
% end
% %--------------------------------------------------------------------------
% % Detecting element with singularity
% %--------------------------------------------------------------------------
% if q_elem(1)==iedge
%    ngauss             =  size(quadrature.surface.BEM_FEM.sing.Chi,1);
%    fem_BEM_FEM        =  fem.surface.BEM_FEM.sing;
%    quad_BEM_FEM       =  quadrature.surface.BEM_FEM.sing;
%    Bx_matrix          =  vectorisation.Bx_matrix_boundary_BEM_singular;
%    vector2matrix      =  vectorisation.vector2matrix_rowwise_Gauss_points_boundary_BEM_singular;   
% else
%    ngauss             =  size(quadrature.surface.BEM_FEM.Chi,1);
%    fem_BEM_FEM        =  fem.surface.BEM_FEM;
%    quad_BEM_FEM       =  quadrature.surface.BEM_FEM;
%    Bx_matrix          =  vectorisation.Bx_matrix_boundary_BEM;
%    vector2matrix      =  vectorisation.vector2matrix_rowwise_Gauss_points_boundary_BEM;   
% end
% %--------------------------------------------------------------------------
% % Coordinate of the collocation point and the Gauss points in the boundary
% %--------------------------------------------------------------------------
% xedge                 =  solution.x.Lagrangian_X(:,mesh.surface.x.boundary_edges(:,iedge));
% xGauss                =  VectorFEMInterpolation(ngauss,fem_BEM_FEM.x.N,xedge);
% %--------------------------------------------------------------------------
% % Distance between xGauss and xprime 
% %--------------------------------------------------------------------------
% r                     =  repmat(xprime,1,size(xGauss,2)) - xGauss;
% %r                    =  xGauss - repmat(xprime,1,size(xGauss,2));
% r_norm                =  VectorNorm(r);
% r(:,r_norm<1e-6)      =  1e-6;
% r_norm                =  VectorNorm(r);
% %--------------------------------------------------------------------------
% % Test functions in BEM 
% %--------------------------------------------------------------------------
% V                     =  LaplaceFundamentalSolution(dim,r_norm);
% dVdx                  =  DiffLaplaceFundamentalSolution(dim,r,r_norm);
% %--------------------------------------------------------------------------
% % Electric potential 
% %--------------------------------------------------------------------------
% phiedge               =  solution.phi(mesh.surface.phi.boundary_edges(:,iedge));
% phiGauss              =  ScalarFEMInterpolation(fem_BEM_FEM.phi.N,phiedge);
% phiprime_elem         =  solution.phi(mesh.surface.phi.boundary_edges(:,q_elem(1)));
% phiprime              =  ScalarFEMInterpolation(fem.surface.nodes.phi.N_q(:,local_node(1)),phiprime_elem);
% %--------------------------------------------------------------------------
% % Obtain the value of the flux field q0
% %--------------------------------------------------------------------------
% q0                    =  ScalarFEMInterpolation(fem_BEM_FEM.q.N,solution.q(mesh.surface.q.connectivity(:,iedge)));
% %--------------------------------------------------------------------------
% % Obtain gradients of kinematics and electrical variables
% %--------------------------------------------------------------------------
% volume_element        =  mesh.surface.phi.volume_elements(:,iedge);
% [kinematics,DN_X_x]   =  KinematicsFunctionSurface(dim,...
%                           solution.x.Eulerian_x(:,mesh.surface.x.boundary_edges(:,iedge)),...
%                           solution.x.Lagrangian_X(:,mesh.surface.x.boundary_edges(:,iedge)),...
%                           solution.x.Lagrangian_X(:,mesh.volume.x.connectivity(:,volume_element)),...
%                           fem_BEM_FEM.x.N,fem_BEM_FEM.x.DN_chi);                                         
% 
% %H_vectorisedT        =  reshape(permute(kinematics.H,[2 1 3]),1,mesh.dim^2,[]);                                         
% HN                    =  kinematics.Normal_vector;
% %HN_norm              =  VectorNorm(HN);
% %--------------------------------------------------------------------------
% % Matrix BF   
% %--------------------------------------------------------------------------
% BF                    =  BMatrix(ngauss,dim,size(mesh.surface.x.boundary_edges,1),DN_X_x,...
%                                  Bx_matrix.LHS_indices,Bx_matrix.RHS_indices);
% %--------------------------------------------------------------------------
% % Required vectorisations 
% %--------------------------------------------------------------------------
% N_matrix              =  Vector2MatrixVectorisation(kinematics.Normal_vector,ngauss,vector2matrix);
% %N_matrixT            =  permute(N_matrix,[2 1 3]);
% QF                    =  QMatrixComputation(kinematics.F,dim,ngauss);
% Nx_vectorised         =  fem_BEM_FEM.x.N_vectorised;
% %--------------------------------------------------------------------------
% % Residuals 
% %--------------------------------------------------------------------------
% for igauss=1:ngauss
%     %----------------------------------------------------------------------
%     % Integration weight
%     %----------------------------------------------------------------------
%     Int_weigth        =  (kinematics.DX_chi_Jacobian(igauss))*quad_BEM_FEM.W_v(igauss);
%     %----------------------------------------------------------------------
%     % Residual for q.
%     %----------------------------------------------------------------------
%     vector1           =  (phiGauss(igauss) + phiprime)*(dVdx(:,igauss)'*HN(:,igauss));
%     vector2           =  -V(igauss)*q0(igauss);
%     asmb.Tq           =  asmb.Tq   +  (vector1 + vector2)*Int_weigth;
% end 
%      
% %--------------------------------------------------------------------------
% % Stiffness matrices 
% %--------------------------------------------------------------------------
% for igauss=1:ngauss
%     %----------------------------------------------------------------------
%     % Integration weight
%     %----------------------------------------------------------------------
%     Int_weigth        =  (kinematics.DX_chi_Jacobian(igauss))*quad_BEM_FEM.W_v(igauss);
%     %----------------------------------------------------------------------
%     % Vectorisation of stiffness matrices Kqx
%     %----------------------------------------------------------------------
%     vector            =  N_matrix(:,:,igauss)*QF(:,:,igauss)*BF(:,:,igauss);
%     Kqx               =  (phiGauss(igauss) + phiprime)*dVdx(:,igauss)'*vector;
%     %----------------------------------------------------------------------
%     % Vectorisation of stiffness matrices Kqphi
%     %----------------------------------------------------------------------
%     Kqphi             =  (dVdx(:,igauss)'*HN(:,igauss))*fem_BEM_FEM.phi.N(:,igauss)';
%     Kqphiprime        =  (dVdx(:,igauss)'*HN(:,igauss))*fem.surface.nodes.phi.N_q(:,local_node(1))';
%     %----------------------------------------------------------------------
%     % Vectorisation of stiffness matrices Kqq
%     %----------------------------------------------------------------------
%     Kqq               =  -V(igauss)*fem_BEM_FEM.q.N(:,igauss)';
%     %----------------------------------------------------------------------
%     % Stiffness matrices
%     %----------------------------------------------------------------------
%     asmb.Kqx          =  asmb.Kqx        +  Kqx*Int_weigth;
%     asmb.Kqphi        =  asmb.Kqphi      +  Kqphi*Int_weigth;
%     asmb.Kqq          =  asmb.Kqq        +  Kqq*Int_weigth; 
%     asmb.Kqphiprime   =  asmb.Kqphiprime +  Kqphiprime*Int_weigth; 
% end
% 





%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the elemental residual vectors and stiffness
% matrices for the formulation with fields: x-phi-p
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function asmb          =  ResidualStiffnessElectroBoundaryBEM(inode,iedge,dim,mesh,fem,solution,quadrature,vectorisation)


%--------------------------------------------------------------------------
% Initialise assembled residuals per element
%--------------------------------------------------------------------------
asmb                   =  ElementResidualInitialisationFormulationBoundaryBEM(dim,mesh);
%--------------------------------------------------------------------------
% Find one of the elements that xprime belongs to and its local numbering
% within that element 
%--------------------------------------------------------------------------
switch fem.degree.q 
    case 0
q_elem                =  inode;        
local_node            =  1;
%xprime                =  mesh.surface.q.nodes(:,inode);
%xprime                =  solution.x.Eulerian_x(:,inode);
xprime_elem           =  solution.x.Eulerian_x(:,mesh.surface.x.boundary_edges(:,q_elem(1)));
xprime                =  VectorFEMInterpolation(1,fem.surface.nodes.x.N_q(:,local_node(1)),xprime_elem);
    otherwise
connectivity          =  mesh.surface.q.connectivity;
q_elem                =  ceil(find(connectivity==inode)/dim);
local_node            =  find(mesh.surface.q.connectivity(:,q_elem(1))==inode);
xprime_elem           =  solution.x.Eulerian_x(:,mesh.surface.x.boundary_edges(:,q_elem(1)));
xprime                =  VectorFEMInterpolation(1,fem.surface.nodes.x.N_q(:,local_node(1)),xprime_elem);
end
%--------------------------------------------------------------------------
% Detecting element with singularity
%--------------------------------------------------------------------------
if q_elem(1)==iedge
   ngauss             =  size(quadrature.surface.BEM_FEM.sing.Chi,1);
   fem_BEM_FEM        =  fem.surface.BEM_FEM.sing;
   quad_BEM_FEM       =  quadrature.surface.BEM_FEM.sing;
   Bx_matrix          =  vectorisation.Bx_matrix_boundary_BEM_singular;
   vector2matrix      =  vectorisation.vector2matrix_rowwise_Gauss_points_boundary_BEM_singular;   
else
   ngauss             =  size(quadrature.surface.BEM_FEM.Chi,1);
   fem_BEM_FEM        =  fem.surface.BEM_FEM;
   quad_BEM_FEM       =  quadrature.surface.BEM_FEM;
   Bx_matrix          =  vectorisation.Bx_matrix_boundary_BEM;
   vector2matrix      =  vectorisation.vector2matrix_rowwise_Gauss_points_boundary_BEM;   
end
%--------------------------------------------------------------------------
% Coordinate of the collocation point and the Gauss points in the boundary
%--------------------------------------------------------------------------
xedge                 =  solution.x.Eulerian_x(:,mesh.surface.x.boundary_edges(:,iedge));
xGauss                =  VectorFEMInterpolation(ngauss,fem_BEM_FEM.x.N,xedge);
%--------------------------------------------------------------------------
% Distance between xGauss and xprime 
%--------------------------------------------------------------------------
r                     =  repmat(xprime,1,size(xGauss,2)) - xGauss;
%r                    =  xGauss - repmat(xprime,1,size(xGauss,2));
r_norm                =  VectorNorm(r);
r(:,r_norm<1e-6)      =  1e-6;
r_norm                =  VectorNorm(r);
%--------------------------------------------------------------------------
% Test functions in BEM 
%--------------------------------------------------------------------------
V                     =  LaplaceFundamentalSolution(dim,r_norm);
dVdx                  =  DiffLaplaceFundamentalSolution(dim,r,r_norm);
d2Vdxdx               =  DiffDiffLaplaceFundamentalSolution(dim,r,r_norm);
%--------------------------------------------------------------------------
% Electric potential 
%--------------------------------------------------------------------------
phiedge               =  solution.phi(mesh.surface.phi.boundary_edges(:,iedge));
phiGauss              =  ScalarFEMInterpolation(fem_BEM_FEM.phi.N,phiedge);
phiprime_elem         =  solution.phi(mesh.surface.phi.boundary_edges(:,q_elem(1)));
phiprime              =  ScalarFEMInterpolation(fem.surface.nodes.phi.N_q(:,local_node(1)),phiprime_elem);
%--------------------------------------------------------------------------
% Obtain the value of the flux field q0
%--------------------------------------------------------------------------
q0                    =  ScalarFEMInterpolation(fem_BEM_FEM.q.N,solution.q(mesh.surface.q.connectivity(:,iedge)));
%--------------------------------------------------------------------------
% Obtain gradients of kinematics and electrical variables
%--------------------------------------------------------------------------
volume_element        =  mesh.surface.phi.volume_elements(:,iedge);
[kinematics,DN_X_x]   =  KinematicsFunctionSurface(dim,...
                          solution.x.Eulerian_x(:,mesh.surface.x.boundary_edges(:,iedge)),...
                          solution.x.Lagrangian_X(:,mesh.surface.x.boundary_edges(:,iedge)),...
                          solution.x.Lagrangian_X(:,mesh.volume.x.connectivity(:,volume_element)),...
                          fem_BEM_FEM.x.N,fem_BEM_FEM.x.DN_chi);                                         

%H_vectorisedT        =  reshape(permute(kinematics.H,[2 1 3]),1,mesh.dim^2,[]);                                         
HN                    =  MatrixVectorMultiplication(dim,ngauss,kinematics.H,kinematics.Normal_vector);
%HN_norm              =  VectorNorm(HN);
%--------------------------------------------------------------------------
% Matrix BF   
%--------------------------------------------------------------------------
BF                    =  BMatrix(ngauss,dim,size(mesh.surface.x.boundary_edges,1),DN_X_x,...
                                 Bx_matrix.LHS_indices,Bx_matrix.RHS_indices);
%--------------------------------------------------------------------------
% Required vectorisations 
%--------------------------------------------------------------------------
N_matrix              =  Vector2MatrixVectorisation(kinematics.Normal_vector,ngauss,vector2matrix);
%N_matrixT            =  permute(N_matrix,[2 1 3]);
QF                    =  QMatrixComputation(kinematics.F,dim,ngauss);
Nx_vectorised         =  fem_BEM_FEM.x.N_vectorised;
%--------------------------------------------------------------------------
% Residuals 
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Int_weigth        =  (kinematics.DX_chi_Jacobian(igauss))*quad_BEM_FEM.W_v(igauss);
    %----------------------------------------------------------------------
    % Residual for q.
    %----------------------------------------------------------------------
    vector1           =  (phiGauss(igauss) + phiprime)*(dVdx(:,igauss)'*HN(:,igauss));
    vector2           =  -V(igauss)*q0(igauss);
    asmb.Tq           =  asmb.Tq   +  (vector1 + vector2)*Int_weigth;
end 
     
%--------------------------------------------------------------------------
% Stiffness matrices 
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Int_weigth        =  (kinematics.DX_chi_Jacobian(igauss))*quad_BEM_FEM.W_v(igauss);
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices Kqx
    %----------------------------------------------------------------------
    vector            =  N_matrix(:,:,igauss)*QF(:,:,igauss)*BF(:,:,igauss);
    Kqx1              =  (phiGauss(igauss) + phiprime)*HN(:,igauss)'*d2Vdxdx(:,:,igauss)*Nx_vectorised(:,:,igauss);
    Kqx2              =  (phiGauss(igauss) + phiprime)*dVdx(:,igauss)'*vector;
    Kqx3              =  -q0(igauss)*(dVdx(:,igauss)'*Nx_vectorised(:,:,igauss));
    Kqx               =  (Kqx1 + Kqx2 + Kqx3);
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices Kqphi
    %----------------------------------------------------------------------
    Kqphi             =  (dVdx(:,igauss)'*HN(:,igauss))*fem_BEM_FEM.phi.N(:,igauss)';
    Kqphiprime        =  (dVdx(:,igauss)'*HN(:,igauss))*fem.surface.nodes.phi.N_q(:,local_node(1))';
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices Kqq
    %----------------------------------------------------------------------
    Kqq               =  -V(igauss)*fem_BEM_FEM.q.N(:,igauss)';
    %----------------------------------------------------------------------
    % Stiffness matrices
    %----------------------------------------------------------------------
    asmb.Kqx          =  asmb.Kqx        +  Kqx*Int_weigth;
    asmb.Kqphi        =  asmb.Kqphi      +  Kqphi*Int_weigth;
    asmb.Kqq          =  asmb.Kqq        +  Kqq*Int_weigth; 
    asmb.Kqphiprime   =  asmb.Kqphiprime +  Kqphiprime*Int_weigth; 
end






