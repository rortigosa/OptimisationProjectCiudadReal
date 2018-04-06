function assembly                   =  InternalVectorsAssemblyElectroIncompressible(ielement,dim,mesh,assembly)

%-------------------------------------------------------------------------- 
% x
%--------------------------------------------------------------------------
n_nodes_elem                        =  size(mesh.volume.x.connectivity,1);
T1                                  =  repmat(1:dim,n_nodes_elem,1);
T1                                  =  T1';
T1                                  =  reshape(T1,dim*n_nodes_elem,1);

nodes                               =  mesh.volume.x.connectivity(:,ielement);
T2                                  =  ((nodes - 1)*dim);
T2                                  =  repmat(T2,1,dim);
T2                                  =  T2';
T2                                  =  reshape(T2,dim*n_nodes_elem,1);

global_x_dof                        =  T1 + T2;
assembly.Tx(global_x_dof,1)         =  assembly.Tx(global_x_dof,1) + assembly.element_assembly.Tx;
%--------------------------------------------------------------------------
%  phi
%--------------------------------------------------------------------------
global_phi_dof                      =  mesh.volume.phi.connectivity(:,ielement);
assembly.Tphi(global_phi_dof,1)     =  assembly.Tphi(global_phi_dof,1) + assembly.element_assembly.Tphi;         
%--------------------------------------------------------------------------
%  Pressure
%--------------------------------------------------------------------------
global_pressure_dof                 =  mesh.volume.pressure.connectivity(:,ielement);
assembly.Tp(global_pressure_dof,1)  =  assembly.Tp(global_pressure_dof,1) + assembly.element_assembly.Tp;         
