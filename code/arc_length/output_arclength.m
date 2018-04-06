function [solution,str]                     =  output_arclength(physics,solution,constraint_dof_u,Rw0_fixed,w0_fixed_residual,sk,total_u_fixed,str,iteration)



root_criterion                              =  'Feng';        
%root_criterion                             =  'Crisfield';        
%root_criterion                              =  'mine';

arc_length_radius                           =  str.arc_length_radius;

mechanical_activation                       =  1;
electric_activation                         =  1;
mechanical_scaling                          =  1;
%potential_scaling                           =  1e5*str.properties.material_parameters.e/sqrt(str.properties.material_parameters.mu*str.properties.material_parameters.e);
potential_scaling                          =  0*1e0*str.properties.material_parameters.e/sqrt(str.properties.material_parameters.mu*str.properties.material_parameters.e);
%potential_scaling                          =  0;
%scaling                                     =  1/sqrt(str.properties.material_parameters.mu*str.properties.material_parameters.e)/str.data.scaling_area;

scaling                                     =  str.arc_length_scaling;

Ru                                 =  physics.K_matrix\physics.Residual;
total_size                         =  size(physics.K_matrix,1);
Rw_size                            =  size(w0_fixed_residual,1);
zeros_added                        =  zeros(total_size-Rw_size,1);
Rw0                                =  -physics.K_matrix\([zeros_added;w0_fixed_residual] - physics.K_free_fixed*total_u_fixed);
 
freedof                            =  str.freedof; 
%freedof(freedof<str.n_nodes*3)     =  unique(ceil(freedof/3)*3);
switch str.arc_length_type
    case 'one_dof'
         a                         =  -Ru(constraint_dof_u);
         b                         =  -Rw0(constraint_dof_u);
    case 'all_dof'
         am                        =  -Ru(freedof<=str.n_nodes*3);
         bm                        =  -Rw0(freedof<=str.n_nodes*3);
         ae                        =  -Ru(freedof>str.n_nodes*3);
         be                        =  -Rw0(freedof>str.n_nodes*3);
         a                         =  [am*mechanical_scaling;ae*potential_scaling];
         b                         =  [bm*mechanical_scaling;be*potential_scaling];
end


% A                                =  b^2 + Rw0_fixed^2*scaling^2;
% B                                =  2*a*b + 2*solution.Du*b + 2*Rw0_fixed^2*solution.Dw0*scaling^2;
% C                                =  a^2 + 2*a*solution.Du + solution.Du^2 + Rw0_fixed^2*scaling^2*solution.Dw0^2 - arc_length_radius^2;

