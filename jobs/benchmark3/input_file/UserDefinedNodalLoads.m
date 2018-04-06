%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% We specify nodal loads
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function  [P_nodal,fixdofs]  =  UserDefinedNodalLoads(dim,load_factor,nodes,n_nodes)


%--------------------------------------------------------------------------
% Check
%--------------------------------------------------------------------------
if (size(nodes,1)==dim)  && (size(nodes,2)==n_nodes)    
else
   error('The size of the coordinates of the mesh (nodes) is not dim*n_nodes'); 
end
%--------------------------------------------------------------------------
% Determine nodes at specific location
%--------------------------------------------------------------------------
xmax               =  max(nodes(1,:));
xmin               =  min(nodes(1,:));
ymax               =  max(nodes(2,:));
ymin               =  min(nodes(2,:));

%x1                 =  (xmin+xmed)/2;
%x2                 =  xmed;
%x3                 =  (xmax+xmed)/2;
%X0                 =  [x1;ymax];
%X01                =  [x2;ymax];
%X02                =  [x3;ymax];
X01                =  [xmax;ymax];
X02                =  [xmax;ymin];
for inode=1:n_nodes
    if norm(nodes(:,inode)-X01)<1e-6
       node1        =  inode;
       break;
    end 
end
for inode=1:n_nodes
    if norm(nodes(:,inode)-X02)<1e-6
       node2        =  inode;
       break;
    end 
end
%--------------------------------------------------------------------------
% Check
%--------------------------------------------------------------------------
value              =  1e-3*load_factor;
[fixdofs,I]        =  sort([dim*node1-1; dim*node1; dim*node2-1; dim*node2]);
consval            =  [-value;-value;0*value;0*-value];
consval            =  consval(I);

n_dofs             =  size(nodes(:),1);
P_nodal            =  zeros(n_dofs,1);
P_nodal(fixdofs)   =  consval;


