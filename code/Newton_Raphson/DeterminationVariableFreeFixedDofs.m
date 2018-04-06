%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% In this function, we re-compute the new free and fixed dofs in problems
% where these might change like: 
% a) problems involving contact.
% b) problems involving fracture (this has to be done!)
% 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [freedof,fixdof]  =  DeterminationVariableFreeFixedDofs(Contact,Solution,Bc,NR)
%--------------------------------------------------------------------------
% Determination of the new free and fixed dofsx considering the active set 
% due to a contact problem
%--------------------------------------------------------------------------
[freedof,fixdof]       =  DeterminationDofsContact(Contact,Solution,Bc,NR.iteration);
%--------------------------------------------------------------------------
% For the future, we might include fracture...
%--------------------------------------------------------------------------
%[freedof,fixdof]      =  determination_dofs_phase_field_fracture(str.contact,str.solution,str.bc,str.NR.NR_iteration);