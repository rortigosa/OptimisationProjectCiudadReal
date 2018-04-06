

function Elastic_Energy      =  ObjectiveFunctionEnergy(Optimisation,FEM,Quadrature,Mesh,Solution,MatInfo)    
%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
Elastic_Energy       =  0;
%--------------------------------------------------------------------------
% Extract from the structures 
%--------------------------------------------------------------------------
penal                =  Optimisation.penalty;
rho                  =  Optimisation.density;
void_factor          =  Optimisation.void_factor; 
rhop                 =  rho.^penal;

x                    =  Solution.x.Eulerian_x;
X                    =  Solution.x.Lagrangian_X;
connectivity         =  Mesh.volume.x.connectivity;
Klinear              =  MatInfo.Klinear;
DNX                  =  FEM.volume.bilinear.x.DN_X;
IntWeight            =  Quadrature.volume.bilinear.IntWeight;
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
for ielem=1:Mesh.volume.n_elem  
    x_elem           =  x(:,connectivity(:,ielem));
    X_elem           =  X(:,connectivity(:,ielem));
    %----------------------------------------------------------------------
    % Kinematics
    %----------------------------------------------------------------------
    [F,H,J]          =  KinematicsFunctionFinalMexC(x_elem,X_elem,DNX);
    %----------------------------------------------------------------------
    % Determine if linear elasticity or nonlinear elasticity shall be applied
    % on the current element
    %----------------------------------------------------------------------
    u                =  x_elem - X_elem;
    %----------------------------------------------------------------------
    % Linear energy
    %----------------------------------------------------------------------
    Wlinear          =  0.5*(u(:)'*(Klinear*u(:)));
    %----------------------------------------------------------------------
    % Local (element) energy
    %----------------------------------------------------------------------
    %Wnonlinear      =  MooneyRivlinEnergyMexC(MatInfo.mu1,MatInfo.mu2,...
    %                                                 MatInfo.lambda,F,H,J);
 %   Wnonlinear       =  DeviatoricVolumetricEnergy(F,H,J);    
 %   Wnonlinear       =  FEMScalarIntegralMexC(Wnonlinear,IntWeight);
    %----------------------------------------------------------------------
    % Glbal Enegy
    %----------------------------------------------------------------------
%    Elastic_Energy   =  Elastic_Energy + (Wnonlinear*rhop(ielem) + ...
%                        (1 - rhop(ielem))*void_factor*Wlinear);
   %Elastic_Energy   =  ;
    Elastic_Energy   =  Elastic_Energy + rhop(ielem)*Wlinear;
end     




