%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update the value of the Eulerian coordinates using the solution obtained
% in the solution stage.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [str]                            =  updated_potential(str) 

%----------------------------------------------------------------
% 1.Update the free mechanical degrees of freedoms with the 
%   incremental solution.
%----------------------------------------------------------------
%-----------------------------------------------------------
% 1.1 Update of the solution corresponding to the static case.
%-----------------------------------------------------------
ini                                       =  str.data.dim*str.n_nodes;
final                                     =  ini + str.n_nodes;
str.phi                                   =  str.phi + str.arc_length.net_displacement(ini+1:final,1);
