%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assembly of the residual and stiffness matrix of the system.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Assembly   =  InternalWorkUAssemblyMexFilesv2(formulation,...
                                  Geometry,Mesh,FEM,Quadrature,Assembly,...
                                  MatInfo,Optimisation,Solution)    
%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
Assembly            =  GlobalResidualInitialisationFormulation(Geometry,...
                                                Mesh,Assembly,formulation);
%--------------------------------------------------------------------------
% Dofs per element and initialisation of indexi, indexj and data
%--------------------------------------------------------------------------
[Kdata,Tdata]       =  SparseStiffnessPreallocationv2(Geometry,Mesh,formulation);
%--------------------------------------------------------------------------
% Extract from the structures 
%--------------------------------------------------------------------------
rho                 =  Optimisation.density;
void_factor         =  Optimisation.void_factor; 
rho_p               =  rho.^Optimisation.penalty;

x                   =  Solution.x.Eulerian_x;
X                   =  Solution.x.Lagrangian_X;
connectivity        =  Mesh.volume.x.connectivity;
Klinear             =  MatInfo.Klinear;
DNX                 =  FEM.volume.bilinear.x.DN_X;
IntWeight           =  Quadrature.volume.bilinear.IntWeight;
%--------------------------------------------------------------------------
% Loop over elements
%--------------------------------------------------------------------------
for ielem=1:Mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % kinematics
    %----------------------------------------------------------------------
    x_elem          =  x(:,connectivity(:,ielem));
    X_elem          =  X(:,connectivity(:,ielem));
    [F,H,J]         =  KinematicsFunctionFinalMexC(x_elem,X_elem,DNX);
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    if ~Geometry.PlaneStress
       [Piola,...
        Elasticity]    =  MooneyRivlinMexC(MatInfo.mu1,MatInfo.mu2,...
                                        MatInfo.lambda,F,H,J);    
    else
       [Piola,...
        Elasticity]    =  MooneyRivlinPlaneStress(MatInfo.mu1,MatInfo.mu2,...
                                        MatInfo.lambda,F,H,J);    
    end
    %----------------------------------------------------------------------
    % Compute the residuals for the nonlinear model  
    %----------------------------------------------------------------------
    Rx              =  ResidualsUFormulationMexC(DNX,Piola,IntWeight);
    %----------------------------------------------------------------------
    % Compute the stiffness matrix for the nonlinear model
    %----------------------------------------------------------------------
    Kxx             =  TangentOperatorUFormulationMexC(DNX,Elasticity,IntWeight);
    %----------------------------------------------------------------------
    % Compute displacements in the element
    %----------------------------------------------------------------------
    u               =  x_elem - X_elem;
    %----------------------------------------------------------------------
    % Determine residual and stiffness combining nonlinear and linear models
    %----------------------------------------------------------------------
    Rlinear         =  Klinear*u(:);
    Rx              =  rho_p(ielem)*Rx + (1 - rho_p(ielem))*void_factor*Rlinear;
    Kxx             =  rho_p(ielem)*Kxx + (1 - rho_p(ielem))*void_factor*Klinear;
    %----------------------------------------------------------------------
    % Sparse assembly 
    %----------------------------------------------------------------------
    Kdata(:,ielem)  =  Kxx(:);
    Tdata(:,ielem)  =  Rx(:);    
end     
%--------------------------------------------------------------------------
% Sparse assembly of the stiffness matrix.           
%--------------------------------------------------------------------------
Assembly.total_matrix    =  sparse(Assembly.sparse.Kindexi,...
                              Assembly.sparse.Kindexj,Kdata,...
                              Solution.n_dofs,Solution.n_dofs);
%--------------------------------------------------------------------------
% Sparse assembly of the residual.             
%--------------------------------------------------------------------------
Assembly.total_force  =  sparse(Assembly.sparse.Tindexi,...
                              Assembly.sparse.Tindexj,Tdata,...
                              Solution.n_dofs,1);

end





