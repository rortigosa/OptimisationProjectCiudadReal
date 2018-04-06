%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assembly of the residual and stiffness matrix of the system.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str             =  InternalWorkUNonlinearConvexifiedLinearisedAssemblyMexFiles(str)    

%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
str.assembly             =  GlobalResidualInitialisationFormulation(str.geometry,str.mesh,str.assembly,str.data.formulation);
%--------------------------------------------------------------------------
% Dofs per element and initialisation of indexi, indexj and data
%--------------------------------------------------------------------------
[Kdata,Tdata]            =  SparseStiffnessPreallocationv2(str.geometry,str.mesh,str.data.formulation);
%--------------------------------------------------------------------------
% Extract from the structures 
%--------------------------------------------------------------------------
rho                      =  str.mat_info.optimisation.rho;
void_factor              =  str.mat_info.optimisation.void_factor_scaling*str.mat_info.optimisation.void_factor(rho); 
rho_p                    =  rho.^str.mat_info.optimisation.penal;

x                        =  str.solution.x.Eulerian_x;
xold                     =  str.solution.old.x.Eulerian_x;
X                        =  str.solution.x.Lagrangian_X;
connectivity             =  str.mesh.volume.x.connectivity;
mat_parameters           =  str.mat_info.parameters.Mooney_Rivlin; 
Klinear                  =  str.mat_info.Klinear;
DNX                      =  str.fem.volume.bilinear.x.DN_X;
IntWeight                =  str.quadrature.volume.bilinear.IntWeight;
ngauss                   =  length(str.quadrature.volume.bilinear.W_v);
dim                      =  str.geometry.dim;
stability                =  ones(str.mesh.volume.n_elem,1);
%--------------------------------------------------------------------------
% Initialise stable part of the residual
%--------------------------------------------------------------------------
Rxstable                 =  zeros(dim*str.mesh.volume.x.n_node_elem,1);
for ielem=1:str.mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % kinematics
    %----------------------------------------------------------------------
    x_elem               =  x(:,connectivity(:,ielem));
    X_elem               =  X(:,connectivity(:,ielem));
    [F,H,J]              =  KinematicsFunctionFinalMexC(x_elem,X_elem,DNX);
    %----------------------------------------------------------------------
    % Compute displacements in the element
    %----------------------------------------------------------------------
    u                   =  x_elem - X_elem;    
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    [Piola,...
        Elasticity]      =  MooneyRivlinMexC(mat_parameters.mu1,mat_parameters.mu2,...
                                          mat_parameters.lambda,F,H,J);    
    %----------------------------------------------------------------------
    % Stability of the Elasticity tensor
    %----------------------------------------------------------------------
    stability(ielem)     =  SylvesterCriterionElasticity24(dim,ngauss,Elasticity);      
    if stability(ielem)==0
       xold_elem         =  xold(:,connectivity(:,ielem));        
       %-------------------------------------------------------------------
       % Linearised kinematics
       %-------------------------------------------------------------------
       [F_lin,Fx0,H_lin,...
           Hx0,J_lin]    =  KinematicsFunctionConvexifiedMexC(x_elem,xold_elem,X_elem,DNX);
       %-------------------------------------------------------------------
       % Piola and Elasticity for the linearised kinematics
       %-------------------------------------------------------------------
       [Piola,...
        Elasticity]      =  MooneyRivlinConvexifiedMexC(mat_parameters.mu1,mat_parameters.mu2,...
                                     mat_parameters.lambda,F_lin,H_lin,J_lin,Fx0,Hx0);
    end
    %----------------------------------------------------------------------
    % Compute residuals and stiffness matrix for the nonlinear model
    %----------------------------------------------------------------------       
    Rx                   =  ResidualsUFormulationMexC(DNX,Piola,IntWeight);
    Kxx                  =  TangentOperatorUFormulationMexC(DNX,Elasticity,IntWeight);
    if stability(ielem)==0
       %-------------------------------------------------------------------
       % Stable contribution in the residual
       %-------------------------------------------------------------------
       Rxstable          =  Kxx*(x_elem(:) - xold_elem(:));
       Rx                =  Rx + Rxstable;
    end
    %----------------------------------------------------------------------
    % Determine residual and stiffness combining nonlinear and linear models
    %----------------------------------------------------------------------
    Rlinear             =  Klinear*u(:);
    Rx                  =  rho_p(ielem)*Rx  + (1 - rho_p(ielem))*(void_factor(ielem)*Rlinear);
    Kxx                 =  rho_p(ielem)*Kxx + (1 - rho_p(ielem))*(void_factor(ielem)*Klinear);
    %----------------------------------------------------------------------
    % Sparse assembly 
    %----------------------------------------------------------------------
    Kdata(:,ielem)      =  Kxx(:);
    Tdata(:,ielem)      =  Rx(:);    
end     
%--------------------------------------------------------------------------
% Sparse assembly of the stiffness matrix.           
%--------------------------------------------------------------------------
str.assembly.K_total    =  sparse(str.sparse.Kindexi,str.sparse.Kindexj,Kdata,str.solution.n_dofs,str.solution.n_dofs);
%--------------------------------------------------------------------------
% Sparse assembly of the residual.             
%--------------------------------------------------------------------------
str.assembly.Tinternal  =  sparse(str.sparse.Tindexi,str.sparse.Tindexj,Tdata,str.solution.n_dofs,1);

end





