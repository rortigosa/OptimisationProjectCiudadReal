%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function updates the forces and matrices for the next Newton Raphson 
% iteration.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function Assembly    =  ArcLengthResidualUpdate(dim,formulation,Mesh,UserDefinedFuncs,Bc,Assembly,NR)

%--------------------------------------------------------------------------
% Compute Neumann forces/electric charges
%--------------------------------------------------------------------------
Bc                   =  NeumannBcs(dim,formulation,Mesh,UserDefinedFuncs,Bc);
%--------------------------------------------------------------------------
% Initialise the residual
%--------------------------------------------------------------------------
Assembly.Residual    =  Assembly.total_force;
dofs                 =  (1:size(Bc.Neumann.force_vector,1))';        
%--------------------------------------------------------------------------
% Compute the residual for static or dynamic simulations
%--------------------------------------------------------------------------
Assembly.Residual(dofs,...
            1)       =  Assembly.total_force(dofs) -  ...
                             Bc.Neumann.force_vector*NR.accumulated_factor;                                     
                                     