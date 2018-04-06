
function DIDrho        =  DerivativeObjectiveFunctionEnergyMexFiles(Mesh,Optimisation,Solution,MatInfo,FEM,Quadrature)    

%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
DIDrho                 =  zeros(1,Mesh.volume.n_elem);
%--------------------------------------------------------------------------
% Extract from the structures 
%--------------------------------------------------------------------------
penal                =  Optimisation.penalty;
rho                  =  Optimisation.density;
void_factor          =  Optimisation.void_factor; 
diff_rho_p           =  penal*rho.^(penal - 1);

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
    %----------------------------------------------------------------------
    % Kinematics
    %----------------------------------------------------------------------
    [F,H,J]          =  KinematicsFunctionFinalMexC(x(:,connectivity(:,ielem)),X(:,connectivity(:,ielem)),DNX);
    %----------------------------------------------------------------------
    % Determine if linear elasticity or nonlinear elasticity shall be applied
    % on the current element
    %----------------------------------------------------------------------
    u                =  x(:,connectivity(:,ielem)) - X(:,connectivity(:,ielem));
    %----------------------------------------------------------------------
    % Linear energy
    %----------------------------------------------------------------------
    Wlinear          =  0.5*(u(:)'*(Klinear*u(:)));
    %----------------------------------------------------------------------
    % Nonlinear energy       
    %----------------------------------------------------------------------
    %Wnonlinear       =  MooneyRivlinEnergyMexC(MatInfo.mu1,MatInfo.mu2,...
    %                             MatInfo.lambda,F,H,J);
    Wnonlinear       =  DeviatoricVolumetricEnergy(F,H,J);    
    Wnonlinear       =  FEMScalarIntegralMexC(Wnonlinear,IntWeight);
    %----------------------------------------------------------------------
    % Derivative
    %----------------------------------------------------------------------
    DIDrho(:,ielem)  =  diff_rho_p(ielem)*(Wnonlinear - void_factor*Wlinear);
    %DIDrho(:,ielem)  =  0;
end     
DIDrho               =  DIDrho';

end
