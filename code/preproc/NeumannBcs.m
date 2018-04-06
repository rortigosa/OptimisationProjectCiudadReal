%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Specify nodal loads
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Bc     =  NeumannBcs(dim,formulation,Mesh,UserDefinedFuncs,Bc)

switch formulation
    case {'u','up','FHJ','CGC','CGCCascade'}
         Bc     =  NeumannBcsMechanics(dim,Bc.Neumann.load_factor,...
                              Mesh.volume.x.nodes,Mesh.volume.x.n_nodes,...
                              UserDefinedFuncs,Bc);        
end

