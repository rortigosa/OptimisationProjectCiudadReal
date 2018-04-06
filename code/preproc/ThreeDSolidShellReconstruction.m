function [nodes_3D,connectivity_3D]           =  ThreeDSolidShellReconstruction(nodes_mid_plane,connectivity_mid_plane,degree,n_layers,thickness,DN_chi)


%--------------------------------------------------------------------------
%  Eulerian and Lagrangian triads
%--------------------------------------------------------------------------
Lagrangian_director                           =  zeros(3,size(nodes_mid_plane,2));
n_elem_mid_plane                              =  size(connectivity_mid_plane,2);
switch degree
    case 0
    otherwise
         for ielem=1:n_elem_mid_plane
             connectivities_triad             =  connectivity_mid_plane(:,ielem);
             Xelem                            =  (nodes_mid_plane(:,connectivities_triad));
             for inode=1:size(connectivity_mid_plane,1)
                 D1                           =  Xelem*(DN_chi(1,:,inode))';
                 D2                           =  Xelem*(DN_chi(2,:,inode))';
                 D1                           =  D1/norm(D1);
                 D2                           =  D2/norm(D2);
                 D3                           =  cross(D1,D2)/norm(cross(D1,D2));
                 node                         =  connectivities_triad(inode);
                 Lagrangian_director(:,node)  =  D3;
             end
         end
end
%--------------------------------------------------------------------------
% Coordinates of the nodes of the 3D mesh
%--------------------------------------------------------------------------
switch degree
    case 0
         n_nodes_thickness                    =  n_layers;
    otherwise
         n_nodes_thickness                    =  degree*n_layers + 1;
end        
n_nodes_3D                                    =  size(nodes_mid_plane,2)*n_nodes_thickness;
nodes_3D                                      =  zeros(3,n_nodes_3D);
h_bottom                                      =  -sum(thickness(1:n_layers))/2;

i3D_node                                      =  1;
accumulated_thickness                         =  h_bottom;
for inode=1:size(nodes_mid_plane,2)
    X                                         =  nodes_mid_plane(:,inode) + Lagrangian_director(:,inode)*accumulated_thickness;
    nodes_3D(:,i3D_node)                      =  X;
    i3D_node                                  =  i3D_node + 1;
end
for ilayer=1:n_layers   
    Dthickness                                =  thickness(ilayer)/degree;
    for idegree=1:degree       
        accumulated_thickness                 =  h_bottom + sum(thickness(1:ilayer-1)) + Dthickness*idegree;
        for inode=1:size(nodes_mid_plane,2)
            X                                 =  nodes_mid_plane(:,inode) + Lagrangian_director(:,inode)*accumulated_thickness; 
            nodes_3D(:,i3D_node)              =  X;
            i3D_node                          =  i3D_node + 1;
        end         
    end     
end
%--------------------------------------------------------------------------
% Connectivities of the nodes of the 3D mesh
%--------------------------------------------------------------------------
n_nodes_elem_mid_plane                        =  size(connectivity_mid_plane,1);
n_nodes_elem_1D                               =  sqrt(n_nodes_elem_mid_plane);
n_nodes_elem_3D                               =  n_nodes_elem_1D^3;
n_elem_mid_plane                              =  size(connectivity_mid_plane,2);
n_elem_3D                                     =  n_elem_mid_plane*n_layers;
connectivity_3D                               =  zeros(n_nodes_elem_3D,n_elem_3D);
accumulated                                   =  0;
addition_layer                                =  zeros(degree,n_layers);
for ilayer=1:n_layers
    n_nodes_layer                             =  size(nodes_mid_plane,2)*(degree + 1);
    accumulated                               =  accumulated + n_nodes_layer*(ilayer - 1);
    switch degree
        case 0
             addition_layer(1,ilayer)         =  size(nodes_mid_plane,2)*(ilayer-1);                  
         otherwise
             for idegree=1:degree+1
                 addition_layer(idegree,...
                 ilayer)                      =  size(nodes_mid_plane,2)*(idegree-1) + size(nodes_mid_plane,2)*degree*(ilayer-1);                  
             end            
    end
end
        
ielem_3D                                      =  1;
for ilayer=1:n_layers 
    for ielem=1:n_elem_mid_plane
        for idegree=1:degree+1
            initial                           =  size(connectivity_mid_plane,1)*(idegree - 1) + 1;
            final                             =  initial + size(connectivity_mid_plane,1) - 1;
            connectivity_3D(initial:final,...
                ielem_3D)                     =  connectivity_mid_plane(:,ielem) + addition_layer(idegree,ilayer);
        end
        ielem_3D                              =  ielem_3D + 1; 
    end
end

