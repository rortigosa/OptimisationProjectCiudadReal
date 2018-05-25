%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  In this function we specify boundary conditions for the mechanical
%  physics
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function    [fixdof_u,freedof_u,...
    cons_val_u]         =  UserDefinedDirichlet(n_nodes,nodes,dim)


%--------------------------------------------------------------------------
% Check
%--------------------------------------------------------------------------
if (size(nodes,1)==dim)  && (size(nodes,2)==n_nodes)    
else
   error('The size of the coordinates of the mesh (nodes) is not dim*n_nodes'); 
end
%--------------------------------------------------------------------------
% Displacements 
%--------------------------------------------------------------------------
nodes1                  =  zeros(n_nodes,1);
presc1                  =  zeros(n_nodes,1);
nodes2                  =  zeros(n_nodes,1);
presc2                  =  zeros(n_nodes,1);
xmin                    =  min(nodes(1,:));
ymin                    =  min(nodes(2,:));
%ymax                    =  max(nodes(2,:));
% X01                     =  [xmin;ymax];
% X02                     =  [xmax;ymax];

for inode=1:n_nodes
    x                   =  nodes(:,inode);
    if norm(x(2) - ymin)<1e-6
       nodes1(inode)    =  inode;
       presc1(inode)    =  0;
    end 
    if norm(x(1) - xmin)<1e-6
       nodes2(inode)    =  inode;
       presc2(inode)    =  0;
    end 
end
%--------------------------------------------------------------------------
% Check
%--------------------------------------------------------------------------
if norm(nodes1)  == 0
   error('No node has been selected from the current mesh. Error in the definition of the Dirichlet boundary conditions for displacements'); 
end
nodes1                  =  nodes1(nodes1>0);
presc1                  =  presc1(nodes1);
nodes2                  =  nodes2(nodes2>0);
presc2                  =  presc2(nodes2);
%--------------------------------------------------------------------------
% Degrees of freedom with associated constraints
%--------------------------------------------------------------------------
dofs1x                  =  [1 + dim*(nodes1 - 1);1+ dim*(nodes2 - 1)];  %  Select direction X for set 1
dofs1y                  =  2 + dim*(nodes1 - 1);  %  Select direction Y for set 1

freedof_u               =  (1:dim*n_nodes)';
[fixdof_u,order]        =  sort([dofs1x;dofs1y]);
freedof_u(fixdof_u)     =  [];
%--------------------------------------------------------------------------
% Degrees of freedom with associated constraints 
%--------------------------------------------------------------------------
presc1x                 =  [presc1;presc2];
presc1y                 =  presc1;

prescribed              =  [presc1x;presc1y];
prescribed              =  prescribed(order);
cons_val_u              =  prescribed;

