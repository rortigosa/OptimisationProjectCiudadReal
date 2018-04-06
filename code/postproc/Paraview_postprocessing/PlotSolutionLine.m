function PlotSolutionLine(mesh_field,solution_field,coordinate,dof)
%--------------------------------------------------------------------------
% Electric potential in the boundary
%--------------------------------------------------------------------------
count                =   0;
for inode=1:mesh_field.n_nodes
    x                =  mesh_field.nodes(:,inode);
    if abs(x(dof) - coordinate)<1e-6
       count         =  count + 1;
    end
end
nodes                =  zeros(count,1);
count                =   0;
for inode=1:mesh_field.n_nodes
    x                =  mesh_field.nodes(:,inode);
    if abs(x(dof) - coordinate)<1e-6
       count         =  count + 1;
       nodes(count)  =  inode;
    end
end

if dof==1
   Ndof              =  2;
else
   Ndof              =  1;
end
plot(mesh_field.nodes(Ndof,nodes),solution_field(nodes),'-o')