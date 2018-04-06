
function DIDrho      =  DerivativeObjectiveFunctionLinearElasticityMexFiles(ptest,Mesh,Optimisation,Solution,MatInfo,Geometry)    
%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
DIDrho               =  zeros(1,Mesh.volume.n_elem);
%--------------------------------------------------------------------------
% Extract from the structures
%--------------------------------------------------------------------------
rho                  =  Optimisation.rho;
penal                =  Optimisation.penalty;
density              =  penal*(rho.^(penal - 1));
void_factor          =  Optimisation.void_factor; 
x                    =  Solution.x.Eulerian_x;
X                    =  Solution.x.Lagrangian_X;
connectivity         =  Mesh.volume.x.connectivity;
Klinear              =  MatInfo.Klinear;
ptest                =  reshape(ptest,Geometry.dim,[]);
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
for ielem=1:Mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % Compute displacement
    %----------------------------------------------------------------------
    u                =  x(:,connectivity(:,ielem)) - X(:,connectivity(:,ielem));
    %----------------------------------------------------------------------
    % Derivative
    %----------------------------------------------------------------------
    p_elem           =  ptest(:,connectivity(:,ielem));
    DIDrho(:,ielem)  =  density(ielem)*(p_elem(:)'*(Klinear*(void_factor(ielem) - 1))*u(:));
end     
DIDrho               =  DIDrho';

end
