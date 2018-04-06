
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function projects a scalar quantity which is constant per element
%  to the nodes of the mesh
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function DIDrho_nodes    =  ProjectElementQuantyToNodes(n_nodes,connectivity,rep_elem,Velem)

DIDrho_nodes             =  zeros(n_nodes);
n_nodes_elem             =  size(connectivity,1);
for ielem=1:size(connectivity,2)
    nodes                =  connectivity(:,ielem);
    DIDrho_nodes(nodes)  =  DIDrho_nodes(nodes) + repmat(DIDrho(ielem),n_nodes_elem,1);
end

DIDrho_nodes             =  DIDrho_nodes./(rep_elem);  
DIDrho_nodes             =  DIDrho_nodes./(Velem);  