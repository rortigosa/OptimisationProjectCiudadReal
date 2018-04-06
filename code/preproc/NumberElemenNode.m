
function rep_indices  =  NumberElemenNode(n_nodes,connectivity)

rep_indices  =  zeros(n_nodes,1);
for ielem=1:size(connectivity,2)
    nodes               =  connectivity(:,ielem);
    rep_indices(nodes)  =  rep_indices(nodes) + 1;
end