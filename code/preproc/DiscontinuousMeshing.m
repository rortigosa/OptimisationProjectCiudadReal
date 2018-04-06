%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Create discontinuous mesh
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [nodes_3D,...
    connectivity_3D]           =  DiscontinuousMeshing(continuous_nodes_3D,continuous_connectivity_3D)

dim                            =  size(continuous_nodes_3D,1);
n_elem                         =  size(continuous_connectivity_3D,2);
n_node_elem                    =  size(continuous_connectivity_3D,1);
n_nodes                        =  n_node_elem*n_elem;

nodes_3D                       =  zeros(dim,n_nodes);
connectivity_3D                =  reshape((1:n_nodes)',n_node_elem,[]);

final                          =  0;
for ielem=1:n_elem
    xelem                      =  continuous_nodes_3D(:,continuous_connectivity_3D(:,ielem));    
    initial                    =  final + 1;
    final                      =  initial + n_node_elem - 1;
    nodes_3D(:,initial:final)  =  xelem;
end