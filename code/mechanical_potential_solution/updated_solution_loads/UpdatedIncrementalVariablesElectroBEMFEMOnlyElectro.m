%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Update the fields x-phi in this formulation
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function solution                =  UpdatedIncrementalVariablesElectroBEMFEMOnlyElectro(mesh,solution) 
%--------------------------------------------------------------------------
% Update phi
%--------------------------------------------------------------------------
initial                          =  1;
final                            =  initial - 1 + mesh.volume.phi.n_nodes;
D_phi                            =  solution.incremental_solution(initial:final);
solution.phi                     =  solution.phi + D_phi;
%--------------------------------------------------------------------------
% Update q
%--------------------------------------------------------------------------
initial                          =  final + 1;
final                            =  initial - 1 + mesh.surface.q.n_nodes;
D_q                              =  solution.incremental_solution(initial:final);
solution.q                       =  solution.q + D_q;



