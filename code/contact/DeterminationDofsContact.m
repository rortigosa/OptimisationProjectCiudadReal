%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function determines the new free and fixed dofsx considering the
%  active set due to a contact problem
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [freedof,fixdof]   =  DeterminationDofsContact(contact,solution,bc,NR_iteration)


fixdof                   =  bc.Dirichlet.fixdof;
freedof                  =  bc.Dirichlet.freedof;


if ~ischar(contact)
   if NR_iteration>=1 
      if isfield(bc,'contact')
         inactive_set       =  1:size(solution.contact_multiplier,1);
         inactive_set(contact.active_set(:)) =  [];
         inactive_set       =  inactive_set + solution.n_dofs;
         fixdof             =  [bc.Dirichlet.fixdof;inactive_set'];
         freedof            =  (1:solution.n_dofs+size(solution.contact_multiplier,1))';
         freedof(fixdof)    =  [];
      end
   else
       fixdof               =  [bc.Dirichlet.fixdof;solution.n_dofs+(1:size(solution.contact_multiplier,1))'];
       freedof              =  (1:solution.n_dofs+size(solution.contact_multiplier,1))';
       freedof(bc.fixdof)   =  [];
   end
else
end