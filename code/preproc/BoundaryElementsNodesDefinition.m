function [boundary_edges,volume_elements,...
    boundary_nodes]            =  BoundaryElementsNodesDefinition(degree,connectivity,element_type,dim)   
%--------------------------------------------------------------------------
% Select nodes of the edges (or faces) of the element
%--------------------------------------------------------------------------
switch dim
    case 2
        switch element_type
            case 1
                 local_edges   =  LocalEdgesQuadDefinition(degree);
            case 0
                 local_edges   =  LocalEdgesTriaDefinition(degree);
        end
    case 3
        switch element_type
            case 1
                 local_edges   =  LocalEdgesHexaDefinition(degree);
            case 0
                 local_edges   =  LocalEdgesTetDefinition(degree);
        end        
end
%--------------------------------------------------------------------------
% Construct all the vertices for all the elements in the mesh
%--------------------------------------------------------------------------
n_elem                          =  size(connectivity,2);
edges                           =  zeros(size(local_edges,1)+1,n_elem*size(local_edges,2));
edge_number                     =  1;
for ielem=1:n_elem
    for iedge=1:size(local_edges,2)
        local_node              =  local_edges(:,iedge);
        edges(1:end-1,edge_number)    =  connectivity(local_node,ielem);
        edges(end,edge_number)  =  ielem;
        edge_number             =  edge_number + 1;
    end 
end 
%newedges                       =  zeros(size(edges,2),size(edges,1)-1);
aux                             =  edges';
aux                             =  sort(aux(:,1:end-1),2);
newedges                        =  aux;  
%newedges(:,end)                 =  edges(end,:)';
%--------------------------------------------------------------------------
% Detect unique vertices 
%--------------------------------------------------------------------------
[a,b,c]                       =  unique(newedges(:,1:end),'rows');
unique_edges                  =  a;
n_repeated_edges              =  accumarray(c,1);
 
list                          =  [unique_edges  n_repeated_edges];
k                             =  0;
for i=1:size(list,1)
    if list(i,end)==1
       k                      =  k + 1;
    end
end
unique_edges_number           =  zeros(k,1);
unique_edges                  =  zeros(k,size(list,2)-1);
k                             =  0;
for i=1:size(list,1)
    if list(i,end)==1
       k                      =  k + 1;
       unique_edges(k,:)      =  list(i,1:end-1);
       unique_edges_number(k) =  i;
    end 
end
boundary_edges                =  unique_edges';
boundary_nodes                =  sort(unique(unique_edges(:)));
%--------------------------------------------------------------------------
% Elements that the edges belong to
%--------------------------------------------------------------------------
volume_elements               =  edges(end,b(unique_edges_number));
end

%--------------------------------------------------------------------------
% Edges for quad elements
%--------------------------------------------------------------------------
function local_edges_quad =  LocalEdgesQuadDefinition(degree)
edge1             =  1:degree+1;
edge2             =  (degree + 1)*(degree)+1:(degree + 1)^2;
edge3             =  1:degree+1:degree*(degree + 1)+1;
edge4             =  degree+1:degree+1:(degree + 1)^2;
local_edges_quad  =  [edge1' edge2' edge3' edge4'];
end
%--------------------------------------------------------------------------
% Edges for hexahedral elements
%--------------------------------------------------------------------------
function local_edges_hexa =  LocalEdgesHexaDefinition(degree)
edge1             =  1:(degree+1)^2;
edge2             =  (degree + 1)*(degree + 1)*degree + 1:(degree + 1)^3;
edge3             =  1:degree+1:degree*(degree + 1)^2 + degree*(degree + 1) + 1;
edge4             =  degree + 1:degree+1:(degree + 1)^3;
edge5             =  reshape(repmat((1:(degree + 1))',1,degree + 1) + repmat((0:(degree + 1)^2:(degree + 1)^2*degree),degree+1,1),1,[]);
edge6             =  reshape(repmat(((degree + 1)*degree + 1:(degree + 1)^2)',1,degree + 1) + repmat((0:(degree + 1)^2:(degree + 1)^2*degree),degree+1,1),1,[]);
local_edges_hexa  =  [edge1' edge2' edge3' edge4' edge5' edge6'];
end
%--------------------------------------------------------------------------
% Edges for triangular elements
%--------------------------------------------------------------------------
function local_edges_tria    =  LocalEdgesTriaDefinition(degree)
local_edges_quad             =  LocalEdgesQuadDefinition(degree);

local_edges_tria             =  zeros(degree+1,3);
local_edges_tria(:,1)        =  local_edges_quad(:,1);
local_edges_tria(:,2)        =  local_edges_quad(:,4);
local_edges_tria(:,3)        =  local_edges_quad(:,3);

n_elements                   =  length(local_edges_tria);
substraction                 =  zeros(n_elements - 1,1);
for ielements=2:n_elements
    substraction(ielements)  =  substraction(ielements - 1) + (ielements - 1);
end
local_edges_tria(:,2)        =  local_edges_tria(:,2) - substraction;

n_elements                   =  length(local_edges_tria);
substraction                 =  zeros(n_elements - 1,1);
for ielements=3:n_elements
    substraction(ielements)  =  substraction(ielements - 1) + (ielements - 2);
end
local_edges_tria(:,3)        =  local_edges_tria(:,3) - substraction;
end
%--------------------------------------------------------------------------
% Edges for triangular elements
%--------------------------------------------------------------------------
function local_edges_tet     =  LocalEdgesTetDefinition(degree)
switch degree
    case 1
         local_edges_tet(:,1)   =  [1 2 3];
         local_edges_tet(:,2)   =  [1 2 4];
         local_edges_tet(:,3)   =  [1 3 4];
         local_edges_tet(:,4)   =  [2 3 4];
    case 2
         local_edges_tet(:,1)   =  [1 2 3 4 5 6];
         local_edges_tet(:,2)   =  [1 2 3 7 9 10];
         local_edges_tet(:,3)   =  [1 4 6 7 9 10];
         local_edges_tet(:,4)   =  [3 5 7 8 9 10];
    case 3
         local_edges_tet(:,1)   =  [1 2 3 4 5 6 7 8 9 10];
         local_edges_tet(:,2)   =  [1 2 3 4 11 12 13 17 18 20];
         local_edges_tet(:,3)   =  [1 5 8 10 11 14 16 17 19 20];
         local_edges_tet(:,4)   =  [4 7 9 10 13 15 16 18 19 20];
end

end