function [INDEXI,...
  INDEXJ,DATA]   =  ParallelInternalVectorsAssemblyElectro(ielement,dim,mesh,element_assembly)

%-------------------------------------------------------------------------- 
% x
%--------------------------------------------------------------------------
n_nodes_elem     =  size(mesh.volume.x.connectivity,1);
T1               =  repmat(1:dim,n_nodes_elem,1);
T1               =  T1';
T1               =  reshape(T1,dim*n_nodes_elem,1);

nodes            =  mesh.volume.x.connectivity(:,ielement);
T2               =  ((nodes - 1)*dim);
T2               =  repmat(T2,1,dim);
T2               =  T2';
T2               =  reshape(T2,dim*n_nodes_elem,1);
%--------------------------------------------------------------------------
%  dofs
%--------------------------------------------------------------------------
global_x_dof     =  T1 + T2;
global_phi_dof   =  mesh.volume.phi.connectivity(:,ielement) + mesh.volume.x.n_nodes*dim;
%--------------------------------------------------------------------------
% INDEXI, INDEXJ, DATA
%--------------------------------------------------------------------------
INDEXI           =  [global_x_dof;...
                     global_phi_dof];
INDEXJ           =  ones(size(INDEXI,1),1);
DATA             =  [element_assembly.Tx;...
                     element_assembly.Tphi];
                                    