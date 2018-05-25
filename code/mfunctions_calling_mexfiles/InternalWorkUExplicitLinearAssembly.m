%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assembly of the residual and stiffness matrix of the system.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Assembly    =  InternalWorkUExplicitLinearAssembly(formulation,...
                            Geometry,Mesh,FEM,Quadrature,Assembly,...
                            MatInfo,Optimisation,Solution)
%--------------------------------------------------------------------------
% Extract from the structures   
%--------------------------------------------------------------------------
void_factor             =  Optimisation.void_factor; 
rho_p                   =  Optimisation.density_p;
 
x                       =  Solution.x.Eulerian_x;
X                       =  Solution.x.Lagrangian_X;
Klinear                 =  MatInfo.Klinear;
%--------------------------------------------------------------------------
% Internal residual
%--------------------------------------------------------------------------
TInternal               = AssemblyCentralDifferenceLinearUFormulationMexC10(Geometry.dim,...
                                Mesh.volume.x.n_node_elem,Mesh.volume.x.n_nodes,...
                                Mesh.volume.n_elem,void_factor,rho_p,...
                                Mesh.volume.x.connectivity,x,X,Klinear);
%--------------------------------------------------------------------------
% Sparse assembly of the residual.             
%--------------------------------------------------------------------------
TInertial              =  Assembly.MassMatrix*Solution.x.acceleration(:);
TDamping               =  Assembly.DampingMatrix*Solution.x.velocity(:);
Assembly.total_force   =  TInternal + TInertial + TDamping;                              

end


% tic 
% for ielem=1:Mesh.volume.n_elem  
%     %----------------------------------------------------------------------
%     % kinematics
%     %----------------------------------------------------------------------
%     nodes               =  connectivity(:,ielem);
%     x_elem              =  x(:,nodes);
%     X_elem              =  X(:,nodes);
%     %----------------------------------------------------------------------
%     % Compute displacements in the element 
%     %----------------------------------------------------------------------
%     u                   =  x_elem - X_elem;    
%     %----------------------------------------------------------------------
%     % Determine residual and stiffness combining nonlinear and linear models
%     %----------------------------------------------------------------------
%     Rlinear             =  Klinear*u(:);
%     Rx                  =  (rho_p(ielem) + (1 - rho_p(ielem))*void_factor)*Rlinear;
%     %----------------------------------------------------------------------
%     % Sparse assembly 
%     %----------------------------------------------------------------------
%     for inode=1:Mesh.volume.x.n_node_elem
%         dofs(:,inode)   =  Geometry.dim*(nodes(inode)-1)+1:Geometry.dim*nodes(inode);
%     end
%     TInternal(dofs(:))     =  TInternal(dofs(:)) + Rx;    
% end
% toc
