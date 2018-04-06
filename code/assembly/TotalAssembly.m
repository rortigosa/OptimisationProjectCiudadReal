%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assembly of all the contributions of the problem
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str                    =  TotalAssembly(str)    

%--------------------------------------------------------------------------
% Assembly of residuals and stiffness matrices for: 
% a) Internal work contribution
%--------------------------------------------------------------------------
str                             =  InternalWorkAssemblyFormulation(str);
%--------------------------------------------------------------------------
% Assembly of all the contributions of the stiffness matrices and 
% residual vectors including inertial and viscous terms
%--------------------------------------------------------------------------
str                             =  StiffnessMatrixTotalAssembly(str);
str                             =  ParallelResidualsTotalAssembly(str);
% %--------------------------------------------------------------------------
% % Add contact contribution 
% %--------------------------------------------------------------------------
% if str.contact.lagrange_multiplier
%     str.assembly.total_force    =  [str.assembly.total_force;str.assembly.Tcontact_multiplier]; 
% end




