function MeshOptimisationSolver(mesh,results_folder)

%--------------------------------------------------------------------------
% Solver   
%--------------------------------------------------------------------------
nodes          =  mesh.nodes(:,mesh.interior_nodes);
%func           =  @(mesh)MeshOptimisationObjFunc(mesh);
%func           =  @MeshOptimisationObjFunc;
%nodes          =  fmincon(func(mesh),nodes,[],[],[],[],[],[],[],[]);
%nodes          =  fminsearch(func(mesh),nodes);
%nodes          =  fminsearch(@(mesh)MeshOptimisationObjFunc(mesh),nodes);
%[X,FVAL,EXITFLAG,OUTPUT]          =  fminsearch(@(nodes)MeshOptimisationObjFunc(nodes,mesh),nodes,);
xmin_                  =  min(mesh.nodes(1,:));
ymin_                  =  min(mesh.nodes(1,:));
xmax_                  =  max(mesh.nodes(1,:)); 
ymax_                  =  max(mesh.nodes(2,:)); 

xmin                   =  reshape(repmat([xmin_;ymin_],size(mesh.interior_nodes,1),1),[],1);               
xmax                   =  reshape(repmat([xmax_;ymax_],size(mesh.interior_nodes,1),1),[],1);               

%options.MaxIter  =  300;
%options.MaxFunEvals  =  300;
%[X,FVAL,EXITFLAG,OUTPUT]          =  fmincon(@(nodes)MeshOptimisationObjFunc(nodes,mesh),nodes,[],[],[],[],xmin,xmax,[],options);
[X,FVAL,EXITFLAG,OUTPUT]          =  fmincon(@(nodes)MeshOptimisationObjFunc(nodes,mesh),nodes,[],[],[],[],xmin,xmax,[],[]);

%--------------------------------------------------------------------------
% Plot initial mesh
%--------------------------------------------------------------------------
subplot(1,2,1)
for ielem=1:mesh.n_elem
    nodes  =  mesh.connectivity(:,ielem);
    x12    =  [mesh.nodes(:,nodes(1))  mesh.nodes(:,nodes(2))];
    x13    =  [mesh.nodes(:,nodes(1))  mesh.nodes(:,nodes(3))];
    x24    =  [mesh.nodes(:,nodes(2))  mesh.nodes(:,nodes(4))];
    x34    =  [mesh.nodes(:,nodes(3))  mesh.nodes(:,nodes(4))];
    plot(x12(1,:),x12(2,:),'-r') 
    hold on
    plot(x13(1,:),x13(2,:),'-r') 
    hold on
    plot(x24(1,:),x24(2,:),'-r') 
    hold on   
    plot(x34(1,:),x34(2,:),'-r') 
end
title('Original mesh')
axis equal
%--------------------------------------------------------------------------
% Plot initial mesh
%--------------------------------------------------------------------------
x=mesh.nodes;
x(:,mesh.interior_nodes)  =  X;
subplot(1,2,2)
for ielem=1:mesh.n_elem
    nodes  =  mesh.connectivity(:,ielem);
    x12    =  [x(:,nodes(1))  x(:,nodes(2))];
    x13    =  [x(:,nodes(1))  x(:,nodes(3))];
    x24    =  [x(:,nodes(2))  x(:,nodes(4))];
    x34    =  [x(:,nodes(3))  x(:,nodes(4))];
    plot(x12(1,:),x12(2,:),'-r') 
    hold on
    plot(x13(1,:),x13(2,:),'-r') 
    hold on
    plot(x24(1,:),x24(2,:),'-r') 
    hold on
    plot(x34(1,:),x34(2,:),'-r') 
end    
title('Corrected mesh')
axis equal

%nodes          =  fminsearch(@(nodes)MeshOptimisationObjFunc(nodes,mesh),nodes);
% 
%  
% 
% fun = @(x)100*(x(2)-x(1)^2)^2 + (1-x(1))^2;
% [X,FVAL,EXITFLAG]          =  fminsearch(fun,[0;0]);
% 
% nodes          =  fmincon(@(mesh)MeshOptimisationObjFunc,nodes,[],[],[],[],[],[],[],[]);
% 
% 
% mesh           =  MMAMeshOptimisation(mesh);
% %--------------------------------------------------------------------------
% % Saving to spec    ific folder
% %--------------------------------------------------------------------------
% cd(fullfile(results_folder))
% save('Optimisation Results.mat','mesh')
% 
% 
% 
% 
