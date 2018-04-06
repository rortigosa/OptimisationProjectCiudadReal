%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In this function we analyse all the elements of the mesh. We pay
% attention to aspects concerning the mesh of all the elements. We build
% for example the bounds for the coordinates of the nodes of an element,
% getting what is called the Characteristic_Cube of the element;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function mesh_information                      =  mesh_parameters_analysis(n_elem,connectivity,nodes)

dim                                            =  size(nodes,2);
mesh_information.Characteristic_Cube           =  zeros(dim,2,n_elem);    

for ielem=1:n_elem
    nodes_elem                                 =  connectivity(ielem,:);
    Xelem                                      =  nodes(nodes_elem,:)';    
    mesh_information.Characteristic_Cube(:,...
          :,ielem)                             =  [min(Xelem')'  max(Xelem')'];  %  I store the minimum and maximum values of the                                                                                          
                                                                                 %  X,Y,Z coordinates of the cube.                                                                                  
    L                                          =  mesh_information.Characteristic_Cube(:,1,ielem)- mesh_information.Characteristic_Cube(:,2,ielem);
    mesh_information.Characteristic_length(ielem,...
        1)                                     =  sqrt(L'*L);
    mesh_information.infimum_length(ielem,...
                         1)                    =  sqrt(L'*L);
            
    
end

mesh_information.Cube                      =  [];
mesh_information.Cube(1,:)                 =  [min(nodes(:,1))  max(nodes(:,1))]; 
mesh_information.Cube(2,:)                 =  [min(nodes(:,2))  max(nodes(:,2))]; 
switch dim
    case 3
mesh_information.Cube(3,:)                 =  [min(nodes(:,3))  max(nodes(:,3))];              
end
mesh_information.Cube                      =  mesh_information.Cube';

