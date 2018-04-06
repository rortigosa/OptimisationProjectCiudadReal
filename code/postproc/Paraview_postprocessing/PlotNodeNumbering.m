function PlotNodeNumbering(nodes)

n_nodes  =  size(nodes,2);
dim      =  size(nodes,1);

switch dim
    case 2
        for inode=1:n_nodes
            x    =  nodes(:,inode);
            plot(x(1),x(2),'o')
            hold on
            text_plot_information(x,inode);
        end
    case 3
        for inode=1:n_nodes
            x    =  nodes(:,inode);
            plot3(x(1),x(2),x(3),'o')
            hold on
            text_plot_information(x,inode);
        end
end
    