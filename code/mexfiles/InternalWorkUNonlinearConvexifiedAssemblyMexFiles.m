%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assembly of the residual and stiffness matrix of the system.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Assembly    =  InternalWorkUNonlinearConvexifiedAssemblyMexFiles(formulation,...
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
[Kdata,Tdata]           =  SparseStiffnessPreallocationv2(Geometry,Mesh,formulation);
%--------------------------------------------------------------------------
% Extract from the structures   
%--------------------------------------------------------------------------
rho                     =  Optimisation.density;
void_factor             =  Optimisation.void_factor; 
rho_p                   =  rho.^Optimisation.penalty;
 
x                       =  Solution.x.Eulerian_x;
xold                    =  Solution.old.x.Eulerian_x;
X                       =  Solution.x.Lagrangian_X;
connectivity            =  Mesh.volume.x.connectivity;
Klinear                 =  MatInfo.Klinear;
DNX                     =  FEM.volume.bilinear.x.DN_X;
IntWeight               =  Quadrature.volume.bilinear.IntWeight;
ngauss                  =  size(IntWeight,1);
%--------------------------------------------------------------------------
% Detect unstable elements
%--------------------------------------------------------------------------
Optimisation   =  PlotUnstableElements(formulation,Optimisation,Solution,...
                                       Mesh,FEM,Quadrature,MatInfo,0,0,1);
 
Optimisation.stability_stiffness      =  ones(Mesh.volume.n_elem,1);
for ielem=1:Mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % Kinematics
    %----------------------------------------------------------------------
    x_elem              =  x(:,connectivity(:,ielem));
    xold_elem           =  xold(:,connectivity(:,ielem));
    X_elem              =  X(:,connectivity(:,ielem));
    [F,H,J]             =  KinematicsFunctionFinalMexC(x_elem,X_elem,DNX);
    [Fo,Ho,Jo]          =  KinematicsFunctionFinalMexC(xold_elem,X_elem,DNX);
    [DF,~,~]            =  KinematicsFunctionFinalMexC(x_elem-xold_elem,X_elem,DNX);
    %----------------------------------------------------------------------
    % Compute displacements in the element 
    %----------------------------------------------------------------------
    u                   =  x_elem - X_elem;    
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    [Piola0,...
       Elasticity0]     =  MooneyRivlinMexC(MatInfo.mu1,MatInfo.mu2,...
                                         MatInfo.lambda,Fo,Ho,Jo);    
    [~,Elasticity]      =  MooneyRivlinMexC(MatInfo.mu1,MatInfo.mu2,...
                                          MatInfo.lambda,F,H,J);    
    %----------------------------------------------------------------------
    % Regularisation of the elasticity tensor 
    %----------------------------------------------------------------------
    %Elasticity0     =  RegularisationElasticityMethod1(Geometry.dim,ngauss,Elasticity0);    
    %Elasticity      =  RegularisationElasticityMethod1(Geometry.dim,ngauss,Elasticity);    
    Elasticity0      =  RegularisationElasticity1MexC(Geometry.dim^2,ngauss,Elasticity0);    
    Elasticity       =  RegularisationElasticity1MexC(Geometry.dim^2,ngauss,Elasticity);    
    %----------------------------------------------------------------------
    % piola
    %----------------------------------------------------------------------
    Hu                   =  MatrixVectorMultiplicationMexC(Geometry.dim^2,ngauss,Elasticity0,reshape(DF,Geometry.dim^2,[]));                         
    Piola                =  Piola0 + reshape(Hu,Geometry.dim,Geometry.dim,[]);    
    %----------------------------------------------------------------------
    % Compute residuals and stiffness matrix for the nonlinear model
    %----------------------------------------------------------------------       
    Rx                   =  ResidualsUFormulationMexC(DNX,Piola,IntWeight);
    Kxx                  =  TangentOperatorUFormulationMexC(DNX,Elasticity,IntWeight);
    %----------------------------------------------------------------------
    % Determine residual and stiffness combining nonlinear and linear models
    %----------------------------------------------------------------------
    Rlinear             =  Klinear*u(:);
    Rx                  =  rho_p(ielem)*Rx  + (1 - rho_p(ielem))*(void_factor*Rlinear);
    Kxx                 =  rho_p(ielem)*Kxx + (1 - rho_p(ielem))*(void_factor*Klinear);
    %----------------------------------------------------------------------
    % Sparse assembly 
    %----------------------------------------------------------------------
    Kdata(:,ielem)      =  Kxx(:);
    Tdata(:,ielem)      =  Rx(:);    
end     

%--------------------------------------------------------------------------
% Sparse assembly of the stiffness matrix.           
%--------------------------------------------------------------------------
Assembly.total_matrix   =  sparse(Assembly.sparse.Kindexi,...
                                  Assembly.sparse.Kindexj,Kdata,...
                                  Solution.n_dofs,Solution.n_dofs);
%--------------------------------------------------------------------------
% Sparse assembly of the residual.             
%--------------------------------------------------------------------------
Assembly.total_force   =  sparse(Assembly.sparse.Tindexi,...
                                  Assembly.sparse.Tindexj,Tdata,...
                                  Solution.n_dofs,1);


end


