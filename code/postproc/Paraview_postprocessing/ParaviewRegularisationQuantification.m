function  ParaviewRegularisationQuantification(Geometry,Mesh,FEM,MatInfo,Solution,...
                      Quadrature,Optimisation,visibility,filename)

%--------------------------------------------------------------------------
% Cut-off for densities
%--------------------------------------------------------------------------
rho                =  Optimisation.density;
if visibility==0
   cutoff_density  =  Optimisation.Volfrac;
else
   cutoff_density  =  0;
end    
%--------------------------------------------------------------------------
% Obtain the regularisation parameter per element (average)
%--------------------------------------------------------------------------
Reg_parameter         =  RegularisationQuantification(Geometry,Mesh,FEM,...
                                               Quadrature,MatInfo,Solution);
%--------------------------------------------------------------------------
% Post-processing shape functions
%--------------------------------------------------------------------------                                          
Quadrature.Chi        =  NodesIsoparametricSpace(Geometry.dim,1);
[N,DN_chi]            =  ShapeFunctionsPostprocessing(Geometry.dim);
FEM.postproc.N        =  N;
FEM.postproc.DN_chi   =  DN_chi;
FEM.postproc          =  MaterialGradientShapeFunctions(Geometry,FEM.postproc,Quadrature.volume.bilinear,Solution,Mesh.volume.x);
%--------------------------------------------------------------------------
% Post-processing mesh
%--------------------------------------------------------------------------                                          
n_elem                =  size(rho(rho>cutoff_density),1);
n_nodes               =  2^Geometry.dim*n_elem;
connectivity          =  reshape((1:n_nodes)',2^Geometry.dim,[]);
%--------------------------------------------------------------------------
%  Initialise postprocessing variables 
%--------------------------------------------------------------------------
local_ordering        =  local_ordering_nodes(Geometry.dim);                                                            
x_solid               =  zeros(Geometry.dim,n_nodes);
X_solid               =  zeros(Geometry.dim,n_nodes);
Regularisation_solid  =  zeros(n_nodes,1);
%--------------------------------------------------------------------------
%  Loop over elements 
%--------------------------------------------------------------------------
final                 =  0;
for ielem=1:Mesh.volume.n_elem
    if rho(ielem)>cutoff_density
    %----------------------------------------------------------------------
    % x and X of the postprocessing mesh mesh 
    %----------------------------------------------------------------------
    xelem               =  zeros(Geometry.dim,2^Geometry.dim);
    Xelem               =  zeros(Geometry.dim,2^Geometry.dim);
    for inode=1:2^Geometry.dim
        xelem(:,inode)  =  Solution.x.Eulerian_x(:,Mesh.volume.x.connectivity(:,ielem))*FEM.postproc.N(:,inode);
        Xelem(:,inode)  =  Solution.x.Lagrangian_X(:,Mesh.volume.x.connectivity(:,ielem))*FEM.postproc.N(:,inode);        
    end
    %----------------------------------------------------------------------
    % First Piola-Kirchhoff stress tensor.  
    %----------------------------------------------------------------------
    initial             =  final + 1;
    final               =  final + 2^Geometry.dim;
    x_solid(:,initial:final)      =  xelem(:,local_ordering);
    X_solid(:,initial:final)      =  Xelem(:,local_ordering);
    Regularisation_solid(initial:final)  =  repmat(Reg_parameter(ielem),size(Mesh.volume.x.connectivity(:,ielem),1),1);
    end
end
%--------------------------------------------------------------------------
% Call paraview
%--------------------------------------------------------------------------
if n_elem>0
   if Geometry.dim==2
      x_solid(3,:)    =  0;
   end    
   Reg_solid          =  reshape(Regularisation_solid,[],1);    
   VTKPlot(filename,'unstructured_grid',x_solid',connectivity','scalars','Regularisation',Reg_solid) 
end
   

function local_ordering               =  local_ordering_nodes(dim)                                                            
    if dim==2
       local_ordering                 =  [1 2 4 3];    
    elseif dim==3
       local_ordering                 =  [1 2 4 3 5 6 8 7];    
    end
end


end