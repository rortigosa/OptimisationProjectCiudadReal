function [str]                                        =  fixed_point_internalforce(str,determinant,invKK,matrix,Ext_force_vector,K)

%--------------------------------------------------------------------------
% Initialised necessary variables.
%--------------------------------------------------------------------------
iteration                                             =  0;      
Residual                                              =  1e8;
[str]                                                 =  starting_point_predictor(str);
oldnorm                                               =  norm(str.arc_length.Fint0);
str.assemb_force.reduced_force                        =  str.arc_length.Fint0;  
Residuallambda                                        =  1e8;
oldDlambda                                            =  str.arc_length.predictor_Dlambda;
str.arc_length.Dlambda                                =  str.arc_length.predictor_Dlambda;
if 0
while abs(Residuallambda)>5 && iteration<30
       iteration                                      =  iteration + 1;
       %-------------------------------------------------------------------
       % Second order equation for Dlambda
       %-------------------------------------------------------------------
       [Dlambda_1,Dlambda_2]                          =  second_order_predictor_equation(str,invKK,matrix,Ext_force_vector);       
       %--------------------------------------------------------------------------
       %  Criterion to choose initial value for DLambda.
       %--------------------------------------------------------------------------
       if sign(determinant)==sign(Dlambda_1)
           str.arc_length.Dlambda                     =  Dlambda_1;
       elseif sign(determinant)==sign(Dlambda_2)
           str.arc_length.Dlambda                     =  Dlambda_2;
       end
       str.arc_length.lambda                          =  str.arc_length.lambda0 + str.arc_length.Dlambda;
       %----------------------------------------------------------------------
       % New constrained configuration.
       %----------------------------------------------------------------------
       [str]                                          =  updated_constrained_geometry(str);
       [str]                                          =  updated_constrained_potential(str);
       %--------------------------------------------------------------------------
       % Stiffness matrix in the configuration.
       %--------------------------------------------------------------------------
       str.assemb_matrix.old_reduced_matrix           =  K;
       [str]                                          =  reduced_entities(str);
       str.assemb_matrix.reduced_matrix               =  str.assemb_matrix.old_reduced_matrix;
%        %--------------------------------------------------------------------------
%        %  Initial value for displacement.
%        %--------------------------------------------------------------------------
%        Residual                                       =  str.assemb_force.reduced_force-str.arc_length.lambda*Ext_force_vector;       
%        str.arc_length.Dxk(str.freedof)                =  -str.assemb_matrix.reduced_matrix\Residual;
%        %----------------------------------------------------------------------
%        % Updated geometry.
%        %----------------------------------------------------------------------
%        str.arc_length.net_displacement                =  zeros((str.data.dim+1)*str.n_nodes,1);
%        last1                                          =  str.data.dim*str.n_nodes;
%        str.arc_length.net_displacement(1:last1,1)     =  str.arc_length.Dxk(1:last1,1);
%        [str]                                          =  updated_geometry(str);
%        %----------------------------------------------------------------------
%        % Updated potential.
%        %----------------------------------------------------------------------
%        last2                                           =  last1  + str.n_nodes;
%        str.arc_length.net_displacement(last1+1:last2,1)=  str.arc_length.Dxk(last1 + 1:last2,1);
%        [str]                                           =  updated_potential(str);       
% %        %--------------------------------------------------------------------------
% %        % Stiffness matrix in the configuration.
% %        %--------------------------------------------------------------------------
% %        [str]                                          =  reduced_entities(str);       
       %--------------------------------------------------------------------------       
       %  New norm of the internal force.
       %--------------------------------------------------------------------------              
       newnorm                                        =  norm(str.assemb_force.reduced_force);
       newDlambda                                     =  str.arc_length.Dlambda;
       %--------------------------------------------------------------------------
       %  Residual. 
       %--------------------------------------------------------------------------                     
       Residual                                       =  abs(newnorm-oldnorm);
       Residuallambda                                 =  abs(newDlambda - oldDlambda)/oldDlambda*100;
       fprintf('Residual of the predictor %f for iteration %d\n',Residuallambda,iteration);
       %--------------------------------------------------------------------------
       %  Old norm of the internal force.
       %--------------------------------------------------------------------------
       oldnorm                                        =  norm(str.assemb_force.reduced_force);       
       oldDlambda                                     =  str.arc_length.Dlambda;
end
end