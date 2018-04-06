

function Elastic_Energy      =  ObjectiveFunctionEnergyLinearElasticity(str)    
%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
Elastic_Energy       =  0;
%--------------------------------------------------------------------------
% Extract from the structures 
%--------------------------------------------------------------------------
penal                =  str.mat_info.optimisation.penal;
rho                  =  str.mat_info.optimisation.rho;
void_factor          =  str.mat_info.optimisation.void_factor(rho); 
density              =  rho.^penal;

x                    =  str.solution.x.Eulerian_x;
X                    =  str.solution.x.Lagrangian_X;
connectivity         =  str.mesh.volume.x.connectivity;
Klinear              =  str.mat_info.Klinear;
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
for ielem=1:str.mesh.volume.n_elem  
    x_elem           =  x(:,connectivity(:,ielem));
    X_elem           =  X(:,connectivity(:,ielem));
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
    % Glbal Enegy
    %----------------------------------------------------------------------
    Elastic_Energy   =  Elastic_Energy + density(ielem)*Wlinear + (1 - density(ielem))*void_factor(ielem)*Wlinear;
end     

end

