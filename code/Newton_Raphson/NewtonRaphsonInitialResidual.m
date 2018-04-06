%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Compute initial residual taking into account Dirichlet boundary
% conditions
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Assembly      =  NewtonRaphsonInitialResidual(Data,old_solution,...
                              Geometry,Bc,Mesh,Solution,UserDefinedFuncs,NR,Assembly)

%--------------------------------------------------------------------------
% Compute Neumann forces/electric charges
%--------------------------------------------------------------------------
Bc     =  NeumannBcs(Geometry.dim,Data.formulation,Mesh,UserDefinedFuncs,Bc);
%--------------------------------------------------------------------------
% Initial residual for static or dynamic cases
%--------------------------------------------------------------------------
%-----------------------------------------------------------------
% Difference between the Neumann forces vectors between each load
% increment
%-----------------------------------------------------------------
former_force_vector       =  (NR.accumulated_factor - NR.load_factor)*Bc.Neumann.force_vector;
diff_force_vector         =  NR.accumulated_factor*Bc.Neumann.force_vector - former_force_vector;
%-----------------------------------------------------------------
% Compute the residual based on the Neumann forces
%-----------------------------------------------------------------
dofs                      =  size(diff_force_vector,1);
Assembly.Residual(1:dofs,...
    1)                    =  Assembly.Residual(1:dofs,1) - diff_force_vector;
diff_fields               =  DiffFieldsFunction(Data.formulation,Solution,old_solution);
%-----------------------------------------------------------------
% Stiffness matrix K(free,constrained).
%-----------------------------------------------------------------
constrained_dofs          =  (1:size(diff_fields,1))';
constrained_dofs(Bc.Dirichlet.freedof,...
    :)                    =  [];
Delta_constrained_dofs    =  diff_fields(constrained_dofs);
reduced_matrix            =  Assembly.total_matrix(Bc.Dirichlet.freedof,constrained_dofs);
%-----------------------------------------------------------------
% Residual=.K(free,constrained)*Deltaconstrained.
%-----------------------------------------------------------------
Assembly.Residual(Bc.Dirichlet.freedof,...
    1)                    =  Assembly.Residual(Bc.Dirichlet.freedof,1) + ...
                                     reduced_matrix*Delta_constrained_dofs;
