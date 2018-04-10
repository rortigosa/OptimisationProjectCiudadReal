function  ParaviewEnergy(Geometry,Mesh,FEM,MatInfo,Solution,...
                      Quadrature,Optimisation,visibility,filename)

%--------------------------------------------------------------------------
% Cut-off for densities
%--------------------------------------------------------------------------
rho                   =  Optimisation.density;
if visibility==0
   cutoff_density     =  Optimisation.Volfrac;
else
   cutoff_density     =  0;
end    
%--------------------------------------------------------------------------
% Compute the three energies per element
%--------------------------------------------------------------------------
[Energy,EnergyLin,EnergyReg,...
 ~,~,~,...
 EnergySolid,EnergyLinSolid,EnergyRegSolid,...
 ~,~,~]        =  EnergyEvolutionOptimisation(Geometry,Mesh,FEM,...
                                 MatInfo,Solution,Quadrature,Optimisation);
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
Energy_solid          =  zeros(n_nodes,1);
EnergyLin_solid       =  zeros(n_nodes,1);
EnergyReg_solid       =  zeros(n_nodes,1);
EnergySolid_solid     =  zeros(n_nodes,1);
EnergyLinSolid_solid  =  zeros(n_nodes,1);
EnergyRegSolid_solid  =  zeros(n_nodes,1);
EnergyDiff_solid      =  zeros(n_nodes,1);
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
    x_solid(:,initial:final)        =  xelem(:,local_ordering);
    X_solid(:,initial:final)        =  Xelem(:,local_ordering);
    Energy_solid(initial:final)     =  repmat(Energy(ielem),size(Mesh.volume.x.connectivity(:,ielem),1),1);
    EnergyLin_solid(initial:final)  =  repmat(EnergyLin(ielem),size(Mesh.volume.x.connectivity(:,ielem),1),1);
    EnergyReg_solid(initial:final)  =  repmat(EnergyReg(ielem),size(Mesh.volume.x.connectivity(:,ielem),1),1);

    EnergySolid_solid(initial:final)     =  repmat(EnergySolid(ielem),size(Mesh.volume.x.connectivity(:,ielem),1),1);
    EnergyLinSolid_solid(initial:final)  =  repmat(EnergyLinSolid(ielem),size(Mesh.volume.x.connectivity(:,ielem),1),1);
    EnergyRegSolid_solid(initial:final)  =  repmat(EnergyRegSolid(ielem),size(Mesh.volume.x.connectivity(:,ielem),1),1);

    EnergyDiff_solid(initial:final)  =  repmat(EnergySolid_solid(ielem) - EnergyRegSolid_solid(ielem),size(Mesh.volume.x.connectivity(:,ielem),1),1);
    
    end
end
%--------------------------------------------------------------------------
% Call paraview 
%--------------------------------------------------------------------------
if n_elem>0
   if Geometry.dim==2
      x_solid(3,:)    =  0;
   end    
   E_solid            =  reshape(Energy_solid,[],1);    
   ELin_solid         =  reshape(EnergyLin_solid,[],1);    
   EReg_solid         =  reshape(EnergyReg_solid,[],1);    
   ESolid_solid       =  reshape(EnergySolid_solid,[],1);    
   ELinSolid_solid    =  reshape(EnergyLinSolid_solid,[],1);     
   ERegSolid_solid    =  reshape(EnergyRegSolid_solid,[],1);    
   EDiff_solid        =  reshape(EnergyDiff_solid,[],1);    
   VTKPlot(filename,'unstructured_grid',x_solid',connectivity',...
                    'scalars','Energy',E_solid/norm(E_solid)*100,...
                    'scalars','Energy_Lin',ELin_solid/norm(E_solid)*100,...
                    'scalars','Energy_Reg',EReg_solid/norm(E_solid)*100,... 
                    'scalars','EnergySolid',ESolid_solid/norm(ESolid_solid)*100,...
                    'scalars','EnergySolid_Lin',ELinSolid_solid/norm(ESolid_solid)*100,...
                    'scalars','EnergySolid_Reg',ERegSolid_solid/norm(ESolid_solid)*100,...
                    'scalars','EDiff',(EDiff_solid./max(ESolid_solid))*100) 
end
   

function local_ordering               =  local_ordering_nodes(dim)                                                            
    if dim==2
       local_ordering                 =  [1 2 4 3];    
    elseif dim==3
       local_ordering                 =  [1 2 4 3 5 6 8 7];    
    end
end


end