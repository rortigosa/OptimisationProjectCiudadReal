
function DIDrho    =  DerivativeObjectiveFunctionNonlinearConvexifiedMexFilesV2(ptest,...
                                     Mesh,Optimisation,Solution,MatInfo,...
                                     Geometry,FEM,Quadrature,StabilisationFactor)   

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
X                  =  Solution.x.Lagrangian_X;
connectivity       =  Mesh.volume.x.connectivity;
Klinear            =  MatInfo.Klinear;
ElasticityOrigin   =  MatInfo.ElasticityLinear;
ptest              =  reshape(ptest,Geometry.dim,[]);
DNX                =  FEM.volume.bilinear.x.DN_X;
IntWeight          =  Quadrature.volume.bilinear.IntWeight;
ngauss             =  size(IntWeight,1);
Imatrix2D          =  repmat(eye(Geometry.dim),1,1,ngauss);
%--------------------------------------------------------------------------
% Loop over elements
%--------------------------------------------------------------------------
for ielem=1:Mesh.volume.n_elem 
    x_elem         =  x(:,connectivity(:,ielem));
    X_elem         =  X(:,connectivity(:,ielem));
    p_elem         =  ptest(:,connectivity(:,ielem));
    [F,H,J]        =  KinematicsFunctionFinalMexC(x_elem,X_elem,DNX);
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    [Piola,Elasticity]   =  ConstitutiveModels(Geometry.PlaneStress,MatInfo,F,H,J);
    %----------------------------------------------------------------------
    % Regularisation of the elasticity tensor 
    %----------------------------------------------------------------------
    alpha                =  RegularisationParameterElasticityMexC(Geometry.dim^2,ngauss,Elasticity,ElasticityOrigin);        
    %----------------------------------------------------------------------
    % Piola in the solid 
    %----------------------------------------------------------------------    
    gradu                =  F - Imatrix2D;
    PiolaReg             =  MatrixScalarMultiplicationMexC(Geometry.dim,ngauss,gradu,alpha);    
    Piola_solid          =  Piola + StabilisationFactor*PiolaReg;
    %----------------------------------------------------------------------
    % Determine if linear elasticity or nonlinear elasticity shall be applied
    % on the current element
    %----------------------------------------------------------------------
    u              =  x_elem - X_elem;
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
