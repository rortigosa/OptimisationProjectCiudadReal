%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Sparse assembly for the stiffness matrices arising from the vaccum
%  contribution in the principle of virtual work (boundary integrals)
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function [INDEXI,INDEXJ,...
            DATA]           =  StiffnessSparseAssemblyBoundaryFEMIncompressible(iedge,dim,mesh,...
                                                                element_assembly)   
%--------------------------------------------------------------------------
% x dof's. 
%--------------------------------------------------------------------------
x_nodes                     =  mesh.surface.x.boundary_edges(:,iedge)';
x_dof                       =  zeros(dim,size(x_nodes,2));
for idim=1:dim
    x_dof(idim,:)           =  (x_nodes-1)*dim + idim;
end
x_dof                       =  reshape(x_dof,size(x_dof,1)*size(x_dof,2),1);
n_dofs                      =  dim*mesh.volume.x.n_nodes; 
%--------------------------------------------------------------------------
% phi dof's. 
%--------------------------------------------------------------------------
phi_dof                     =  mesh.surface.phi.boundary_edges(:,iedge);
phi_dof                     =  n_dofs + phi_dof;
n_dofs                      =  n_dofs + mesh.volume.phi.n_nodes;
%--------------------------------------------------------------------------
%  pressure dof's
%--------------------------------------------------------------------------
n_dofs                      =  n_dofs + mesh.volume.pressure.n_nodes;
%--------------------------------------------------------------------------
%  q0 dof's
%--------------------------------------------------------------------------
q_dof                       =  mesh.surface.q.connectivity(:,iedge);
q_dof                       =  n_dofs + q_dof;
%--------------------------------------------------------------------------
% Kxx matrix.
%--------------------------------------------------------------------------
newindexi                   =  zeros(size(x_dof,1),size(x_dof,1));
newindexj                   =  zeros(size(x_dof,1),size(x_dof,1));
for iloop=1:size(x_dof,1)
    newindexi(:,iloop)      =  x_dof;
    newindexj(:,iloop)      =  x_dof(iloop)*ones(size(x_dof,1),1);
end
newdata                     =  element_assembly.Kxx(:);
newindexi                   =  reshape(newindexi,size(newindexi,1)*size(newindexi,2),1);
newindexj                   =  reshape(newindexj,size(newindexj,1)*size(newindexj,2),1);
newdata                     =  reshape(newdata,size(newdata,1)*size(newdata,2),1);
Kxx_indexi                  =  newindexi;
Kxx_indexj                  =  newindexj;
Kxx_data                    =  newdata;
%--------------------------------------------------------------------------
% Kxphi matrix.
%--------------------------------------------------------------------------
newindexi                   =  zeros(size(x_dof,1),size(phi_dof,1));
newindexj                   =  zeros(size(x_dof,1),size(phi_dof,1));
for iloop=1:size(phi_dof,1)
    newindexi(:,iloop)      =  x_dof;
    newindexj(:,iloop)      =  phi_dof(iloop)*ones(size(x_dof,1),1);
end
newdata                     =  element_assembly.Kxphi(:);
newindexi                   =  reshape(newindexi,size(newindexi,1)*size(newindexi,2),1);
newindexj                   =  reshape(newindexj,size(newindexj,1)*size(newindexj,2),1);
newdata                     =  reshape(newdata,size(newdata,1)*size(newdata,2),1);
Kxphi_indexi                =  newindexi;
Kxphi_indexj                =  newindexj;
Kxphi_data                  =  newdata;
%--------------------------------------------------------------------------
% Kxq matrix.
%--------------------------------------------------------------------------
newindexi                   =  zeros(size(x_dof,1),size(q_dof,1));
newindexj                   =  zeros(size(x_dof,1),size(q_dof,1));
for iloop=1:size(q_dof,1)
    newindexi(:,iloop)      =  x_dof;
    newindexj(:,iloop)      =  q_dof(iloop)*ones(size(x_dof,1),1);
end
newdata                     =  element_assembly.Kxq(:);
newindexi                   =  reshape(newindexi,size(newindexi,1)*size(newindexi,2),1);
newindexj                   =  reshape(newindexj,size(newindexj,1)*size(newindexj,2),1);
newdata                     =  reshape(newdata,size(newdata,1)*size(newdata,2),1);
Kxq_indexi                  =  newindexi;
Kxq_indexj                  =  newindexj;
Kxq_data                    =  newdata;
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
INDEXI                      =  [Kxx_indexi;   Kxphi_indexi;...
                                Kxq_indexi;   Kphiq_indexi];
INDEXJ                      =  [Kxx_indexj;   Kxphi_indexj;...
                                Kxq_indexj;   Kphiq_indexj];
DATA                        =  [Kxx_data;     Kxphi_data;...
                                Kxq_data;     Kphiq_data];
end



