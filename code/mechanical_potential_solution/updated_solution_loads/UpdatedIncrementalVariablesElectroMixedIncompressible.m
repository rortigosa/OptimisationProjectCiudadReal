%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Update the fields x-phi-p in x-phi*-p-(F,H,J,D,d)-
% (SigmaF,SigmaH,SigmaJ,Sigmad) formulation
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function solution                =  UpdatedIncrementalVariablesElectroMixedIncompressible(dim,mesh,solution,time_integrator,contact) 
%--------------------------------------------------------------------------
% Update x 
%--------------------------------------------------------------------------
initial                          =  1;
final                            =  dim*mesh.volume.x.n_nodes;
D_x                              =  reshape(solution.incremental_solution(initial:final),dim,mesh.volume.x.n_nodes);
solution.x.Eulerian_x            =  solution.x.Eulerian_x + D_x;
%--------------------------------------------------------------------------
% Update phi
%--------------------------------------------------------------------------
initial                          =  final + 1;
final                            =  initial - 1 + mesh.volume.phi.n_nodes;
D_phi                            =  solution.incremental_solution(initial:final);
solution.phi                     =  solution.phi + D_phi;
%--------------------------------------------------------------------------
% Update pressure 
%--------------------------------------------------------------------------
initial                          =  final + 1;
final                            =  initial - 1 + mesh.volume.pressure.n_nodes;
D_p                              =  solution.incremental_solution(initial:final);
solution.pressure                =  solution.pressure + D_p;
%--------------------------------------------------------------------------
% Update multiplier for contact 
%--------------------------------------------------------------------------
if contact.lagrange_multiplier
   initial                       =  final + 1;
   final                         =  initial - 1 + size(solution.contact_multiplier,1);   
   D_multiplier                  =  solution.incremental_solution(initial:final);
   if isempty(D_multiplier)
   else
   solution.contact_multiplier   =  solution.contact_multiplier + D_multiplier;    
   end
end
%--------------------------------------------------------------------------
% Velocity and acceleration in dynamic problems
%--------------------------------------------------------------------------
solution                         =  VelocityAccelerationUpdate(time_integrator,solution,D_x);

%--------------------------------------------------------------------------
% Static condensation procedure to get (F,H,J,D0,d) and 
% (SigmaF,SigmaH,SigmaJ,Sigmad)
%--------------------------------------------------------------------------



