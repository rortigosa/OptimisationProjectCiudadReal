%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assembly of the residual and stiffness matrix of the system.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Assembly    =  InternalWorkUExplicitAssembly(formulation,...
                            Geometry,Mesh,FEM,Quadrature,Assembly,...
                            MatInfo,Optimisation,Solution)
%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
Assembly                =  GlobalResidualInitialisationFormulation(Geometry,...
                               Mesh,Assembly,formulation);
%--------------------------------------------------------------------------
% Dofs per element and initialisation of indexi, indexj and data
%--------------------------------------------------------------------------
[~,Tdata]               =  SparseStiffnessPreallocationv2(Geometry,Mesh,formulation);
%--------------------------------------------------------------------------
% Extract from the structures   
%--------------------------------------------------------------------------
rho                     =  Optimisation.density;
void_factor             =  Optimisation.void_factor; 
rho_p                   =  rho.^Optimisation.penalty;
 
x                       =  Solution.x.Eulerian_x;
%xold                   =  Solution.old.x.Eulerian_x;
X                       =  Solution.x.Lagrangian_X;
connectivity            =  Mesh.volume.x.connectivity;
Klinear                 =  MatInfo.Klinear;
DNX                     =  FEM.volume.bilinear.x.DN_X;
IntWeight               =  Quadrature.volume.bilinear.IntWeight;
%ngauss                 =  size(IntWeight,1);
%--------------------------------------------------------------------------
% Detect unstable elements 
%--------------------------------------------------------------------------
for ielem=1:Mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % kinematics
    %----------------------------------------------------------------------
    x_elem              =  x(:,connectivity(:,ielem));
    %xold_elem          =  xold(:,connectivity(:,ielem));
    X_elem              =  X(:,connectivity(:,ielem));
    [F,H,J]             =  KinematicsFunctionFinalMexC(x_elem,X_elem,DNX);
    %----------------------------------------------------------------------
    % Compute displacements in the element 
    %----------------------------------------------------------------------
    u                   =  x_elem - X_elem;    
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    Piola               =  MooneyRivlinExplicitMexC(MatInfo.mu1,MatInfo.mu2,...
                                         MatInfo.lambda,F,H,J);    
    %----------------------------------------------------------------------
    % Compute residuals and stiffness matrix for the nonlinear model
    %----------------------------------------------------------------------       
    Rx                   =  ResidualsUFormulationMexC(DNX,Piola,IntWeight);
    %----------------------------------------------------------------------
    % Determine residual and stiffness combining nonlinear and linear models
    %----------------------------------------------------------------------
    Rlinear             =  Klinear*u(:);
    Rx                  =  rho_p(ielem)*Rx  + (1 - rho_p(ielem))*(void_factor*Rlinear);
    %----------------------------------------------------------------------
    % Sparse assembly 
    %----------------------------------------------------------------------
    Tdata(:,ielem)      =  Rx(:);    
end     

%--------------------------------------------------------------------------
% Sparse assembly of the residual.             
%--------------------------------------------------------------------------
TInternal               =  sparse(Assembly.sparse.Tindexi,...
                                  Assembly.sparse.Tindexj,Tdata,...
                                  Solution.n_dofs,1);

TInertial              =  Assembly.MassMatrix*Solution.x.acceleration(:);
TDamping               =  Assembly.DampingMatrix*Solution.x.velocity(:);
Assembly.total_force   =  TInternal + TInertial + TDamping;                              

end


