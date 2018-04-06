%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Residual and stiffness contributions from contact
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function str                               =  ContactContributionAssembly(str)

%--------------------------------------------------------------------------
% Assembly of residuals for rigid to deformable contact
%--------------------------------------------------------------------------
if exist('rigid_contact_constraint_information.m','file')
   str                                     =  PenaltyContactAssembly(str);
   switch str.contact.method
          case 'mortar'
               str                         =  PenaltyContactAssembly(str);
          case 'node'
               str                         =  PenaltyContactAssembly(str);
   end
   if(str.contact.lagrange_multiplier)
      switch str.contact.method
             case 'mortar'
                  str                      =  LagrangeContactAssembly(str);
             case 'node'
                  str                      =  LagrangeContactAssembly(str);
      end
   end
end
