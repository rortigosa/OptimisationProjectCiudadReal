%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Compute initial residual taking into account Dirichlet boundary
% conditions
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Assembly         =  ArcLengthInitialResidual(dim,formulation,...
                                         Mesh,UserDefinedFuncs,Bc,Assembly,NR)
%--------------------------------------------------------------------------
% Compute Neumann forces/electric charges 
%--------------------------------------------------------------------------
Bc                        =  NeumannBcs(dim,formulation,Mesh,UserDefinedFuncs,Bc);
%--------------------------------------------------------------------------
% Compute the residual for static or dynamic simulations
%--------------------------------------------------------------------------
dofs                      =  (1:size(Bc.Neumann.force_vector,1))';        
Assembly.Residual(dofs,...
            1)            =  Assembly.total_force(dofs) -  ...
                             Bc.Neumann.force_vector*NR.accumulated_factor;                                     


