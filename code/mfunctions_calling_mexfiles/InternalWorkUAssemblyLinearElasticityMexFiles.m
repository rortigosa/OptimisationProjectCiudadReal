%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assembly of the residual and stiffness matrix of the system for linear
% elasticity
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function Assembly   =  InternalWorkUAssemblyLinearElasticityMexFiles(formulation,...
                             Geometry,Mesh,Assembly,Optimisation,MatInfo,Solution)    
%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
str.assembly        =  GlobalResidualInitialisationFormulation(Geometry,Mesh,Assembly,formulation);
%--------------------------------------------------------------------------
% Dofs per element and initialisation of indexi, indexj and data
%--------------------------------------------------------------------------
[Kdata,Tdata]       =  SparseStiffnessPreallocationv2(Geometry,Mesh,formulation);
%--------------------------------------------------------------------------
% Extract from the structures
%--------------------------------------------------------------------------
rho                 =  Optimisation.density;
void_factor         =  Optimisation.void_factor; 

density             =  rho.^Optimisation.penalty;
x                   =  Solution.x.Eulerian_x;
X                   =  Solution.x.Lagrangian_X;
connectivity        =  Mesh.volume.x.connectivity;
Klinear             =  MatInfo.Klinear;
for ielem=1:str.mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % Compute displacements in the element 
    %----------------------------------------------------------------------
    u               =  x(:,connectivity(:,ielem)) - X(:,connectivity(:,ielem));
    %----------------------------------------------------------------------
    % Determine residual and stiffness combining nonlinear and linear models
    %----------------------------------------------------------------------
    Tdata(:,ielem)  =  density(ielem)*(Klinear*u(:)) + (1 - density(ielem))*(void_factor*Klinear*u(:));
    Kdata(:,ielem)  =  density(ielem)*Klinear(:) + (1 - density(ielem))*void_factor*Klinear(:);
end     
%toc 
%--------------------------------------------------------------------------
% Sparse assembly of the stiffness matrix.           
%--------------------------------------------------------------------------
Assembly.total_matrix    =  sparse(Assembly.sparse.Kindexi,...
                              Assembly.sparse.Kindexj,Kdata,...
                              Solution.n_dofs,Solution.n_dofs);
%--------------------------------------------------------------------------
% Sparse assembly of the residual.             
%--------------------------------------------------------------------------
Assembly.total_force  =  sparse(Assembly.sparse.Tindexi,...
                              Assembly.sparse.Tindexj,Tdata,...
                              Solution.n_dofs,1);

end





