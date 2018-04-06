%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Sparse assembly of formulation with dofs: x, phi and p 
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function [INDEXI,INDEXJ,...
            DATA]           =  StiffnessSparseAssemblyInternalWorkElectroIncompressible(ielement,dim,mesh,...
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
n_dofs                      =  n_dofs + mesh.volume.phi.n_nodes;
%--------------------------------------------------------------------------
%  pressure dof's
%--------------------------------------------------------------------------
pressure_dof                =  mesh.volume.pressure.connectivity(:,ielement);
pressure_dof                =  n_dofs + pressure_dof;
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
% Kxp matrix.
%--------------------------------------------------------------------------
newindexi                   =  zeros(size(x_dof,1),size(pressure_dof,1));
newindexj                   =  zeros(size(x_dof,1),size(pressure_dof,1));
for iloop=1:size(pressure_dof,1)
    newindexi(:,iloop)      =  x_dof;
    newindexj(:,iloop)      =  pressure_dof(iloop)*ones(size(x_dof,1),1);
end
newdata                     =  element_assembly.Kxp(:);
newindexi                   =  reshape(newindexi,size(newindexi,1)*size(newindexi,2),1);
newindexj                   =  reshape(newindexj,size(newindexj,1)*size(newindexj,2),1);
newdata                     =  reshape(newdata,size(newdata,1)*size(newdata,2),1);
Kxp_indexi                  =  newindexi;
Kxp_indexj                  =  newindexj;
Kxp_data                    =  newdata;
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
% Kpx matrix.
%--------------------------------------------------------------------------
newindexi                   =  zeros(size(pressure_dof,1),size(x_dof,1));
newindexj                   =  zeros(size(pressure_dof,1),size(x_dof,1));
for iloop=1:size(x_dof,1)
    newindexi(:,iloop)      =  pressure_dof;
    newindexj(:,iloop)      =  x_dof(iloop)*ones(size(pressure_dof,1),1);
end
newdata                     =  element_assembly.Kpx(:);
newindexi                   =  reshape(newindexi,size(newindexi,1)*size(newindexi,2),1);
newindexj                   =  reshape(newindexj,size(newindexj,1)*size(newindexj,2),1);
newdata                     =  reshape(newdata,size(newdata,1)*size(newdata,2),1);
Kpx_indexi                  =  newindexi;
Kpx_indexj                  =  newindexj;
Kpx_data                    =  newdata;
%--------------------------------------------------------------------------
% Kpp matrix.
%--------------------------------------------------------------------------
newindexi                   =  zeros(size(pressure_dof,1),size(pressure_dof,1));
newindexj                   =  zeros(size(pressure_dof,1),size(pressure_dof,1));
for iloop=1:size(pressure_dof,1)
    newindexi(:,iloop)      =  pressure_dof;
    newindexj(:,iloop)      =  pressure_dof(iloop)*ones(size(pressure_dof,1),1);
end
newdata                     =  element_assembly.Kpp(:);
newindexi                   =  reshape(newindexi,size(newindexi,1)*size(newindexi,2),1);
newindexj                   =  reshape(newindexj,size(newindexj,1)*size(newindexj,2),1);
newdata                     =  reshape(newdata,size(newdata,1)*size(newdata,2),1);
Kpp_indexi                  =  newindexi;
Kpp_indexj                  =  newindexj;
Kpp_data                    =  newdata;
%--------------------------------------------------------------------------
% Updating indexi, indexj and data. 
%--------------------------------------------------------------------------
INDEXI                      =  [Kxx_indexi;   Kxphi_indexi;   Kxp_indexi;...
                                Kphix_indexi; Kphiphi_indexi; Kpx_indexi; Kpp_indexi];
INDEXJ                      =  [Kxx_indexj;   Kxphi_indexj;   Kxp_indexj;...
                                Kphix_indexj; Kphiphi_indexj; Kpx_indexj; Kpp_indexj];
DATA                        =  [Kxx_data;     Kxphi_data;     Kxp_data;...
                                Kphix_data;   Kphiphi_data;   Kpx_data;   Kpp_data];
end