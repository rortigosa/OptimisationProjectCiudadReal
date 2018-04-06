function  ParaviewPostprocessor(Geometry,Mesh,FEM,MatInfo,Solution,...
                      Quadrature,Optimisation,PostProc,visibility,filename)


                  
   
if visibility==0
   cutoff_density  =  Optimisation.Volfrac;
else
   cutoff_density  =  0;
end
    

Quadrature.Chi   =  NodesIsoparametricSpace(Geometry.dim,1);
[N,DN_chi]       =  ShapeFunctionsPostprocessing(Geometry.dim);
FEM.postproc.N        =  N;
FEM.postproc.DN_chi   =  DN_chi;
FEM.postproc        =  MaterialGradientShapeFunctions(Geometry.dim,FEM.postproc,Quadrature.volume.bilinear,Solution,Mesh.volume.x);

rho                =  Optimisation.density;
penalty            =  Optimisation.penalty;
rhop               =  rho.^penalty;

local_ordering                        =  local_ordering_nodes(Geometry.dim);                                                            
%n_elem                               =  Mesh.volume.n_elem;
n_elem                                =  size(rho(rho>cutoff_density),1);
n_nodes                               =  2^Geometry.dim*n_elem;
%connectivity                         =  reshape((1:n_nodes)',2^3,[]);
connectivity                          =  reshape((1:n_nodes)',2^Geometry.dim,[]);
%--------------------------------------------------------------------------
%  Initialise postprocessing variables 
%--------------------------------------------------------------------------
x_solid                               =  zeros(Geometry.dim,n_nodes);
X_solid                               =  zeros(Geometry.dim,n_nodes);
%F_solid                              =  zeros(Geometry.dim^2,n_nodes);
p_solid                               =  zeros(n_nodes,1);
%--------------------------------------------------------------------------
%  Loop over elements 
%--------------------------------------------------------------------------
final                                 =  0;
for ielem=1:Mesh.volume.n_elem
    if rho(ielem)>cutoff_density
    %----------------------------------------------------------------------
    % x and X of the postprocessing mesh mesh 
    %----------------------------------------------------------------------
    xelem                             =  zeros(Geometry.dim,2^Geometry.dim);
    Xelem                             =  zeros(Geometry.dim,2^Geometry.dim);
    for inode=1:2^Geometry.dim
        xelem(:,inode)                =  Solution.x.Eulerian_x(:,Mesh.volume.x.connectivity(:,ielem))*FEM.postproc.N(:,inode);
        Xelem(:,inode)                =  Solution.x.Lagrangian_X(:,Mesh.volume.x.connectivity(:,ielem))*FEM.postproc.N(:,inode);        
    end
    %----------------------------------------------------------------------
    % Gradients in the nodes of the postprocessing mesh
    %----------------------------------------------------------------------
    [F,H,J]         =  KinematicsFunctionFinalMexC(xelem,Xelem,FEM.postproc.DN_X);
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    Piola           =  rhop(ielem)*MooneyRivlinMexC(MatInfo.mu1,MatInfo.mu2,...
                                        MatInfo.lambda,F,H,J);       
    %----------------------------------------------------------------------
    % Compute Cauchy
    %----------------------------------------------------------------------
    FT           =  permute(F,[2 1 3]);
    Cauchy       =  MatrixMatrixMultiplication(Geometry.dim,Geometry.dim,2^Geometry.dim,Piola,FT);    
    Cauchy       =  MatrixScalarMultiplication(Geometry.dim,Geometry.dim,2^Geometry.dim,Cauchy,1./J);
    %----------------------------------------------------------------------
    % First Piola-Kirchhoff stress tensor.
    %----------------------------------------------------------------------
    pressure     =  TraceGauss(Cauchy,2^Geometry.dim);
    %----------------------------------------------------------------------
    % First Piola-Kirchhoff stress tensor.  
    %----------------------------------------------------------------------
        initial                       =  final + 1;
 %       final                         =  final + 2^3;
       final                         =  final + 2^Geometry.dim;

%        if Geometry.dim==2
%           xelem      =  [xelem xelem]; 
%           Xelem      =  [xelem xelem];  
%           pressure   =  [pressure; pressure]; 
%        end
        
        x_solid(:,initial:final)      =  xelem(:,local_ordering);
        X_solid(:,initial:final)      =  Xelem(:,local_ordering);
        p_solid(initial:final)        =  pressure(local_ordering);
    end
end

if n_elem>0
if Geometry.dim==2
    %----------------------------------------------------------------------
    % 2D postprocessing
    %----------------------------------------------------------------------
    ux                                    =  reshape(x_solid(1,:) - X_solid(1,:),[],1);
    uy                                    =  reshape(x_solid(2,:) - X_solid(2,:),[],1);
%     Fxx                                   =  reshape(F_solid(1,:),[],1);
%     Fyx                                   =  reshape(F_solid(2,:),[],1);
%     Fxy                                   =  reshape(F_solid(3,:),[],1);
%     Fyy                                   =  reshape(F_solid(4,:),[],1);
    p                                     =  reshape(p_solid,[],1);    
%     VTKPlot(filename,'unstructured_grid',x_solid',connectivity','scalars','ux',ux,...
%                                                                 'scalars','uy',uy,...
%                                                                 'scalars','Fxx',Fxx,...
%                                                                 'scalars','Fxy',Fxy,...
%                                                                 'scalars','Fyx',Fyx,...
%                                                                 'scalars','Fyy',Fyy,...
%                                                                 'scalars','p',p) 
x_solid(3,:) = 0;
    VTKPlot(filename,'unstructured_grid',x_solid',connectivity','scalars','ux',ux,...
                                                                'scalars','uy',uy,...
                                                                 'scalars','p',p) 
else
    %----------------------------------------------------------------------
    % 3D postprocessing
    %----------------------------------------------------------------------    
    ux                                    =  reshape(x_solid(1,:) - X_solid(1,:),[],1);
    uy                                    =  reshape(x_solid(2,:) - X_solid(2,:),[],1);
    uz                                    =  reshape(x_solid(3,:) - X_solid(3,:),[],1);
    p                                     =  reshape(p_solid,[],1);
  
    VTKPlot(filename,'unstructured_grid',x_solid',connectivity','scalars','ux',ux,...
                                                                'scalars','uy',uy,...
                                                                'scalars','uz',uz,...
                                                                'scalars','p',p) 
end    
end
                                                            
function local_ordering               =  local_ordering_nodes(dim)                                                            
    if dim==2
       local_ordering                 =  [1 2 4 3];    
    elseif dim==3
       local_ordering                 =  [1 2 4 3 5 6 8 7];    
    end
end

end