T                                  =  (total_u_fixed'*total_u_fixed + Rw0_fixed^2)*scaling^2;

A                                  =  b'*b + T;
B                                  =  2*a'*b + 2*solution.Du'*b + 2*solution.Dw0*(T);
C                                  =  a'*a + 2*a'*solution.Du + solution.Du'*solution.Du + (T)*solution.Dw0^2 - arc_length_radius^2;


Dw01                               =  real(-B  -  sqrt(B^2 - 4*A*C))/(2*A);
Dw02                               =  real(-B  +  sqrt(B^2 - 4*A*C))/(2*A);

 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
  
  
switch iteration
    case 0
          
%          Dw01                                =  arc_length_radius/sqrt(b'*b);
%          Dw02                                =  -arc_length_radius/sqrt(b'*b);
%         
%          Delta_solution1                     =  a + b*Dw01;
%          Delta_solution2                     =  a + b*Dw02;
%         
%           %Delta_solution1                    =  a +  b*Dw01; 
%           %Delta_solution2                    =  a +  b*Dw02;                   
%           u1                                 =  Delta_solution1(constraint_dof_u);
%           u2                                 =  Delta_solution2(constraint_dof_u);        
% %          %u1                                =  Delta_solution1;
% %          %u2                                =  Delta_solution2;                 
%           [maximum,identifier]               =  max([u1 u2]);
%           switch identifier
%              case 1
%                   %Delta_solution             =  Delta_solution1;
%                   Dw0                        =  Dw01;
%              case 2
%                   %Delta_solution             =  Delta_solution2;
%                   Dw0                        =  Dw02;
%           end                            
           

         %-----------------------------------------------------------------
         % Predictor according to criterion by Feng
         %-----------------------------------------------------------------
   switch root_criterion         
    case {'Feng'}         
         if norm(solution.Du_old)>0
            Dw0                                 =  sign(solution.Du_old'*b)*arc_length_radius/sqrt(b'*b);
            %Dw0                                 =  arc_length_radius/sqrt(b'*b);
         else
         Dw01                                =  arc_length_radius/sqrt(b'*b);
         Dw02                                =  -arc_length_radius/sqrt(b'*b);
        
         Delta_solution1                     =  a + b*Dw01;
         Delta_solution2                     =  a + b*Dw02;
        
          %Delta_solution1                    =  a +  b*Dw01; 
          %Delta_solution2                    =  a +  b*Dw02;                   
          switch str.arc_length_type
               case 'one_dof'
                    u1                       =  Delta_solution1;
                    u2                       =  Delta_solution2;        
              case 'all_dof'
                    u1                       =  Delta_solution1(constraint_dof_u);
                    u2                       =  Delta_solution2(constraint_dof_u);        
          end
%          %u1                                =  Delta_solution1;
%          %u2                                =  Delta_solution2;                 
          [maximum,identifier]               =  max([u1 u2]);
          switch identifier
             case 1
                  %Delta_solution             =  Delta_solution1;
                  Dw0                        =  Dw01;
             case 2
                  %Delta_solution             =  Delta_solution2;
                  Dw0                        =  Dw02;
          end                            
         end         
       case 'mine'
         if norm(solution.Du_old)>0
         Dw0                                 =  sign(solution.Du_old(constraint_dof_u)'*b(constraint_dof_u))*arc_length_radius/sqrt(b'*b)/1e6; 
         else
         Dw01                                =  arc_length_radius/sqrt(b'*b);
         Dw02                                =  -arc_length_radius/sqrt(b'*b);
        
         Delta_solution1                     =  a(constraint_dof_u) + b(constraint_dof_u)*Dw01;
         Delta_solution2                     =  a(constraint_dof_u) + b(constraint_dof_u)*Dw02;
        
          %Delta_solution1                    =  a +  b*Dw01; 
          %Delta_solution2                    =  a +  b*Dw02;                   
          [maximum,identifier]               =  max([Delta_solution1 Delta_solution2]);
          switch identifier
             case 1
                  %Delta_solution             =  Delta_solution1;
                  Dw0                        =  Dw01;
             case 2
                  %Delta_solution             =  Delta_solution2;
                  Dw0                        =  Dw02;
          end                            
         end         
         %-----------------------------------------------------------------
         % Predictor according to criterion by Crisfield
         %-----------------------------------------------------------------
    case 'Crisfield'
         Dw01                                =  arc_length_radius/sqrt(b'*b);
         Dw02                                =  -arc_length_radius/sqrt(b'*b);
         []

         External_residual                   =  zeros(str.data.dim*str.n_nodes,1);
         External_residual                   =  [External_residual;str.electric_charge.w];
         External_residual                   =  External_residual(str.freedof);
         Residual1                           =  physics.Residual  - Dw01*External_residual;       
         Residual2                           =  physics.Residual  - Dw02*External_residual;                        
         [maximum,identifier]               =  min([norm(Residual1) norm(Residual2)]);
          switch identifier
             case 1
                  %Delta_solution             =  Delta_solution1;
                  Dw0                        =  Dw01;
             case 2
                  %Delta_solution             =  Delta_solution2;
                  Dw0                        =  Dw02;
          end                            
        end              
         %-----------------------------------------------------------------
         %  Update
         %-----------------------------------------------------------------
          solution.w0                        =  0;
          switch str.arc_length_type
               case 'all_dof'
                  solution.Du                =  zeros(size(freedof,1),1);   
              case 'one_dof'
                  solution.Du                =  0;
          end
%          %solution.Du = 0;
          solution.Dw0                       =  0;
          solution.Dw0_incremental           =  Dw0;
    otherwise
        switch root_criterion
            case 'Feng'
         Delta_solution1                    =  a +  b*Dw01;  
         Delta_solution2                    =  a +  b*Dw02;
         
         %Delta_solution1(str.freedof>3*str.n_nodes) = potential_scaling*Delta_solution1(str.freedof>3*str.n_nodes);
         %Delta_solution2(str.freedof>3*str.n_nodes) = potential_scaling*Delta_solution2(str.freedof>3*str.n_nodes);
         
         
         %sk1_1                             =  [(solution.Du + Delta_solution1(constraint_dof_u))  (solution.Dw0 + Dw01)*Rw0_fixed*scaling];
         %sk1_2                             =  [(solution.Du + Delta_solution2(constraint_dof_u))  (solution.Dw0 + Dw02)*Rw0_fixed*scaling];
         sk1_1                              =  [(solution.Du + Delta_solution1(1:size(solution.Du,1)));  (solution.Dw0 + Dw01)*Rw0_fixed*scaling];
         sk1_2                              =  [(solution.Du + Delta_solution2(1:size(solution.Du,1)));  (solution.Dw0 + Dw02)*Rw0_fixed*scaling];
         cos_theta1                         =  (sk'*sk1_1)/arc_length_radius^2;
         cos_theta2                         =  (sk'*sk1_2)/arc_length_radius^2;
         theta1                             =  abs(acos(cos_theta1));
         theta2                             =  abs(acos(cos_theta2));
         [min_theta,identifier]             =  min([theta1 theta2]); 
         
            case 'mine'
         Delta_solution1                    =  a(constraint_dof_u) +  b(constraint_dof_u)*Dw01;  
         Delta_solution2                    =  a(constraint_dof_u) +  b(constraint_dof_u)*Dw02;
         
         %Delta_solution1(str.freedof>3*str.n_nodes) = potential_scaling*Delta_solution1(str.freedof>3*str.n_nodes);
         %Delta_solution2(str.freedof>3*str.n_nodes) = potential_scaling*Delta_solution2(str.freedof>3*str.n_nodes);
         
         
         %sk1_1                             =  [(solution.Du + Delta_solution1(constraint_dof_u))  (solution.Dw0 + Dw01)*Rw0_fixed*scaling];
         %sk1_2                             =  [(solution.Du + Delta_solution2(constraint_dof_u))  (solution.Dw0 + Dw02)*Rw0_fixed*scaling];
         sk1_1                              =  [(solution.Du(constraint_dof_u) + Delta_solution1);  (solution.Dw0 + Dw01)*Rw0_fixed*scaling];
         sk1_2                              =  [(solution.Du(constraint_dof_u) + Delta_solution2);  (solution.Dw0 + Dw02)*Rw0_fixed*scaling];
         cos_theta1                         =  (sk'*sk1_1)/arc_length_radius^2;
         cos_theta2                         =  (sk'*sk1_2)/arc_length_radius^2;
         theta1                             =  abs(acos(cos_theta1));
         theta2                             =  abs(acos(cos_theta2));
         [min_theta,identifier]             =  min([theta1 theta2]); 
            case 'Crisfield'
                str.arc_length_calculation       =  0;  %  Compute only residuals. If 0, it only computes the residuals.
                aux1_str                                         =  str;
                aux1_str.solu.solution_incremented(str.freedof)  =  -Ru - Rw0*Dw01;
                aux1_str                                         =  updated_incremental_potential(aux1_str);
                aux1_str                                         =  updated_incremental_geometry(aux1_str);
                aux1_str                                         =  reduced_entities(aux1_str);                            %  Compute stiffness matrix and residuals.
                aux1_str.data.acumulated_factor                  =  aux1_str.data.acumulated_factor + Dw01;                
                aux1_str                                         =  Newton_Raphson_force_matrices_update(aux1_str);        %  Updated the external contribution of the residual    
                Residual1                                        =  aux1_str.Residual.Residual(str.freedof,1);             %  Residual (Reduced)
            
                aux2_str                                         =  str;
                aux2_str.solu.solution_incremented(str.freedof)  =  -Ru - Rw0*Dw02;
                aux2_str                                         =  updated_incremental_potential(aux2_str);
                aux2_str                                         =  updated_incremental_geometry(aux2_str);
                aux2_str                                         =  reduced_entities(aux2_str);                            %  Compute stiffness matrix and residuals.
                aux2_str.data.acumulated_factor                  =  aux2_str.data.acumulated_factor + Dw02;                
                aux2_str                                         =  Newton_Raphson_force_matrices_update(aux2_str);        %  Updated the external contribution of the residual    
                Residual2                                        =  aux2_str.Residual.Residual(str.freedof,1);             %  Residual (Reduced)
       
         %External_residual                   =  zeros(str.data.dim*str.n_nodes,1);
         %External_residual                   =  [External_residual;str.electric_charge.w];
         %External_residual                   =  External_residual(str.freedof);
         %Residual1                           =  physics.Residual  - Dw01*External_residual;       
         %Residual2                           =  physics.Residual  - Dw02*External_residual;                        
         [maximum,identifier]                =  min([norm(Residual1) norm(Residual2)]);
%             case 'mine'                
%                  Dw01                                =  arc_length_radius/sqrt(b'*b);
%                  Dw02                                =  -arc_length_radius/sqrt(b'*b);
%                  [solution.Dw0_incremental,identifier]           =  max([Dw01 Dw02]);
                
        end
         switch identifier 
            case 1
                 %Delta_solution             =  Delta_solution1;
                 solution.Dw0_incremental   =  Dw01;
            case 2
                 %Delta_solution             =  Delta_solution2;
                 solution.Dw0_incremental   =  Dw02; 
         end    
         %[max_lambda,identifier]           =  min([sk1_1(constraint_dof_u)   sk1_2(constraint_dof_u)]);
              switch identifier
                   case 1
                        solution.Dw0_incremental   =  Dw01;
                   case 2
                        solution.Dw0_incremental   =  Dw02; 
              end
              
              
        
        
end     

%--------------------------------------------------------------------------
%  Update      
%--------------------------------------------------------------------------
%solution.Du                                =  solution.Du   +  Delta_solution(constraint_dof_u);  %   Only if you include one dof in the arc length
%solution.Du                                 =  solution.Du   +  Delta_solution(1:size(solution.Du,1));
solution.Du                                 =  solution.Du   +  a + b*solution.Dw0_incremental;
solution.DU                                 =  solution.Du;
solution.Dw0                                =  solution.Dw0  +  solution.Dw0_incremental;
solution.w0                                 =  solution.w0   +  solution.Dw0_incremental;


%-----------------------------------------------------------------
%  Update of remaining variables (displacements, potential,
%  pressure... for the remaining nodels)   
%-----------------------------------------------------------------
str.solu.solution_incremented(str.freedof)  =  -Ru - Rw0*solution.Dw0_incremental;
%solution.Dx                                 =  solution.Du(str.freedof<=3*str.n_nodes);
%solution.Dphi                               =  solution.Du(str.freedof>3*str.n_nodes)/potential_scaling;
str                                         =  updated_incremental_potential(str);
str                                         =  updated_incremental_geometry(str);
%a_str                                         =  updated_incremental_potential(str);
%a_str                                         =  updated_incremental_geometry(str);

%str.solu.solution_incremented(str.freedof)  =  -Ru + Rw0*solution.Dw0_incremental;
%solution.Dx                                 =  solution.Du(str.freedof<=3*str.n_nodes);
%solution.Dphi                               =  solution.Du(str.freedof>3*str.n_nodes)/potential_scaling;
%b_str                                         =  updated_incremental_potential(str);
%b_str                                         =  updated_incremental_geometry(str);




%--------------------------------------------------------------------------
%  Update acumulated factor   
%--------------------------------------------------------------------------
%str.data.acumulated_factor                  =  (1 + solution.w0)*solution.w0_fixed/str.electric_charge_w0;
str.data.acumulated_factor                  =  str.data.acumulated_factor + solution.Dw0_incremental;



