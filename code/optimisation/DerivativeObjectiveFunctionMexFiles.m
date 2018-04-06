
function DIDrho           =  DerivativeObjectiveFunctionMexFiles(ptest,Mesh,Optimisation,Solution,Geometry,FEM,Quadrature,MatInfo)    
%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
DIDrho                    =  zeros(1,Mesh.volume.n_elem);
%--------------------------------------------------------------------------
% Extract from the structures optimisation fields 
%--------------------------------------------------------------------------
penal                     =  Optimisation.penalty;
rho                       =  Optimisation.density;
void_factor               =  Optimisation.void_factor; 
diff_rho_p                =  penal*rho.^(penal - 1);
%--------------------------------------------------------------------------
% Extract from the structures remaining fields
%--------------------------------------------------------------------------
x                         =  Solution.x.Eulerian_x;
X                         =  Solution.x.Lagrangian_X;
connectivity              =  Mesh.volume.x.connectivity;
Klinear                   =  MatInfo.Klinear;
ptest                     =  reshape(ptest,Geometry.dim,[]);
DNX                       =  FEM.volume.bilinear.x.DN_X;
IntWeight                 =  Quadrature.volume.bilinear.IntWeight;
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
for ielem=1:Mesh.volume.n_elem 
    x_elem                =  x(:,connectivity(:,ielem));
    X_elem                =  X(:,connectivity(:,ielem));
    p_elem                =  ptest(:,connectivity(:,ielem));
    [F,H,J]               =  KinematicsFunctionFinalMexC(x_elem,X_elem,DNX);
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    Piola                 =  MooneyRivlinMexC(MatInfo.mu1,MatInfo.mu2,...
                                   MatInfo.lambda,F,H,J);
    %----------------------------------------------------------------------
    % Determine if linear elasticity or nonlinear elasticity shall be applied
    % on the current element
    %----------------------------------------------------------------------
    u                     =  x_elem - X_elem;
    %----------------------------------------------------------------------
    % linear contribution in the derivative
    %----------------------------------------------------------------------
    linear_contribution   =  p_elem(:)'*(Klinear*u(:));
    %----------------------------------------------------------------------
    % Derivative: solid contribution
    %----------------------------------------------------------------------
    DIDrho_solid          =  -diff_rho_p(ielem)*SensitivityNonlinearMexC(Piola,p_elem,DNX,IntWeight);         
    %----------------------------------------------------------------------
    % Derivative: void contribution
    %----------------------------------------------------------------------
    DIDrho_void           =  (void_factor*diff_rho_p(ielem))*linear_contribution; 
    %----------------------------------------------------------------------
    % Derivative: total contribution
    %----------------------------------------------------------------------  
    DIDrho_e              =  DIDrho_solid + DIDrho_void;    
    DIDrho(:,ielem)       =  DIDrho_e;    
end     
DIDrho                    =  DIDrho';


end
