function    str                    =  NeumannBcsElectroMechanics(str)
%--------------------------------------------------------------------------
% External nodal forces
%--------------------------------------------------------------------------
P_nodal                            =  NodalLoads(str);    
P_distributed                      =  DistributedLoads(str);    
str.bc.Neumann.x.force_vector      =  P_nodal + P_distributed;    
%--------------------------------------------------------------------------
% External electric force vector
%--------------------------------------------------------------------------
phi_distributed                    =  DistributedElectricCharge(str);    
str.bc.Neumann.phi.force_vector    =  phi_distributed;
%--------------------------------------------------------------------------
% External force vector
%--------------------------------------------------------------------------
str.bc.Neumann.force_vector        =  [str.bc.Neumann.x.force_vector;...
                                       str.bc.Neumann.phi.force_vector];

