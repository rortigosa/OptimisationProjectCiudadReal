%----------------------------------------------------------------------
% Quadratic equation in arc length corrector step.
%----------------------------------------------------------------------

function [a,b,c,root]     =  quadratic_function(ut,uhat,Dxk,str)                     

t1                      =  ut'*ut;
switch str.data.problem
    case 'electromechanical'
      t2                =  str.arc_length.scaling_factor^2*str.nodal_loads.P(str.mec_freedof)'*str.nodal_loads.P(str.mec_freedof) ...
                                                + str.arc_length.U_prsc_dp;
    case 'mechanical'
      t2                =  str.arc_length.scaling_factor^2*str.nodal_loads.P(str.mec_freedof)'*str.nodal_loads.P(str.mec_freedof) ...
                                                + str.arc_length.U_prsc_dp;
    case 'electric'        
      t2                =  (str.arc_length.U_prsc_dp);
end        
a                       =  t1 + t2;

t1                      =  2*ut'*(Dxk(str.freedof) + uhat);
t2                      =  2*str.arc_length.Dlambda*t2;
b                       =  t1 + t2;

t1                      =  (Dxk(str.freedof) + uhat)'*(Dxk(str.freedof) + uhat);
t2                      =   str.arc_length.Dlambda*t2/2-(str.arc_length.radius^2) ;
c                       =  t1 + t2;


root                    =  b^2 - 4*a*c;

