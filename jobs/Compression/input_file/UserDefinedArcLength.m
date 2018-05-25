%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  In this function we specify boundary conditions for the mechanical
%  physics
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function    Control         =  UserDefinedArcLength(Solution,Bc,NR)


dofs            =  find(Bc.Neumann.force_vector);
Control.Output  =  Solution.x.Eulerian_x(dofs) - Solution.x.Lagrangian_X(dofs);
Control.Input   =  NR.accumulated_factor*Bc.Neumann.force_vector(dofs);