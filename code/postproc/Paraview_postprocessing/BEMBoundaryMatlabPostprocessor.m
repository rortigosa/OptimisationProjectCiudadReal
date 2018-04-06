function BEMBoundaryMatlabPostprocessor(str)
%--------------------------------------------------------------------------
% Electric potential in the boundary
%--------------------------------------------------------------------------
count_inf      =   0;
count_sup      =   0;
count_left     =   0;
count_right    =   0;

for iedge=1:size(str.mesh.surface.phi.boundary_edges,2)
    edge_nodes  =  str.mesh.surface.phi.boundary_edges(:,iedge);
    xedge       =  str.mesh.volume.phi.nodes(:,edge_nodes);
    for inode=1:size(xedge,1)
        x                =  xedge(:,inode);
        if abs(x(2) + 0.5)<1e-6
            count_inf    =  count_inf + 1;
            inf_nodes(count_inf)  =  edge_nodes(inode);
        end
        if abs(x(2) - 0.5)<1e-6
            count_sup    =  count_sup + 1;
            sup_nodes(count_sup)  =  edge_nodes(inode);
        end
        if abs(x(1) + 0.5)<1e-6
            count_left    =  count_left + 1;
            left_nodes(count_left)  =  edge_nodes(inode);
        end
        if abs(x(1) - 0.5)<1e-6
            count_right    =  count_right + 1;
            right_nodes(count_right)  =  edge_nodes(inode);
        end
    end
end
phiinf      =  str.solution.phi(inf_nodes);
phisup      =  str.solution.phi(sup_nodes);
phileft     =  str.solution.phi(left_nodes);
phiright    =  str.solution.phi(right_nodes);

figure(1)
subplot(2,2,1)
plot(str.mesh.volume.phi.nodes(1,inf_nodes),phiinf,'-o')
title('Potential in lower surface')
subplot(2,2,2)
plot(str.mesh.volume.phi.nodes(1,sup_nodes),phisup,'-o')
title('Potential in upper surface')
subplot(2,2,3)
plot(str.mesh.volume.phi.nodes(2,left_nodes),phileft,'-o')
title('Potential in left surface')
subplot(2,2,4)
plot(str.mesh.volume.phi.nodes(2,right_nodes),phiright,'-o')
title('Potential in right surface')

%--------------------------------------------------------------------------
% Electric flux in the boundary
%--------------------------------------------------------------------------
count_inf      =   0;
count_sup      =   0;
count_left     =   0;
count_right    =   0;
inf_nodes      =  [];
sup_nodes      =  [];
left_nodes     =  [];
right_nodes    =  [];

for iq=1:str.mesh.surface.q.n_nodes
    x  =  str.mesh.surface.q.nodes(:,iq);
    if abs(x(2) + 0.5)<1e-6
        count_inf    =  count_inf + 1;
        inf_nodes(count_inf)  =  iq;
    end
    if abs(x(2) - 0.5)<1e-6
        count_sup    =  count_sup + 1;
        sup_nodes(count_sup)  =  iq;
    end
    if abs(x(1) + 0.5)<1e-6
        count_left    =  count_left + 1;
        left_nodes(count_left)  =  iq;
    end
    if abs(x(1) - 0.5)<1e-6
        count_right    =  count_right + 1;
        right_nodes(count_right)  =  iq;
    end
end
qinf      =  str.solution.q(inf_nodes);
qsup      =  str.solution.q(sup_nodes);
qleft     =  str.solution.q(left_nodes);
qright    =  str.solution.q(right_nodes);
figure(2)
subplot(2,2,1)
plot(str.mesh.surface.q.nodes(1,inf_nodes),qinf,'-o')
title('Flux in lower surface')
subplot(2,2,2)
plot(str.mesh.surface.q.nodes(1,sup_nodes),qsup,'-o')
title('Flux in upper surface')
subplot(2,2,3)
plot(str.mesh.surface.q.nodes(2,left_nodes),qleft,'-o')
title('Flux in left surface')
subplot(2,2,4)
plot(str.mesh.surface.q.nodes(2,right_nodes),qright,'-o')
title('Flux in right surface')






