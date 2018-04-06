%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Store Lagrangian and Eulerian coordinates. Add contribution from
% Dirichlet BCs just to the Eulerian coordinates. The Lagrangian
% coordinates remain untouched.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Solution        =  InitialisedFields(Geometry,Mesh,formulation) 
  
switch formulation
    case 'u'
        Solution         =  InitialisedVariablesU(Geometry,Mesh);        
    case 'up'
        Solution         =  InitialisedVariablesUP(Geometry,Mesh);        
end                                  
%--------------------------------------------------------------------------
% Initialisation of the incremental solution for the Newton-Raphson algorithm
%--------------------------------------------------------------------------
Solution.incremental_solution     =  zeros(Solution.n_dofs,1);
% %--------------------------------------------------------------------------
% %  Lagrange multipliers for contact
% %--------------------------------------------------------------------------
% if str.contact.lagrange_multiplier
%    Solution.contact_multiplier    =  zeros(Mesh.surface.contact_multiplier.n_nodes,1);
% end
%--------------------------------------------------------------------------
%  Fields in previous load/time iteration
%--------------------------------------------------------------------------
Solution.old          =  Solution;


