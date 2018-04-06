%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Sparse assembly of formulation with dofs: x, phi and p 
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function [INDEXI,INDEXJ]    =  SparseIndicesStiffnessMatrix(ielement,dim,mesh)   
%--------------------------------------------------------------------------
% x dof's. 
%--------------------------------------------------------------------------
x_nodes                     =  mesh.volume.x.connectivity(:,ielement)';
x_dof                       =  zeros(dim,size(x_nodes,2));
for idim=1:dim
    x_dof(idim,:)           =  (x_nodes-1)*dim + idim;
end
x_dof                       =  reshape(x_dof,size(x_dof,1)*size(x_dof,2),1);
%--------------------------------------------------------------------------
% Kxx matrix. 
%--------------------------------------------------------------------------
newindexi                   =  zeros(size(x_dof,1),size(x_dof,1));
newindexj                   =  zeros(size(x_dof,1),size(x_dof,1));
for iloop=1:size(x_dof,1)
    newindexi(:,iloop)      =  x_dof;
    newindexj(:,iloop)      =  x_dof(iloop)*ones(size(x_dof,1),1);
end
newindexi                   =  reshape(newindexi,size(newindexi,1)*size(newindexi,2),1);
newindexj                   =  reshape(newindexj,size(newindexj,1)*size(newindexj,2),1);
Kxx_indexi                  =  newindexi;
Kxx_indexj                  =  newindexj;
%--------------------------------------------------------------------------
% Updating indexi, indexj and data. 
%--------------------------------------------------------------------------
INDEXI                      =  Kxx_indexi;
INDEXJ                      =  Kxx_indexj;
end