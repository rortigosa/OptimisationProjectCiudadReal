%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assembly of the residual and stiffness matrix of the system.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Assembly    =  InternalWorkUNonlinearConvexifiedAssemblyV2MexFiles(formulation,...
                            Geometry,Mesh,FEM,Quadrature,Assembly,...
                            MatInfo,Optimisation,Solution,StabilisationFactor)
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
X                       =  Solution.x.Lagrangian_X;
connectivity            =  Mesh.volume.x.connectivity;
Klinear                 =  MatInfo.Klinear;
ElasticityOrigin        =  MatInfo.ElasticityLinear;
DNX                     =  FEM.volume.bilinear.x.DN_X;
IntWeight               =  Quadrature.volume.bilinear.IntWeight;
ngauss                  =  size(IntWeight,1);
Imatrix                 =  repmat(eye(Geometry.dim^2),1,1,ngauss);
alpha_max               =  zeros(Mesh.volume.n_elem  ,1);
%--------------------------------------------------------------------------
% Compute residual and (non-regularised) part of the stiffness matrix
%--------------------------------------------------------------------------
Optimisation.stability_stiffness      =  ones(Mesh.volume.n_elem,1);
for ielem=1:Mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % Kinematics
    %----------------------------------------------------------------------
    x_elem              =  x(:,connectivity(:,ielem));
    X_elem              =  X(:,connectivity(:,ielem));
    [F,H,J]             =  KinematicsFunctionFinalMexC(x_elem,X_elem,DNX);
    %----------------------------------------------------------------------
    % Compute displacements in the element 
    %----------------------------------------------------------------------
    u                   =  x_elem - X_elem;    
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    [Piola,Elasticity]      =  ConstitutiveModels(Geometry.PlaneStress,MatInfo,F,H,J);
    %----------------------------------------------------------------------
    % Regularisation of the elasticity tensor  
    %----------------------------------------------------------------------
    alpha                =  RegularisationParameterElasticityMexC(Geometry.dim^2,ngauss,Elasticity,ElasticityOrigin);            
    ElasticityReg        =  MatrixScalarMultiplicationMexC(Geometry.dim^2,ngauss,Imatrix,alpha);    
    Elasticity           =  Elasticity + 1.05*StabilisationFactor*ElasticityReg;
    %----------------------------------------------------------------------
    % Penalise stabilised contributions 
    %----------------------------------------------------------------------       
%     alpha(alpha>1)       =  1;
%     penalisation         =  max((1-alpha),0.3);
%     Piola                =  MatrixScalarMultiplicationMexC(Geometry.dim,ngauss,Piola,penalisation);
%     Elasticity           =  MatrixScalarMultiplicationMexC(Geometry.dim^2,ngauss,Elasticity,penalisation);
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
    alpha_max(ielem)=max(alpha);
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


