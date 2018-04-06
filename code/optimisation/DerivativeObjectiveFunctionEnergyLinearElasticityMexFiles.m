
function DIDrho        =  DerivativeObjectiveFunctionEnergyLinearElasticityMexFiles(Mesh,Optimisation,Solution,MatInfo)    
%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
DIDrho                 =  zeros(1,Mesh.volume.n_elem);
%--------------------------------------------------------------------------
% Extract from the structures 
%--------------------------------------------------------------------------
penal                =  Optimisation.penalty;
rho                  =  Optimisation.density;
void_factor          =  Optimisation.void_factor_scaling; 
diff_rho_p           =  penal*rho.^(penal - 1);

x                    =  Solution.x.Eulerian_x;
X                    =  Solution.x.Lagrangian_X;
connectivity         =  Mesh.volume.x.connectivity;
Klinear              =  MatInfo.Klinear;
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
for ielem=1:Mesh.volume.n_elem  
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
    % Derivative
    %----------------------------------------------------------------------
    DIDrho(:,ielem)  =  diff_rho_p(ielem)*Wlinear*(1 - void_factor(ielem));
end     
DIDrho               =  DIDrho';

end
