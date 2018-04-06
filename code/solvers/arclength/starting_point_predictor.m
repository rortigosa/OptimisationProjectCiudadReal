function             [str]        =  starting_point_predictor(str)

str.arc_length.predictor_Dlambda  =  str.arc_length.radius/sqrt(2*str.arc_length.U_prsc_dp);
if 0
str.arc_length.old_lambda         =  str.arc_length.lambda;
str.arc_length.lambda             =  str.arc_length.lambda + str.arc_length.predictor_Dlambda;
[str]                             =  updated_constrained_geometry(str);
[str]                             =  updated_constrained_potential(str);
[str]                             =  reduced_entities(str);
str.arc_length.Fint0              =  str.assemb_force.reduced_force;
str.arc_length.lambda             =  str.arc_length.old_lambda;
end