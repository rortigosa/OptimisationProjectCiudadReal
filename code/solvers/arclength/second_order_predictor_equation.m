function [Dlambda_1,Dlambda_2]     =  second_order_predictor_equation(str,invKK,matrix,Ext_force_vector)


%--------------------------------------------------------------------------
% a,b,c for second order equation.
%--------------------------------------------------------------------------

a                                              =  Ext_force_vector'*matrix*Ext_force_vector +...
                                                  str.arc_length.U_prsc_dp;
b                                              =  2*(str.arc_length.lambda0*Ext_force_vector'*invKK*Ext_force_vector -...
                                                  str.assemb_force.reduced_force'*invKK*Ext_force_vector);
c                                              =  str.assemb_force.reduced_force'*invKK*str.assemb_force.reduced_force +...
                                                  str.arc_length.lambda0^2*Ext_force_vector'*invKK*Ext_force_vector +...
                                                  -2*str.arc_length.lambda0*str.assemb_force.reduced_force'*invKK*Ext_force_vector -...
                                                  str.arc_length.radius^2;

Dlambda_1                                      =  (-b+sqrt(b^2-4*a*c))/(2*a);
Dlambda_2                                      =  (-b-sqrt(b^2-4*a*c))/(2*a);
