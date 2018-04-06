
function DIDrho           =  DerivativeObjectiveFunctionConvexifiedMexFiles(str,ptest)    
%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
DIDrho                    =  zeros(1,str.mesh.volume.n_elem);
%--------------------------------------------------------------------------
% Extract from the structures optimisation fields
%--------------------------------------------------------------------------
penal                     =  str.mat_info.optimisation.penal;
rho                       =  str.mat_info.optimisation.rho;
void_factor               =  str.mat_info.optimisation.void_factor(rho)*str.mat_info.optimisation.void_factor_scaling; 
diff_rho_p                =  penal*rho.^(penal - 1);
%--------------------------------------------------------------------------
% Extract from the structures remaining fields
%--------------------------------------------------------------------------
x                         =  str.solution.x.Eulerian_x;
xold                      =  str.solution.old.x.Eulerian_x;
X                         =  str.solution.x.Lagrangian_X;
connectivity              =  str.mesh.volume.x.connectivity;
mat_parameters            =  str.mat_info.parameters;
Klinear                   =  str.mat_info.Klinear;
ptest                     =  reshape(ptest,str.geometry.dim,[]);
DNX                       =  str.fem.volume.bilinear.x.DN_X;
IntWeight                 =  str.quadrature.volume.bilinear.IntWeight;
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
for ielem=1:str.mesh.volume.n_elem 
    x_elem                =  x(:,connectivity(:,ielem));
    xold_elem             =  xold(:,connectivity(:,ielem));
    X_elem                =  X(:,connectivity(:,ielem)); 
    p_elem                =  ptest(:,connectivity(:,ielem));
    [F,Fx0,H,Hx0,J]       =  KinematicsFunctionConvexifiedMexC(x_elem,xold_elem,X_elem,DNX);
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    Piola                =  MooneyRivlinConvexifiedMexC(mat_parameters.Mooney_Rivlin.mu1,mat_parameters.Mooney_Rivlin.mu2,...
                                              mat_parameters.Mooney_Rivlin.lambda,F,H,J,Fx0,Hx0);
    %----------------------------------------------------------------------
    % Displacement
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
    DIDrho_void           =  void_factor(ielem)*diff_rho_p(ielem)*linear_contribution; 
    %----------------------------------------------------------------------
    % Derivative: total contribution
    %----------------------------------------------------------------------  
    DIDrho(:,ielem)       =  DIDrho_solid + DIDrho_void;    
end     
DIDrho                    =  DIDrho';


end
