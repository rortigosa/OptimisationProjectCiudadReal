function [solution,str]                         =  output_arclength_v6(physics,solution,constraint_dof_u,sk,total_u_fixed,str,iteration)



arc_length_radius                               =  str.arc_length_radius;

mechanical_scaling                              =  1; 
potential_scaling                               =  1e1*str.properties.material_parameters.e(1)/sqrt(str.properties.material_parameters.mu(1)*str.properties.material_parameters.e(1));

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Stiffness matrices   
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
fixed_potential                                 =  zeros(str.n_nodes,1);
fixed_potential(str.elec.freedof_prescribed)    =  str.elec.freedof_prescribed_value;                  
Kxx                                             =  physics.K_matrix;
KxT0                                            =  zeros(size(str.assemb_matrix.total_matrix,1),size(str.freedof_prescribed,1));
KxT0(str.freedof_prescribed,...
    (1:size(str.freedof_prescribed,1))')        =  eye(size(str.freedof_prescribed,1));

KxT0(str.fixdof_arclength,:)                    =  [];
KxT0                                            =  sparse(KxT0);


%--------------------------------------------------------------------------
% Kulambda according to linear Dirichlet boundary conditions
%--------------------------------------------------------------------------
X_prescribed0                                   =  [str.fixed_displacement(:);fixed_potential];
X_prescribed0_auxiliar                          =  X_prescribed0(str.freedof_prescribed);
X_prescribed0                                   =  X_prescribed0_auxiliar;
Kulambda                                         =  sparse(zeros(size(Kxx,1)+size(KxT0,2),1));
Kulambda(size(Kxx,1)+1:size(Kxx,1)+size(KxT0,2)) =  -X_prescribed0;


%--------------------------------------------------------------------------
% Global assembly of the matrix
%--------------------------------------------------------------------------
Kuu                                             =  [Kxx;KxT0'];
rows                                            =  1:size(Kxx,1);
columns                                         =  size(Kxx,1)+1:size(Kxx,1) + size(X_prescribed0,1);
Kuu(rows,columns)                               =  KxT0;

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Residuals
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
Rx                                              =  physics.Residual;

%--------------------------------------------------------------------------
% RT0 according to linear Dirichlet boundary conditions
%--------------------------------------------------------------------------
RT0                                             =  [str.Eulerian_x(:) - str.Lagrangian_X(:) - str.data.acumulated_factor*str.fixed_displacement(:);str.phi - str.data.acumulated_factor*fixed_potential];
RT0_aux                                         =  RT0(str.freedof_prescribed);
RT0                                             =  RT0_aux;
  

Rx(str.freedof_prescribed)                      =  Rx(str.freedof_prescribed) + str.T0_arclength;   %  The residual Rx must include the contribution T0
Rx(str.fixdof_arclength,:)                      =  [];
RU                                              =  [Rx;RT0];
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Dx   =  -Ru - Rw0*Deltalambda  
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
Ru                                              =  (Kuu\RU);
Ru                                              =  Ru(1:size(Kxx,1));
 

vector3                                         =  (Kuu\Kulambda);
vector3                                         =  vector3(1:size(Kxx,1));
Rw0                                             =  vector3;


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Coefficients of the second order polynomial   
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
freedof                                         =  str.freedof_arclength; 
am                                     =  -Ru(freedof<=str.n_nodes*3);
bm                                     =  -Rw0(freedof<=str.n_nodes*3);
ae                                     =  -Ru(freedof>str.n_nodes*3);
be                                     =  -Rw0(freedof>str.n_nodes*3);
a                                      =  [am*mechanical_scaling;ae*potential_scaling];
b                                      =  [bm*mechanical_scaling;be*potential_scaling];

T                                               =  0*(total_u_fixed'*total_u_fixed);
A                                               =  b'*b;
B                                               =  2*a'*b + 2*solution.Du'*b + 2*solution.Dw0*(T);
C                                               =  a'*a + 2*a'*solution.Du + solution.Du'*solution.Du + (T)*solution.Dw0^2 - arc_length_radius^2;
Dw01                                            =  real(-B  -  sqrt(B^2 - 4*A*C))/(2*A);
Dw02                                            =  real(-B  +  sqrt(B^2 - 4*A*C))/(2*A);

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
switch iteration   
    case 0  
         %-----------------------------------------------------------------
         % Predictor according to criterion by Feng
         %-----------------------------------------------------------------
         if norm(solution.Du_old)>0
            Dw0                                 =  sign(solution.Du_old'*b)*arc_length_radius/sqrt(b'*b);
         else
            Dw01                                =  arc_length_radius/sqrt(b'*b);
            Dw02                                =  -arc_length_radius/sqrt(b'*b);
        
            Delta_solution1                     =  a + b*Dw01;
            Delta_solution2                     =  a + b*Dw02;
        
                        u1                      =  Delta_solution1(constraint_dof_u);
                        u2                      =  Delta_solution2(constraint_dof_u);        
            [maximum,identifier]                =  max([u1 u2]);
            switch identifier
                   case 1
                        Dw0                     =  Dw01;
                   case 2
                        Dw0                     =  Dw02;
            end                            
         end         
         %-----------------------------------------------------------------
         %  Update
         %-----------------------------------------------------------------
          solution.w0                           =  0;
                  solution.Du                   =  zeros(size(freedof,1),1);   
          solution.Dw0                          =  0;
          solution.Dw0_incremental              =  Dw0;
    otherwise
          Delta_solution1                       =  a +  b*Dw01;  
          Delta_solution2                       =  a +  b*Dw02;
         

          sk1_1                                 =  (solution.Du + Delta_solution1(1:size(solution.Du,1)));
          sk1_2                                 =  (solution.Du + Delta_solution2(1:size(solution.Du,1)));
          cos_theta1                            =  (sk'*sk1_1)/arc_length_radius^2;
          cos_theta2                            =  (sk'*sk1_2)/arc_length_radius^2;
          theta1                                =  abs(acos(cos_theta1));
          theta2                                =  abs(acos(cos_theta2));
          [min_theta,identifier]                =  min([theta1 theta2]); 
         
          switch identifier 
                 case 1
                      solution.Dw0_incremental  =  Dw01;
                 case 2
                      solution.Dw0_incremental  =  Dw02; 
         end    
end     

%--------------------------------------------------------------------------
%  Update      
%--------------------------------------------------------------------------
solution.Du                                     =  solution.Du   +  a + b*solution.Dw0_incremental;
solution.DU                                     =  solution.Du;
solution.Dw0                                    =  solution.Dw0  +  solution.Dw0_incremental;
solution.w0                                     =  solution.w0   +  solution.Dw0_incremental;

%-----------------------------------------------------------------
%  Update of remaining variables (displacements, potential,
%  pressure... for the remaining nodels)     
%-----------------------------------------------------------------
str.solu.solution_incremented(str.freedof_arclength,...
    1)                                          =  -Ru - Rw0*solution.Dw0_incremental;
str                                             =  updated_incremental_potential(str);
str                                             =  updated_incremental_geometry(str);

DT0                                             =  -(Kuu\(RU + Kulambda*solution.Dw0_incremental));
DT0                                             =  DT0(size(Kxx,1)+1:size(DT0,1));
str.T0_arclength                                =  str.T0_arclength + DT0;

 
%--------------------------------------------------------------------------
%  Update acumulated factor    
%--------------------------------------------------------------------------
str.data.acumulated_factor                      =  str.data.acumulated_factor + solution.Dw0_incremental;




