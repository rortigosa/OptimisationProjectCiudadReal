function    str                    =  NeumannBcsElectro(str)
%--------------------------------------------------------------------------
% External electric force vector
%--------------------------------------------------------------------------
phi_distributed                    =  DistributedElectricCharge(str);    
str.bc.Neumann.phi.force_vector    =  phi_distributed;
%--------------------------------------------------------------------------
% External force vector
%--------------------------------------------------------------------------
str.bc.Neumann.force_vector        =  str.bc.Neumann.phi.force_vector;

