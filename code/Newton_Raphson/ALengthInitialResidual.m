%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Compute initial residual taking into account Dirichlet boundary
% conditions
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str                           =  ALengthInitialResidual(str,old_solution)

%--------------------------------------------------------------------------
% Compute Neumann forces/electric charges
%--------------------------------------------------------------------------
str                                    =  NeumannBcs(str);
former_force_vector                    =  str.bc.Neumann.force_vector*str.NR.accumulated_factor;

%--------------------------------------------------------------------------
% Initial residual for static or dynamic cases
%--------------------------------------------------------------------------
         %-----------------------------------------------------------------
         % Difference between the Neumann forces vectors between each load
         % increment  
         %-----------------------------------------------------------------
         former_force_vector           =  (str.NR.accumulated_factor - str.NR.load_factor)*str.bc.Neumann.force_vector;
         str.bc.Neumann.force_vector   =  str.NR.accumulated_factor*str.bc.Neumann.force_vector;
         diff_force_vector             =  str.bc.Neumann.force_vector - former_force_vector;
         %-----------------------------------------------------------------
         % Compute the residual based on the Neumann forces 
         %-----------------------------------------------------------------        
         dofs                          =  size(diff_force_vector,1);
         str.assembly.Residual(1:dofs,...
             1)                        =  str.assembly.Residual(1:dofs,1) - diff_force_vector;
end