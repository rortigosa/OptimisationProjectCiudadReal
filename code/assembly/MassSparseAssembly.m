%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Global assembly of the mass matrix
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Sparse assembly
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function [INDEXI,INDEXJ,...
            DATA]       =  MassSparseAssembly(ielement,dim,mesh,Mass)  
 
%--------------------------------------------------------------------------
% displacement and rotational dof's. 
%--------------------------------------------------------------------------
x_nodes                 =  mesh.volume.x.connectivity(:,ielement)';
xdof                    =  zeros(dim,size(x_nodes,2));
for idim=1:dim
    xdof(idim,:)        =  (x_nodes-1)*dim + idim;
end
xdof                    =  reshape(xdof,size(xdof,1)*size(xdof,2),1);
%--------------------------------------------------------------------------
% Mx0x0 matrix. 
%--------------------------------------------------------------------------
newindexi               =  zeros(size(xdof,1),size(xdof,1));
newindexj               =  zeros(size(xdof,1),size(xdof,1));
for iloop=1:size(xdof,1)
    newindexi(:,iloop)  =  xdof;
    newindexj(:,iloop)  =  xdof(iloop)*ones(size(xdof,1),1);
end
newindexi               =  reshape(newindexi,size(newindexi,1)*size(newindexi,2),1);
newindexj               =  reshape(newindexj,size(newindexj,1)*size(newindexj,2),1);
newdata                 =  Mass(:);
Mxx_indexi              =  newindexi;
Mxx_indexj              =  newindexj;
Mxx_data                =  newdata;
%--------------------------------------------------------------------------
% Updating indexi, indexj and data. 
%--------------------------------------------------------------------------
INDEXI                  =  Mxx_indexi;
INDEXJ                  =  Mxx_indexj;
DATA                    =  Mxx_data;

end
