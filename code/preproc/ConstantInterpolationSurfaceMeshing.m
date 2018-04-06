function boundary_nodes       =  ConstantInterpolationSurfaceMeshing(dim,boundary_edges,phi_nodes)

n_edges                       =  size(boundary_edges,2);
boundary_nodes                =  zeros(dim,n_edges);
for iedge=1:n_edges
     phi_nodes_edge           =  phi_nodes(:,boundary_edges(:,iedge));
     xcenter                  =  sum(phi_nodes_edge,2)/size(phi_nodes_edge,2);
     boundary_nodes(:,iedge)  =  xcenter;
end