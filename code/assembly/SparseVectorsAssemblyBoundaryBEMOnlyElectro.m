%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Residual arising from the BEM integral
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [INDEXI,INDEXJ,...
    DATA]                  =  SparseVectorsAssemblyBoundaryBEMOnlyElectro(inode,mesh,element_assembly)

global_q_dof               =  inode + mesh.volume.phi.n_nodes;

INDEXI                     =  global_q_dof;
INDEXJ                     =  ones(length(INDEXI),1);
DATA                       =  element_assembly.Tq(:);         

