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
ymax               =  max(nodes(2,:));

n_nodes    =  0;
for inode=1:size(nodes,2)
    x                   =  nodes(:,inode);
    if norm(x(2) - ymax)<1e-6
        n_nodes  =  n_nodes + 1;
    end 
end


nodes1             =  zeros(n_nodes,1);
presc1             =  zeros(n_nodes,1);
for inode=1:size(nodes,2)
    x                   =  nodes(:,inode);
    if norm(x(2) - ymax)<1e-6
       nodes1(inode)    =  inode;
       presc1(inode)    =  0;
    end 
end 
nodes1   =  nodes1(nodes1>0);

%--------------------------------------------------------------------------
% Check
%--------------------------------------------------------------------------
value              =  -3.875968992248062e-02*4*load_factor*1;
fixdofs            =  dim*nodes1;
consval            =  value; 

n_dofs             =  size(nodes(:),1);
P_nodal            =  zeros(n_dofs,1);
P_nodal(fixdofs)   =  consval;


