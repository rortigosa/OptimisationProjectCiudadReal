function solution                   =  InitialisedVariablesElectroIncompressible(geom,mesh,quadrature)

%--------------------------------------------------------------------------
%  Kinematics
%--------------------------------------------------------------------------
solution.x.Lagrangian_X             =  mesh.volume.x.nodes;
solution.x.Eulerian_x               =  solution.x.Lagrangian_X;
solution.x.Eulerian_x_dot           =  zeros(geom.dim,mesh.volume.x.n_nodes);
solution.x.Eulerian_x_dot_dot       =  zeros(geom.dim,mesh.volume.x.n_nodes);
solution.x.Eulerian_x_dot_dot_old   =  zeros(geom.dim,mesh.volume.x.n_nodes);
solution.x.Eulerian_x_old           =  solution.x.Lagrangian_X;
%--------------------------------------------------------------------------
% Electric potential
%--------------------------------------------------------------------------
solution.phi                        =  zeros(mesh.volume.phi.n_nodes,1);
%--------------------------------------------------------------------------
%  Pressure
%--------------------------------------------------------------------------
solution.pressure                   =  zeros(mesh.volume.pressure.n_nodes,1);
%--------------------------------------------------------------------------
% Electric displacement field
%--------------------------------------------------------------------------
solution.D0                         =  zeros(geom.dim,size(quadrature.volume.bilinear.Chi,1),mesh.volume.n_elem);
%--------------------------------------------------------------------------
% Total number of dofs
%--------------------------------------------------------------------------
solution.n_dofs                     =  geom.dim*mesh.volume.x.n_nodes + ...
                                       mesh.volume.phi.n_nodes + ...
                                       mesh.volume.pressure.n_nodes;

                                   
                                   