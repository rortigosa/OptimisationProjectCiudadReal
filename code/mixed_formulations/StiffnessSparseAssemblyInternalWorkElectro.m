%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Sparse assembly of formulation with dofs: x, phi 
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [INDEXI,INDEXJ,...
            DATA]           =  StiffnessSparseAssemblyInternalWorkElectro(ielement,dim,mesh,...
                                                                element_assembly)   
%--------------------------------------------------------------------------
% x dof's. 
%--------------------------------------------------------------------------
x_nodes                     =  mesh.volume.x.connectivity(:,ielement)';
x_dof                       =  zeros(dim,size(x_nodes,2));
for idim=1:dim
    x_dof(idim,:)           =  (x_nodes-1)*dim + idim;
end
x_dof                       =  reshape(x_dof,size(x_dof,1)*size(x_dof,2),1);
n_dofs                      =  dim*mesh.volume.x.n_nodes; 
%--------------------------------------------------------------------------
% phi dof's. 
%--------------------------------------------------------------------------
phi_dof                     =  mesh.volume.phi.connectivity(:,ielement);
phi_dof                     =  n_dofs + phi_dof;
%--------------------------------------------------------------------------
% Kxx matrix. 
%--------------------------------------------------------------------------
newindexi                   =  zeros(size(x_dof,1),size(x_dof,1));
newindexj                   =  zeros(size(x_dof,1),size(x_dof,1));
for iloop=1:size(x_dof,1)
    newindexi(:,iloop)      =  x_dof;
    newindexj(:,iloop)      =  x_dof(iloop)*ones(size(x_dof,1),1);
end
newdata                     =  element_assembly.Kxx;
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
% Kphix matrix.
%--------------------------------------------------------------------------
newindexi                   =  zeros(size(phi_dof,1),size(x_dof,1));
newindexj                   =  zeros(size(phi_dof,1),size(x_dof,1));
for iloop=1:size(x_dof,1)
    newindexi(:,iloop)      =  phi_dof;
    newindexj(:,iloop)      =  x_dof(iloop)*ones(size(phi_dof,1),1);
end
newdata                     =  element_assembly.Kphix(:);
newindexi                   =  reshape(newindexi,size(newindexi,1)*size(newindexi,2),1);
newindexj                   =  reshape(newindexj,size(newindexj,1)*size(newindexj,2),1);
newdata                     =  reshape(newdata,size(newdata,1)*size(newdata,2),1);
Kphix_indexi                =  newindexi;
Kphix_indexj                =  newindexj;
Kphix_data                  =  newdata;
%--------------------------------------------------------------------------
% Kphiphi matrix.
%--------------------------------------------------------------------------
newindexi                   =  zeros(size(phi_dof,1),size(phi_dof,1));
newindexj                   =  zeros(size(phi_dof,1),size(phi_dof,1));
for iloop=1:size(phi_dof,1)
    newindexi(:,iloop)      =  phi_dof;
    newindexj(:,iloop)      =  phi_dof(iloop)*ones(size(phi_dof,1),1);
end
newdata                     =  element_assembly.Kphiphi(:);
newindexi                   =  reshape(newindexi,size(newindexi,1)*size(newindexi,2),1);
newindexj                   =  reshape(newindexj,size(newindexj,1)*size(newindexj,2),1);
newdata                     =  reshape(newdata,size(newdata,1)*size(newdata,2),1);
Kphiphi_indexi              =  newindexi;
Kphiphi_indexj              =  newindexj;
Kphiphi_data                =  newdata;
%--------------------------------------------------------------------------
% Updating indexi, indexj and data. 
%--------------------------------------------------------------------------
INDEXI                      =  [Kxx_indexi;   Kxphi_indexi;...
                                Kphix_indexi; Kphiphi_indexi];
INDEXJ                      =  [Kxx_indexj;   Kxphi_indexj;...
                                Kphix_indexj; Kphiphi_indexj];
DATA                        =  [Kxx_data;     Kxphi_data;...
                                Kphix_data;   Kphiphi_data];
end