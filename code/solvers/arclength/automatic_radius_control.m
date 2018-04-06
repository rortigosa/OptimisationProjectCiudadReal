function [str]                          =  automatic_radius_control(str)


str.arc_length.radius                   =  (str.arc_length.desired_n_iterations/str.arc_length.n_iterations)*str.arc_length.radius;
%str.arc_length.desired_n_iterations     =  str.arc_length.n_iterations;


