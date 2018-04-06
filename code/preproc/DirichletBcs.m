%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This function is responsible for the treatment of the contraints in the
% problem
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Bc                     =  DirichletBcs(dim,formulation,Mesh,...
                                                 Solution,UserDefinedFuncs)

%--------------------------------------------------------------------------
% Constraints for x
%--------------------------------------------------------------------------
switch formulation
    case {'electro'}
n_dofs                           =  0;        
    otherwise
[fixdof_u,freedof_u,...
    cons_val_u]              =  UserDefinedFuncs.MechanicalDirichletBCs(Mesh.volume.x.n_nodes,Mesh.volume.x.nodes,dim); 

Bc.Dirichlet.x.freedof       =  freedof_u;
Bc.Dirichlet.x.fixdof        =  fixdof_u;
Bc.Dirichlet.x.cons_val      =  cons_val_u;
n_dofs                       =  size(Solution.x.Eulerian_x(:),1);
end
%--------------------------------------------------------------------------
% Constraints for p
%--------------------------------------------------------------------------
switch formulation
    case {'up'}
          freedof_p              =  (1:size(Solution.pressure,1))' + n_dofs;
          fixdof_p               =  [];
end
%--------------------------------------------------------------------------
% fixdof, freedof and fixed value 
%--------------------------------------------------------------------------
switch formulation
    case 'u'
         Bc.Dirichlet.fixdof   =  fixdof_u;
         Bc.Dirichlet.freedof  =  freedof_u;
         Bc.Dirichlet.cons_val =  cons_val_u;               
    case 'up'
         Bc.Dirichlet.fixdof   =  [fixdof_u;   fixdof_p];
         Bc.Dirichlet.freedof  =  [freedof_u;  freedof_p];
         Bc.Dirichlet.cons_val =  cons_val_u;               
end        


