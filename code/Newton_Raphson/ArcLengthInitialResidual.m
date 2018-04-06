%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Compute initial residual taking into account Dirichlet boundary
% conditions
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str               =  ArcLengthInitialResidual(str)

%--------------------------------------------------------------------------
% Compute Neumann forces/electric charges 
%--------------------------------------------------------------------------
str                        =  NeumannBcs(str);
%--------------------------------------------------------------------------
% Get value for the incremental load factor.
%--------------------------------------------------------------------------
%str.NR                     =  ArcLengthRootFinding(str.NR,str.AL,str.assembly,str.bc,str.solution);
%--------------------------------------------------------------------------
% Compute the residual for static or dynamic simulations
%--------------------------------------------------------------------------
dofs                      =  (1:size(str.bc.Neumann.force_vector,1))';        
str.assembly.Residual(dofs,...
            1)            =  str.assembly.total_force(dofs) -  ...
                             str.bc.Neumann.force_vector*str.NR.accumulated_factor;                                     


