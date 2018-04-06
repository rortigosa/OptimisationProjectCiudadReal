function solution                         =  InitialisedVariablesCGC(geom,mesh,material_information)

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
solution.C                                =  repmat(eyevector,1,mesh.volume.C.n_nodes);
solution.G                                =  repmat(eyevector,1,mesh.volume.G.n_nodes);
solution.c                                =  ones(mesh.volume.c.n_nodes,1);
solution.SigmaC                           =  zeros(geom.dim^2,mesh.volume.C.n_nodes);
solution.SigmaG                           =  zeros(geom.dim^2,mesh.volume.G.n_nodes);
solution.Sigmac                           =  zeros(mesh.volume.c.n_nodes,1);
%--------------------------------------------------------------------------
% Correct initialise of work conjugate SigmaF 
%--------------------------------------------------------------------------
n_node_elem_C                             =  mesh.volume.C.n_node_elem;
material_information.derivatives.DU.DUDC  =  zeros(geom.dim,geom.dim,n_node_elem_C);
material_information.derivatives.DU.DUDG  =  zeros(geom.dim,geom.dim,n_node_elem_C);
material_information.derivatives.DU.DUDc  =  zeros(n_node_elem_C,1);
C                                         =  reshape(repmat(eye(geom.dim),1,n_node_elem_C),geom.dim,geom.dim,n_node_elem_C);
G                                         =  reshape(repmat(eye(geom.dim),1,n_node_elem_C),geom.dim,geom.dim,n_node_elem_C);
c                                         =  ones(n_node_elem_C,1);
for ielem=1:mesh.volume.n_elem
    material_information                  =  FirstDerivativeComputationMechanicsC(ielem,n_node_elem_C,C,G,c,material_information);                                                                      
    Cnodes                                =  mesh.volume.C.connectivity(:,ielem);
    SigmaC                                =  material_information.derivatives.DU.DUDC;
    solution.SigmaC(:,Cnodes)             =  Matrix2Vector(geom.dim^2,n_node_elem_C,SigmaC);
end
%--------------------------------------------------------------------------
% Correct initialise of work conjugate SigmaH
%--------------------------------------------------------------------------
n_node_elem_G                             =  mesh.volume.G.n_node_elem;
material_information.derivatives.DU.DUDC  =  zeros(geom.dim,geom.dim,n_node_elem_G);
material_information.derivatives.DU.DUDG  =  zeros(geom.dim,geom.dim,n_node_elem_G);
material_information.derivatives.DU.DUDc  =  zeros(n_node_elem_G,1);
C                                         =  reshape(repmat(eye(geom.dim),1,n_node_elem_G),geom.dim,geom.dim,n_node_elem_G);
G                                         =  reshape(repmat(eye(geom.dim),1,n_node_elem_G),geom.dim,geom.dim,n_node_elem_G);
c                                         =  ones(n_node_elem_G,1);
for ielem=1:mesh.volume.n_elem
    material_information                  =  FirstDerivativeComputationMechanicsC(ielem,n_node_elem_G,C,G,c,material_information);                                                                      
    Gnodes                                =  mesh.volume.G.connectivity(:,ielem);
    SigmaG                                =  material_information.derivatives.DU.DUDG;
    solution.SigmaG(:,Gnodes)             =  Matrix2Vector(geom.dim^2,n_node_elem_G,SigmaG);
end
%--------------------------------------------------------------------------
% Correct initialise of work conjugate SigmaJ
%--------------------------------------------------------------------------
n_node_elem_c                             =  mesh.volume.c.n_node_elem;
material_information.derivatives.DU.DUDC  =  zeros(geom.dim,geom.dim,n_node_elem_c);
material_information.derivatives.DU.DUDG  =  zeros(geom.dim,geom.dim,n_node_elem_c);
material_information.derivatives.DU.DUDc  =  zeros(n_node_elem_c,1);
C                                         =  reshape(repmat(eye(geom.dim),1,n_node_elem_c),geom.dim,geom.dim,n_node_elem_c);
G                                         =  reshape(repmat(eye(geom.dim),1,n_node_elem_c),geom.dim,geom.dim,n_node_elem_c);
c                                         =  ones(n_node_elem_c,1);
for ielem=1:mesh.volume.n_elem
    material_information                  =  FirstDerivativeComputationMechanicsC(ielem,n_node_elem_c,C,G,c,material_information);                                                                      
    cnodes                                =  mesh.volume.c.connectivity(:,ielem);
    Sigmac                                =  material_information.derivatives.DU.DUDc;
    solution.Sigmac(cnodes)               =  Sigmac;
end
%--------------------------------------------------------------------------
% Total number of dofs
%--------------------------------------------------------------------------
solution.n_dofs                     =  geom.dim*mesh.volume.x.n_nodes;


