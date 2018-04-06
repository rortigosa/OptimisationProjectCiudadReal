%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Sparse assembly for the stiffness matrices arising from the vaccum
%  contribution in the principle of virtual work (boundary integrals)
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function [INDEXI,INDEXJ,...
            DATA]           =  StiffnessSparseAssemblyBoundaryFEMOnlyElectro(iedge,mesh,...
                                                                element_assembly)   
%--------------------------------------------------------------------------
% phi dof's. 
%--------------------------------------------------------------------------
phi_dof                     =  mesh.surface.phi.boundary_edges(:,iedge);
n_dofs                      =  mesh.volume.phi.n_nodes;
%--------------------------------------------------------------------------
%  q0 dof's
%--------------------------------------------------------------------------
q_dof                       =  mesh.surface.q.connectivity(:,iedge);
q_dof                       =  n_dofs + q_dof;
%--------------------------------------------------------------------------
% Kphiq matrix.
%--------------------------------------------------------------------------
newindexi                   =  zeros(size(phi_dof,1),size(q_dof,1));
newindexj                   =  zeros(size(phi_dof,1),size(q_dof,1));
for iloop=1:size(q_dof,1)
    newindexi(:,iloop)      =  phi_dof;
    newindexj(:,iloop)      =  q_dof(iloop)*ones(size(phi_dof,1),1);
end
newdata                     =  element_assembly.Kphiq(:);
newindexi                   =  reshape(newindexi,size(newindexi,1)*size(newindexi,2),1);
newindexj                   =  reshape(newindexj,size(newindexj,1)*size(newindexj,2),1);
newdata                     =  reshape(newdata,size(newdata,1)*size(newdata,2),1);
Kphiq_indexi                =  newindexi;
Kphiq_indexj                =  newindexj;
Kphiq_data                  =  newdata;
%--------------------------------------------------------------------------
% Updating indexi, indexj and data. 
%--------------------------------------------------------------------------
INDEXI                      =  Kphiq_indexi;
INDEXJ                      =  Kphiq_indexj;
DATA                        =  Kphiq_data;
end



