function    Bc              =  NeumannBcsMechanics(dim,load_factor,nodes,...
                                               n_nodes,UserDefinedFuncs,Bc)
%--------------------------------------------------------------------------
% External nodal forces
%--------------------------------------------------------------------------
[P_nodal,fixdofs]           =  UserDefinedFuncs.NodalLoads(dim,load_factor,...
                                                         nodes,n_nodes);    
Bc.Neumann.x.force_vector   =  P_nodal;    
Bc.Neumann.fixdof           =  fixdofs;
%--------------------------------------------------------------------------
% External force vector
%--------------------------------------------------------------------------
Bc.Neumann.force_vector     =  Bc.Neumann.x.force_vector;


