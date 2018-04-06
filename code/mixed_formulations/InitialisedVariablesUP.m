function solution                   =  InitialisedVariablesUP(geom,mesh)

%--------------------------------------------------------------------------
%  Kinematics
%--------------------------------------------------------------------------
solution.x.Lagrangian_X             =  mesh.volume.x.nodes;
solution.x.Eulerian_x               =  solution.x.Lagrangian_X;
solution.x.Eulerian_x_old           =  solution.x.Lagrangian_X;
%--------------------------------------------------------------------------
%  Pressure
%--------------------------------------------------------------------------
solution.pressure                   =  zeros(mesh.volume.pressure.n_nodes,1);
%--------------------------------------------------------------------------
% Total number of dofs
%--------------------------------------------------------------------------
solution.n_dofs                     =  geom.dim*mesh.volume.x.n_nodes + ...
                                       mesh.volume.pressure.n_nodes;

                                   
                                   