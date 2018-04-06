%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the elemental residual vectors and stiffness
% matrices for the formulation with fields: x-phi-p
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [asmb,Cont1,Cont2,...
    Cont3,Cont4]    =  ResidualStiffnessElectroBoundaryBEMOnlyElectro(inode,iedge,dim,mesh,fem,solution,quadrature)

%--------------------------------------------------------------------------
% Initialisation of element residuals and stiffness matrices
%--------------------------------------------------------------------------
asmb                 =  ElementResidualInitialisationFormulationBoundaryBEMOnlyElectro(mesh);
%--------------------------------------------------------------------------
% Find one of the elements that xprime belongs to and its local numbering
% within that element 
%--------------------------------------------------------------------------
switch fem.degree.q
    case 0
q_elem               =  inode;        
local_node           =  1;
xprime               =  mesh.surface.q.nodes(:,inode);
    otherwise
connectivity         =  mesh.surface.q.connectivity;
q_elem               =  ceil(find(connectivity==inode)/dim);
local_node           =  find(mesh.surface.q.connectivity(:,q_elem(1))==inode);
xprime_elem          =  solution.x.Lagrangian_X(:,mesh.surface.x.boundary_edges(:,q_elem(1)));
xprime               =  VectorFEMInterpolation(1,fem.surface.nodes.phi.N_q(:,local_node(1)),xprime_elem);
end
%--------------------------------------------------------------------------
% Detecting element with singularity
%--------------------------------------------------------------------------
if q_elem(1)==iedge
   ngauss            =  size(quadrature.surface.BEM_FEM.sing.Chi,1);
   fem_BEM_FEM       =  fem.surface.BEM_FEM.sing;
   quad_BEM_FEM      =  quadrature.surface.BEM_FEM.sing;
else
   ngauss            =  size(quadrature.surface.BEM_FEM.Chi,1);
   fem_BEM_FEM       =  fem.surface.BEM_FEM;
   quad_BEM_FEM      =  quadrature.surface.BEM_FEM;
end
%--------------------------------------------------------------------------
% Coordinate of the collocation point and the Gauss points in the boundary
%--------------------------------------------------------------------------
xedge                =  solution.x.Lagrangian_X(:,mesh.surface.x.boundary_edges(:,iedge));
xGauss               =  VectorFEMInterpolation(ngauss,fem_BEM_FEM.phi.N,xedge);
%--------------------------------------------------------------------------
% Distance between xGauss and xprime 
%--------------------------------------------------------------------------
r                    =  repmat(xprime,1,size(xGauss,2)) - xGauss;
%r                   =  xGauss - repmat(xprime,1,size(xGauss,2));
r_norm               =  VectorNorm(r);
r(:,r_norm<1e-6)     =  1e-6;
r_norm               =  VectorNorm(r);
%--------------------------------------------------------------------------
% Test functions in BEM 
%--------------------------------------------------------------------------
V                    =  LaplaceFundamentalSolution(dim,r_norm);
dVdx                 =  DiffLaplaceFundamentalSolution(dim,r,r_norm);
%--------------------------------------------------------------------------
% Electric potential 
%--------------------------------------------------------------------------
phiedge              =  solution.phi(mesh.surface.phi.boundary_edges(:,iedge));
phiGauss             =  ScalarFEMInterpolation(fem_BEM_FEM.phi.N,phiedge);
phiprime_elem        =  solution.phi(mesh.surface.phi.boundary_edges(:,q_elem(1)));
phiprime             =  ScalarFEMInterpolation(fem.surface.nodes.phi.N_q(:,local_node(1)),phiprime_elem);
%--------------------------------------------------------------------------
% Obtain the value of the flux field q0 
%--------------------------------------------------------------------------
q                    =  ScalarFEMInterpolation(fem_BEM_FEM.q.N,solution.q(mesh.surface.q.connectivity(:,iedge)));
%--------------------------------------------------------------------------
% Obtain gradients of kinematics and electrical variables 
%--------------------------------------------------------------------------
volume_element       =  mesh.surface.phi.volume_elements(:,iedge);
kinematics           =  KinematicsFunctionSurface(dim,...
                          solution.x.Lagrangian_X(:,mesh.surface.phi.boundary_edges(:,iedge)),...
                          solution.x.Lagrangian_X(:,mesh.surface.phi.boundary_edges(:,iedge)),...
                          solution.x.Lagrangian_X(:,mesh.volume.phi.connectivity(:,volume_element)),...
                          fem_BEM_FEM.phi.N,fem_BEM_FEM.phi.DN_chi);                                         
%--------------------------------------------------------------------------
% Residuals 
%--------------------------------------------------------------------------
Cont1                =  0;
Cont2                =  0;
Cont3                =  0;
Cont4                =  0;
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Int_weight       =  (kinematics.DX_chi_Jacobian(igauss))*quad_BEM_FEM.W_v(igauss);
    %----------------------------------------------------------------------
    % Residual for q.
    %----------------------------------------------------------------------
    vector1          =  phiGauss(igauss)*(dVdx(:,igauss)'*kinematics.Normal_vector(:,igauss));
    vector2          =  phiprime*(dVdx(:,igauss)'*kinematics.Normal_vector(:,igauss));
    vector3          =  -V(igauss)*q(igauss);
    Cont1            =  Cont1 + dVdx(:,igauss)'*kinematics.Normal_vector(:,igauss)*Int_weight;
    Cont2            =  Cont2 + V(igauss)*Int_weight;
    Cont3            =  Cont3 + (vector1 + vector2)*Int_weight;
    Cont4            =  Cont4 + vector3*Int_weight;    
    asmb.Tq          =  asmb.Tq   +  (vector1 + vector2 + vector3)*Int_weight;
end 
%--------------------------------------------------------------------------
% Stiffness matrices   
%--------------------------------------------------------------------------
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Integration weight
    %----------------------------------------------------------------------
    Int_weight       =  (kinematics.DX_chi_Jacobian(igauss))*quad_BEM_FEM.W_v(igauss);
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices Kqphi
    %----------------------------------------------------------------------
    Kqphi            =  (dVdx(:,igauss)'*kinematics.Normal_vector(:,igauss))*fem_BEM_FEM.phi.N(:,igauss)';
    Kqphiprime       =  (dVdx(:,igauss)'*kinematics.Normal_vector(:,igauss))*fem.surface.nodes.phi.N_q(:,local_node(1))';
    %----------------------------------------------------------------------
    % Vectorisation of stiffness matrices Kqq
    %----------------------------------------------------------------------
    Kqq              =  -V(igauss)*fem_BEM_FEM.q.N(:,igauss)';
    %----------------------------------------------------------------------
    % Stiffness matrices
    %----------------------------------------------------------------------
    asmb.Kqphi       =  asmb.Kqphi      +  Kqphi*Int_weight;
    asmb.Kqphiprime  =  asmb.Kqphiprime + Kqphiprime*Int_weight;
    asmb.Kqq         =  asmb.Kqq        +  Kqq*Int_weight;    
end


