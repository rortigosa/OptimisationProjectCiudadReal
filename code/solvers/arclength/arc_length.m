%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This is the main program that will execute all the functions.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function  [str]                                 =  arc_length(str)

%--------------------------------------------------------------------------
% Setting the type of analysis as static.
%--------------------------------------------------------------------------
str.data.analysis                               =  'static';

%----------------------------------------------------------------------
% Initialisation phase. 
%--------------------------------------------------------------------------  
str.time_iteration                              =  1;
str.time                                        =  0;
%----------------------------------------------------------------------
% Initialise the incremented solution. 
%--------------------------------------------------------------------------  
if strcmp(str.data.problem,'electromechanical')
   str.solu.solution_incremented                =  zeros((str.data.dim+1)*str.n_nodes,1);
elseif strcmp(str.data.problem,'mechanical')
   str.solu.solution_incremented                =  zeros((str.data.dim)*str.n_nodes,1);
elseif strcmp(str.data.problem,'electric') 
    str.solu.solution_incremented               =  zeros(str.n_nodes,1);
end
 
%----------------------------------------------------------------------
% Constraints and loads.  
%--------------------------------------------------------------------------
[str]                                           =  constraints(str);
if strcmp(str.data.analysis,'static')
    if strcmp(str.data.problem,'electromechanical')  || strcmp(str.data.problem,'mechanical')
       [str]                                    =  nodal_loads(str);
    end
end
%--------------------------------------------------------------------------
% Initialise the residual to zero.  
%--------------------------------------------------------------------------
if strcmp(str.data.problem,'electromechanical')
   str.Residual.Residual                        =  zeros((str.data.dim+1)*str.n_nodes,1);
elseif strcmp(str.data.problem,'mechanical')
   str.Residual.Residual                        =  zeros((str.data.dim)*str.n_nodes,1);
elseif strcmp(str.data.problem,'electric')
   str.Residual.Residual                        =  zeros(str.n_nodes,1);
end
%--------------------------------------------------------------------------
% Newton Raphson algorithm.
%--------------------------------------------------------------------------
[str]                                           =  incremental_arc_length(str);

