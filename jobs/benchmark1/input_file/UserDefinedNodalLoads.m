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
ymax               =  max(nodes(2,:));
ymin               =  min(nodes(2,:));
ymed               =  0.5*(ymax + ymin);
X0                 =  [xmax;ymed];
%X0                =  [xmax;ymin];
node_number        =  0;
for inode=1:n_nodes
    if norm(nodes(:,inode)-X0)<1e-6
       node        =  inode;
       node_number =  inode;
       break;
    end 
end
%--------------------------------------------------------------------------
% Check
%--------------------------------------------------------------------------
if node_number  == 0
   error('No node has been selected from the current mesh. Error in the definition of the Dirichlet boundary conditions for displacements'); 
end

%value              =  0.5e-3*load_factor;
value              =  1e-3*load_factor;
fixdofs            =  [dim*node-1; dim*node];
consval            =  [-0*value/10; value];

n_dofs             =  size(nodes(:),1);
P_nodal            =  zeros(n_dofs,1);
P_nodal(fixdofs)   =  consval;


