function [INDEXI,...
  INDEXJ,DATA]   =  ParallelInternalVectorsAssemblyOnlyElectro(ielement,mesh,element_assembly)

%--------------------------------------------------------------------------
%  dofs
%--------------------------------------------------------------------------
global_phi_dof   =  mesh.volume.phi.connectivity(:,ielement);
%--------------------------------------------------------------------------
% INDEXI, INDEXJ, DATA
%--------------------------------------------------------------------------
INDEXI           =  global_phi_dof;
INDEXJ           =  ones(size(INDEXI,1),1);
DATA             =  element_assembly.Tphi;
                                    