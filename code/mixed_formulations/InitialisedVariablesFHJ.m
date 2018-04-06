function solution                         =  InitialisedVariablesFHJ(geom,mesh,material_information)
%--------------------------------------------------------------------------
%  Kinematics
%--------------------------------------------------------------------------
solution.x.Lagrangian_X                   =  mesh.volume.x.nodes;
solution.x.Eulerian_x                     =  solution.x.Lagrangian_X;
solution.x.Eulerian_x_dot                 =  zeros(geom.dim,mesh.volume.x.n_nodes);
solution.x.Eulerian_x_dot_dot             =  zeros(geom.dim,mesh.volume.x.n_nodes);
solution.x.Eulerian_x_dot_dot_old         =  zeros(geom.dim,mesh.volume.x.n_nodes);
solution.x.Eulerian_x_old                 =  solution.x.Lagrangian_X;
%--------------------------------------------------------------------------
%  Mixed formulation variables
%--------------------------------------------------------------------------
eyevector                                 =  reshape(eye(geom.dim),[],1);
solution.F                                =  repmat(eyevector,1,mesh.volume.F.n_nodes);
solution.H                                =  repmat(eyevector,1,mesh.volume.H.n_nodes);
solution.J                                =  ones(mesh.volume.J.n_nodes,1);
solution.SigmaF                           =  zeros(geom.dim^2,mesh.volume.F.n_nodes);
solution.SigmaH                           =  zeros(geom.dim^2,mesh.volume.H.n_nodes);
solution.SigmaJ                           =  zeros(mesh.volume.J.n_nodes,1);
%--------------------------------------------------------------------------
% Correct initialise of work conjugate SigmaF 
%--------------------------------------------------------------------------
n_node_elem_F                             =  mesh.volume.F.n_node_elem;
material_information.derivatives.DU.DUDF  =  zeros(geom.dim,geom.dim,n_node_elem_F);
material_information.derivatives.DU.DUDH  =  zeros(geom.dim,geom.dim,n_node_elem_F);
material_information.derivatives.DU.DUDJ  =  zeros(n_node_elem_F,1);
F                                         =  reshape(repmat(eye(geom.dim),1,n_node_elem_F),geom.dim,geom.dim,n_node_elem_F);
H                                         =  reshape(repmat(eye(geom.dim),1,n_node_elem_F),geom.dim,geom.dim,n_node_elem_F);
J                                         =  ones(n_node_elem_F,1);
for ielem=1:mesh.volume.n_elem
    material_information                  =  FirstDerivativeComputationMechanics(ielem,n_node_elem_F,F,H,J,material_information);                                                                      
    Fnodes                                =  mesh.volume.F.connectivity(:,ielem);
    SigmaF                                =  material_information.derivatives.DU.DUDF;
    solution.SigmaF(:,Fnodes)             =  Matrix2Vector(geom.dim^2,n_node_elem_F,SigmaF);
end
%--------------------------------------------------------------------------
% Correct initialise of work conjugate SigmaH
%--------------------------------------------------------------------------
n_node_elem_H                             =  mesh.volume.H.n_node_elem;
material_information.derivatives.DU.DUDF  =  zeros(geom.dim,geom.dim,n_node_elem_H);
material_information.derivatives.DU.DUDH  =  zeros(geom.dim,geom.dim,n_node_elem_H);
material_information.derivatives.DU.DUDJ  =  zeros(n_node_elem_H,1);
F                                         =  reshape(repmat(eye(geom.dim),1,n_node_elem_H),geom.dim,geom.dim,n_node_elem_H);
H                                         =  reshape(repmat(eye(geom.dim),1,n_node_elem_H),geom.dim,geom.dim,n_node_elem_H);
J                                         =  ones(n_node_elem_H,1);
for ielem=1:mesh.volume.n_elem
    material_information                  =  FirstDerivativeComputationMechanics(ielem,n_node_elem_H,F,H,J,material_information);                                                                      
    Hnodes                                =  mesh.volume.H.connectivity(:,ielem);
    SigmaH                                =  material_information.derivatives.DU.DUDH;
    solution.SigmaH(:,Hnodes)             =  Matrix2Vector(geom.dim^2,n_node_elem_H,SigmaH);
end
%--------------------------------------------------------------------------
% Correct initialise of work conjugate SigmaJ
%--------------------------------------------------------------------------
n_node_elem_J                             =  mesh.volume.J.n_node_elem;
material_information.derivatives.DU.DUDF  =  zeros(geom.dim,geom.dim,n_node_elem_J);
material_information.derivatives.DU.DUDH  =  zeros(geom.dim,geom.dim,n_node_elem_J);
material_information.derivatives.DU.DUDJ  =  zeros(n_node_elem_J,1);
F                                         =  reshape(repmat(eye(geom.dim),1,n_node_elem_J),geom.dim,geom.dim,n_node_elem_J);
H                                         =  reshape(repmat(eye(geom.dim),1,n_node_elem_J),geom.dim,geom.dim,n_node_elem_J);
J                                         =  ones(n_node_elem_J,1);
for ielem=1:mesh.volume.n_elem
    material_information                  =  FirstDerivativeComputationMechanics(ielem,n_node_elem_J,F,H,J,material_information);                                                                      
    Jnodes                                =  mesh.volume.J.connectivity(:,ielem);
    SigmaJ                                =  material_information.derivatives.DU.DUDJ;
    solution.SigmaJ(Jnodes)               =  SigmaJ;
end
%--------------------------------------------------------------------------
% Total number of dofs
%--------------------------------------------------------------------------
solution.n_dofs                           =  geom.dim*mesh.volume.x.n_nodes;


