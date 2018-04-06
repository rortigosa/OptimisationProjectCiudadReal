%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% We specify nodal loads
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function  [P_nodal,fixdofs]  =  UserDefinedNodalLoads(nodes,n_nodes,dim,load_factor)


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
ymin               =  min(nodes(2,:));
ymax               =  max(nodes(2,:));
X01                =  [xmax;ymin];
X02                =  [xmax;ymax];
node_number1       =  0;
node_number2       =  0;
for inode=1:n_nodes
    if norm(nodes(:,inode)-X01)<1e-6
       node1         =  inode;
       node_number1 =  inode;
       break;
    end 
end
for inode=1:n_nodes
    if norm(nodes(:,inode)-X02)<1e-6
       node2        =  inode;
       node_number2 =  inode;
       break;
    end 
end
%--------------------------------------------------------------------------
% Check
%--------------------------------------------------------------------------
if node_number1  == 0
   error('No node has been selected from the current mesh. Error in the definition of the Dirichlet boundary conditions for displacements'); 
end
if node_number2  == 0
   error('No node has been selected from the current mesh. Error in the definition of the Dirichlet boundary conditions for displacements'); 
end

value               =  sqrt(2)*2*1e-3*load_factor;
fixdofs1            =  [dim*node1 - 1; dim*node1];
consval1            =  [value; -value];
fixdofs2            =  [dim*node2 - 1; dim*node2];
consval2            =  [value; value];

n_dofs              =  size(nodes(:),1);
P_nodal             =  zeros(n_dofs,1);
P_nodal(fixdofs1)   =  consval1;
P_nodal(fixdofs2)   =  consval2;
fixdofs             =  [fixdofs1;fixdofs2];

