%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Update the fields x-phi in this formulation
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function solution                =  UpdatedIncrementalVariablesU(dim,mesh,solution,time_integrator,contact) 
%--------------------------------------------------------------------------
% Update x 
%--------------------------------------------------------------------------
initial                          =  1;
final                            =  dim*mesh.volume.x.n_nodes;
D_x                              =  reshape(solution.incremental_solution(initial:final),dim,mesh.volume.x.n_nodes);
solution.x.Eulerian_x            =  solution.x.Eulerian_x + D_x;
%--------------------------------------------------------------------------
% Update multiplier for contact 
%--------------------------------------------------------------------------
if ~ischar(contact)
   initial                       =  final + 1;
   final                         =  initial - 1 + size(solution.contact_multiplier,1);   
   D_multiplier                  =  solution.incremental_solution(initial:final);
   if isempty(D_multiplier)
   else
   solution.contact_multiplier   =  solution.contact_multiplier + D_multiplier;    
   end
end
% %--------------------------------------------------------------------------
% % Velocity and acceleration in dynamic problems
% %--------------------------------------------------------------------------
% solution                         =  VelocityAccelerationUpdate(time_integrator,solution,D_x);



