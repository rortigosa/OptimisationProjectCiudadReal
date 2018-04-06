%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Sparse assembly of formulation with dofs: x, phi 
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [INDEXI,INDEXJ,...
            DATA]           =  StiffnessSparseAssemblyInternalWorkOnlyElectro(ielement,mesh,...
                                                                element_assembly)   

%--------------------------------------------------------------------------
% phi dof's. 
%--------------------------------------------------------------------------
phi_dof                     =  mesh.volume.phi.connectivity(:,ielement);
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
INDEXI                      =  Kphiphi_indexi;
INDEXJ                      =  Kphiphi_indexj;
DATA                        =  Kphiphi_data;
                                                            