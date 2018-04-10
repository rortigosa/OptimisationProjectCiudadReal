
function DIDrho    =  DerivativeObjectiveFunctionNonlinearConvexifiedMexFiles(ptest,...
                                     Mesh,Optimisation,Solution,MatInfo,...
                                     Geometry,FEM,Quadrature)   

%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices 
%--------------------------------------------------------------------------
DIDrho             =  zeros(1,Mesh.volume.n_elem);
%--------------------------------------------------------------------------
% Extract from the structures optimisation fields 
%--------------------------------------------------------------------------
penal              =  Optimisation.penalty;
rho                =  Optimisation.density;
void_factor        =  Optimisation.void_factor; 
diff_rho_p         =  penal*rho.^(penal - 1);
%--------------------------------------------------------------------------
% Extract from the structures remaining fields
%--------------------------------------------------------------------------
x                  =  Solution.x.Eulerian_x;
xold               =  Solution.old.x.Eulerian_x;
xoldold            =  Solution.old_old.x.Eulerian_x;
X                  =  Solution.x.Lagrangian_X;
connectivity       =  Mesh.volume.x.connectivity;
Klinear            =  MatInfo.Klinear;
ElasticityOrigin   =  MatInfo.ElasticityLinear;
ptest              =  reshape(ptest,Geometry.dim,[]);
DNX                =  FEM.volume.bilinear.x.DN_X;
IntWeight          =  Quadrature.volume.bilinear.IntWeight;
ngauss             =  size(IntWeight,1);

for ielem=1:Mesh.volume.n_elem 
    x_elem         =  x(:,connectivity(:,ielem));
    X_elem         =  X(:,connectivity(:,ielem));
    xo_elem        =  xold(:,connectivity(:,ielem));
    xoo_elem       =  xoldold(:,connectivity(:,ielem));
    p_elem         =  ptest(:,connectivity(:,ielem));
    [Foo,Hoo,Joo]  =  KinematicsFunctionFinalMexC(xoo_elem,X_elem,DNX);
    [Fo,Ho,Jo]     =  KinematicsFunctionFinalMexC(xo_elem,X_elem,DNX);
    DF0            =  Fo - Foo;
    [DF,~,~]       =  KinematicsFunctionFinalMexC(x_elem-xo_elem,X_elem,DNX);
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    if ~Geometry.PlaneStress
       [Piola0,...
        Elasticity0]     =  MooneyRivlinMexC(MatInfo.mu1,MatInfo.mu2,...
                                          MatInfo.lambda,Foo,Hoo,Joo);    
        [~,...
        Elasticity]      =  MooneyRivlinMexC(MatInfo.mu1,MatInfo.mu2,...
                                          MatInfo.lambda,Fo,Ho,Jo);    
    else
       [Piola0,...
        Elasticity0]     =  MooneyRivlinPlaneStress(MatInfo.mu1,MatInfo.mu2,...
                                          MatInfo.lambda,Foo,Hoo,Joo);    
        [~,...
        Elasticity]      =  MooneyRivlinPlaneStress(MatInfo.mu1,MatInfo.mu2,...
                                          MatInfo.lambda,Fo,Ho,Jo);            
    end
    %----------------------------------------------------------------------
    % Regularisation of the elasticity tensor 
    %----------------------------------------------------------------------
    %Elasticity0      =  RegularisationElasticityMethod1(Geometry.dim,ngauss,Elasticity0,ElasticityOrigin);        
    %Elasticity       =  RegularisationElasticityMethod1(Geometry.dim,ngauss,Elasticity,ElasticityOrigin);    
    Elasticity0     =  RegularisationElasticity1MexC(Geometry.dim^2,ngauss,Elasticity0,ElasticityOrigin);        
    Elasticity      =  RegularisationElasticity1MexC(Geometry.dim^2,ngauss,Elasticity,ElasticityOrigin);            
    %----------------------------------------------------------------------
    % Piola in the solid 
    %----------------------------------------------------------------------    
    H0u                 =  MatrixVectorMultiplication(Geometry.dim^2,ngauss,...
                              Elasticity0,reshape(DF0,Geometry.dim^2,[]));
    Hu                  =  MatrixVectorMultiplication(Geometry.dim^2,ngauss,...
                              Elasticity,reshape(DF,Geometry.dim^2,[]));
    Piola_solid         =  Piola0 + reshape(H0u + Hu,Geometry.dim,Geometry.dim,[]);
    %----------------------------------------------------------------------
    % Determine if linear elasticity or nonlinear elasticity shall be applied
    % on the current element
    %----------------------------------------------------------------------
    u              =  x_elem - X_elem;
    %----------------------------------------------------------------------
    % Stability of the Elasticity tensor
    %----------------------------------------------------------------------
%    if Optimisation.stability(ielem)==0
       %xold_elem   =  xold(:,connectivity(:,ielem));        
       %-------------------------------------------------------------------
       % Linearised kinematics
       %-------------------------------------------------------------------
       %[F_lin,Fx0,H_lin,...
       %Hx0,J_lin]  =  KinematicsFunctionConvexifiedMexC(x_elem,xold_elem,X_elem,DNX);
       %-------------------------------------------------------------------
       % Piola and Elasticity for the linearised kinematics
       %-------------------------------------------------------------------
       %Piola       =  MooneyRivlinConvexifiedMexC(MatInfo.mu1,MatInfo.mu2,...
       %                              MatInfo.lambda,F_lin,H_lin,J_lin,Fx0,Hx0);
%    end
    %----------------------------------------------------------------------
    % linear contribution in the derivative
    %----------------------------------------------------------------------
    linear_contribution   =  p_elem(:)'*(Klinear*u(:));
    %----------------------------------------------------------------------
    % Derivative: solid contribution
    %----------------------------------------------------------------------
    DIDrho_solid_nlinear  =  SensitivityNonlinearMexC(Piola_solid,p_elem,DNX,IntWeight);         
    DIDrho_solid          =  -diff_rho_p(ielem)*DIDrho_solid_nlinear;
    %----------------------------------------------------------------------
    % Derivative: void contribution
    %----------------------------------------------------------------------
    DIDrho_void           =  void_factor*diff_rho_p(ielem)*linear_contribution; 
    %----------------------------------------------------------------------
    % Derivative: total contribution
    %----------------------------------------------------------------------  
    DIDrho(:,ielem)       =  DIDrho_solid + DIDrho_void;    
end     
DIDrho                    =  DIDrho';
end
