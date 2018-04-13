
%--------------------------------------------------------------------------
% Connectivity
%--------------------------------------------------------------------------
connectivity                =  [Mesh.volume.x.connectivity  Mesh.volume.x.connectivity+Mesh.volume.x.n_nodes];
Mesh.volume.x.connectivity  =  connectivity;
Mesh.volume.n_elem          =  size(connectivity,2);
%--------------------------------------------------------------------------
% New Solution field
%--------------------------------------------------------------------------
x_                          =  Solution.x.Eulerian_x;
x_(1,:)                     =  x_(1,:) - min(Mesh.volume.x.nodes(1,:));
x_(1,:)                     =  -x_(1,:);
x_reflect                   =  x_;
x_reflect(1,:)              =  x_(1,:) + min(Mesh.volume.x.nodes(1,:));
Solution.x.Eulerian_x       =  [Solution.x.Eulerian_x x_reflect];

X_                          =  Solution.x.Lagrangian_X;
X_(1,:)                     =  X_(1,:) - min(Mesh.volume.x.nodes(1,:));
X_(1,:)                     =  -X_(1,:);
X_reflect                   =  X_;
X_reflect(1,:)              =  X_(1,:) + min(Mesh.volume.x.nodes(1,:));
Solution.x.Lagrangian_X     =  [Solution.x.Lagrangian_X  X_reflect];
%--------------------------------------------------------------------------
% Density
%--------------------------------------------------------------------------
Optimisation.density        =  [Optimisation.density; Optimisation.density];
%--------------------------------------------------------------------------
% New coordinates
%--------------------------------------------------------------------------
nodes_                      =  Mesh.volume.x.nodes;
nodes_(1,:)                 =  nodes_(1,:) - min(Mesh.volume.x.nodes(1,:));
nodes_(1,:)                 =  -nodes_(1,:);
nodes_reflect               =  nodes_;
nodes_reflect(1,:)          =  nodes_(1,:) + min(Mesh.volume.x.nodes(1,:));
Mesh.volume.x.nodes         =  [Mesh.volume.x.nodes  nodes_reflect];  
%--------------------------------------------------------------------------
% Call paraview to visualise the Mesh
%--------------------------------------------------------------------------
Eulerian_x_            =  Solution.x.Eulerian_x;
filename               =  'TheMesh.vtk';
Solution.x.Eulerian_x  =  Solution.x.Lagrangian_X;
ParaviewPostprocessor(Geometry,Mesh,FEM,MatInfo,Solution,...
                      Quadrature,Optimisation,PostProc,1,filename)                  
%--------------------------------------------------------------------------
% Visualise final design
%--------------------------------------------------------------------------
filename               =  'TheDesign.vtk';
Solution.x.Eulerian_x  =  Solution.x.Lagrangian_X;
ParaviewPostprocessor(Geometry,Mesh,FEM,MatInfo,Solution,...
                      Quadrature,Optimisation,PostProc,0,filename)
                                    
%--------------------------------------------------------------------------
% Deformed configurations
%--------------------------------------------------------------------------
filename               =  'TheSolution.vtk';
Solution.x.Eulerian_x  =  Eulerian_x_;
ParaviewPostprocessor(Geometry,Mesh,FEM,MatInfo,Solution,...
                      Quadrature,Optimisation,PostProc,0,filename)
                                    
                  
                  
                  
                  
                  