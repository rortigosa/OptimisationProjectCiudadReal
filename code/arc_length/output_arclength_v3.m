function [str]                         =  output_arclength_v3(str)



arc_length_radius                               =  str.arc_length_radius;

% %mechanical_activation                          =  1;
% %electric_activation                            =  1;
% mechanical_scaling                              =  1;
% %potential_scaling                              =  1e5*str.properties.material_parameters.e/sqrt(str.properties.material_parameters.mu*str.properties.material_parameters.e);
% potential_scaling                               =  0*1e0*str.properties.material_parameters.e/sqrt(str.properties.material_parameters.mu*str.properties.material_parameters.e);
% %scaling                                        =  1/sqrt(str.properties.material_parameters.mu*str.properties.material_parameters.e)/str.data.scaling_area;
% 
% scaling                                         =  str.arc_length_scaling;


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Stiffness matrices 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
fixed_potential                                 =  zeros(str.n_nodes,1);
fixed_potential(str.elec.freedof_prescribed)    =  str.elec.freedof_prescribed_value;                  
%--------------------------------------------------------------------------
% Kxx
%--------------------------------------------------------------------------
Kxx                                             =  str.assemb_matrix.total_matrix(str.freedof_arclength,str.freedof_arclength);
%--------------------------------------------------------------------------
% KxT0
%--------------------------------------------------------------------------
KxT0                                            =  zeros(size(str.assemb_matrix.total_matrix,1),size(str.freedof_prescribed,1));
KxT0(str.freedof_prescribed,...
    (1:size(str.freedof_prescribed,1))')        =  eye(size(str.freedof_prescribed,1));

KxT0(str.fixdof_arclength,:)                    =  [];
KxT0                                            =  sparse(KxT0);
%--------------------------------------------------------------------------
% KT0lambda
%--------------------------------------------------------------------------
X_prescribed0                                   =  [str.fixed_displacement(:);fixed_potential];
X_prescribed0_auxiliar                          =  X_prescribed0(str.freedof_prescribed);
X_prescribed0                                   =  X_prescribed0_auxiliar;
KT0lambda                                       =  sparse(X_prescribed0);
%--------------------------------------------------------------------------
% Klambdax
%--------------------------------------------------------------------------
U                                               =  str.Eulerian_x(:) - str.Lagrangian_X(:);
U                                               =  [U;zeros(str.n_nodes,1)];
U                                               =  U(str.freedof_arclength,1);
Klambdax                                        =  sparse(2*U');

%--------------------------------------------------------------------------
% Global assembly of the matrix
%--------------------------------------------------------------------------
K_assembled                                     =  [Kxx;KxT0';Klambdax];
rows                                            =  1:size(Kxx,1);
columns                                         =  size(Kxx,1)+1:size(Kxx,1) + size(X_prescribed0,1);
K_assembled(rows,columns)                       =  KxT0;
rows                                            =  size(Kxx,1)+1:size(Kxx,1) + size(X_prescribed0,1);
columns                                         =  size(Kxx,1)+ size(X_prescribed0,1) + 1;
K_assembled(rows,columns)                       =  -KT0lambda;

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Residuals
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Rx
%--------------------------------------------------------------------------
Rx                                              =  str.Residual.Residual;
Rx(str.freedof_prescribed)                      =  Rx(str.freedof_prescribed) + str.T0_arclength;   %  The residual Rx must include the contribution T0
Rx(str.fixdof_arclength,:)                      =  [];
%--------------------------------------------------------------------------
% RT0 
%--------------------------------------------------------------------------
RT0                                             =  [str.Eulerian_x(:) - str.Lagrangian_X(:) - str.data.acumulated_factor*str.fixed_displacement(:);str.phi - str.data.acumulated_factor*fixed_potential];
RT0_aux                                         =  RT0(str.freedof_prescribed);
RT0                                             =  RT0_aux;
%--------------------------------------------------------------------------
% Rlambda
%--------------------------------------------------------------------------
Rlambda                                         =  U'*U - arc_length_radius^2;
%--------------------------------------------------------------------------
% Global assembly of the residual
%--------------------------------------------------------------------------
R_assembled                                     =  [Rx;RT0;Rlambda];


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Solution of system
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
u       =  -K_assembled\R_assembled;

%--------------------------------------------------------------------------
% Coefficients of the second order polynomial 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%  Update      
%--------------------------------------------------------------------------

%-----------------------------------------------------------------
%  Update of remaining variables (displacements, potential,
%  pressure... for the remaining nodels)    
%-----------------------------------------------------------------
str.solu.solution_incremented(str.freedof_arclength,...
    1)                                          =  u(1:size(str.freedof_arclength,1));
str                                             =  updated_incremental_potential(str);
str                                             =  updated_incremental_geometry(str);

DT0                                             =  u(size(str.freedof_arclength,1)+1:size(str.freedof_arclength,1)+size(str.T0_arclength,1));
str.T0_arclength                                =  str.T0_arclength + DT0;

Dlambda                                         =  u(size(u,1),1);
str.data.acumulated_factor                      =  str.data.acumulated_factor + Dlambda;
%--------------------------------------------------------------------------
%  Update acumulated factor   
%--------------------------------------------------------------------------
%str                                             =  updated_constrained_potential(str);



