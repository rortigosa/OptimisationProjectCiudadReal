%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function updates the forces and matrices for the next Newton Raphson 
% iteration.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function str              =  ArcLengthResidualUpdate(str)

%--------------------------------------------------------------------------
% Compute Neumann forces/electric charges
%--------------------------------------------------------------------------
str                       =  NeumannBcs(str);
%--------------------------------------------------------------------------
% Initialise the residual
%--------------------------------------------------------------------------
str.assembly.Residual     =  str.assembly.total_force;
dofs                      =  (1:size(str.bc.Neumann.force_vector,1))';        
%--------------------------------------------------------------------------
% Compute the residual for static or dynamic simulations
%--------------------------------------------------------------------------
str.assembly.Residual(dofs,...
            1)            =  str.assembly.total_force(dofs) -  ...
                             str.bc.Neumann.force_vector*str.NR.accumulated_factor;                                     
% %--------------------------------------------------------------------------
% % Get value for the incremental load factor.
% %--------------------------------------------------------------------------
% str.NR                    =  ArcLengthRootFinding(str.NR,str.AL,...
%                                          str.assembly,str.bc,str.solution);
% %--------------------------------------------------------------------------
% % Update finally the residual
% %--------------------------------------------------------------------------
% str.assembly.Residual(dofs,...
%             1)            =  str.assembly.total_force(dofs) -  ...
%                              str.bc.Neumann.force_vector*str.NR.accumulated_factor;
                                     