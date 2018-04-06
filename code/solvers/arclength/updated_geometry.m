%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update the value of the Eulerian coordinates using the solution obtained
% in the solution stage.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [str]                                                =  updated_geometry(str) 

%----------------------------------------------------------------
% 1.Update the free mechanical degrees of freedoms with the 
%   incremental solution.
%----------------------------------------------------------------
%-----------------------------------------------------------
% 1.1 Update of the solution corresponding to the static case.
%-----------------------------------------------------------
for iloop1=1:str.data.dim
    str.Eulerian_x(iloop1,:)                              =  str.Eulerian_x(iloop1,:) +...
                                                             str.arc_length.net_displacement(iloop1:str.data.dim:str.n_nodes*...
                                                             str.data.dim-(str.data.dim-iloop1))';
end
