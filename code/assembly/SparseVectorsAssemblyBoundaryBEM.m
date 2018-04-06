%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Residual arising from the BEM integral
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [INDEXI,INDEXJ,...
    DATA]                  =  SparseVectorsAssemblyBoundaryBEM(dim,inode,mesh,element_assembly)

global_q_dof               =  inode + mesh.volume.phi.n_nodes + mesh.volume.x.n_nodes*dim;
INDEXI                     =  global_q_dof;
INDEXJ                     =  ones(length(INDEXI),1);
DATA                       =  element_assembly.Tq(:);         

