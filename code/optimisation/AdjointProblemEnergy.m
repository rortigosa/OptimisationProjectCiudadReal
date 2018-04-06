%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assembly of the residual and stiffness matrix of the system.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function T       =  AdjointProblemEnergy(formulation,Geometry,Mesh,Assembly,...
                              Solution,Optimisation,MatInfo,FEM,Quadrature)    

%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
str.assembly       =  GlobalResidualInitialisationFormulation(Geometry,Mesh,...
                                                     Assembly,formulation);
%--------------------------------------------------------------------------
% Dofs per element and initialisation of indexi, indexj and data
%--------------------------------------------------------------------------
[~,Tdata]          =  SparseStiffnessPreallocationv2(Geometry,Mesh,formulation);
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
%tic     
%--------------------------------------------------------------------------
% Extract from the structures
%--------------------------------------------------------------------------
rho                =  Optimisation.density;
void_factor        =  Optimisation.void_factor; 
rho_p              =  rho.^Optimisation.penalty;
                      
x                  =  Solution.x.Eulerian_x;
X                  =  Solution.x.Lagrangian_X;
connectivity       =  Mesh.volume.x.connectivity;
Klinear            =  MatInfo.Klinear;
DNX                =  FEM.volume.bilinear.x.DN_X;
IntWeight          =  Quadrature.volume.bilinear.IntWeight;
for ielem=1:Mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % kinematics
    %----------------------------------------------------------------------
%    [F,H,J]       =  KinematicsFunctionFinalMexC(x(:,connectivity(:,ielem)),X(:,connectivity(:,ielem)),DNX);
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    %Piola        =  MooneyRivlinMexC(MatInfo.mu1,MatInfo.mu2,MatInfo.lambda,F,H,J);
    %Piola         =  DerivativeDeviatoricVolumetricEnergy(F,H,J);    
    %Piola        =  DerivativeMooneyRivlinEnergy(MatInfo.mu1,MatInfo.mu2,MatInfo.lambda,F,H,J);
    %----------------------------------------------------------------------
    % Compute the residuals for the nonlinear model
    %----------------------------------------------------------------------
%    Rx            =  ResidualsUFormulationMexC(DNX,Piola,IntWeight);
    %----------------------------------------------------------------------
    % Compute displacements in the element
    %----------------------------------------------------------------------
    u             =  x(:,connectivity(:,ielem)) - X(:,connectivity(:,ielem));
    %----------------------------------------------------------------------
    % Determine residual and stiffness combining nonlinear and linear models
    %----------------------------------------------------------------------
    Rlinear       =  Klinear*u(:);
    %Rx            =  rho_p(ielem)*Rx + (1 - rho_p(ielem))*(void_factor*Rlinear);
    Rx            =  rho_p(ielem)*Rlinear;
    %----------------------------------------------------------------------
    % Sparse assembly 
    %----------------------------------------------------------------------
    Tdata(:,ielem)  =  Rx(:);    
end     
T     =  sparse(Assembly.sparse.Tindexi,Assembly.sparse.Tindexj,Tdata,Solution.n_dofs,1);
end





