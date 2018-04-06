function [str,incr_load]                              =  arc_length_technique(str,incr_load)

str.data.scaling_area =  1.5;
scaling                                   =  0*1/sqrt(str.properties.material_parameters.mu*str.properties.material_parameters.e)/str.data.scaling_area;
str.arc_length_scaling                    =  scaling;



 old_str                                   =  str;
radius_convergence                        =  1;

 if isfield(str,'arc_length_solution')
    arc_length_radius                           =  str.arc_length_radius;
 else
    arc_length_radius                           =  5;     
 end
 
   
 
 str.arc_length_radius                       =  arc_length_radius;
while radius_convergence
tolerance                                =  1e-6; 
warning_convergence                      =  0;
%--------------------------------------------------------------------------
% Initialisation of Newton-Raphson algorithm    
%--------------------------------------------------------------------------
str.problem_type_modification             =  0;
%arc_length_type                           =  'one_dof';
arc_length_type                           =  'all_dof';
str.arc_length_type                       =  arc_length_type;
%--------------------------------------------------------------------------
% Initialisation of variables 
%--------------------------------------------------------------------------
switch arc_length_type
    case 'all_dof' 
         solution.Du                      =  zeros(size(str.freedof,1),1);
    otherwise
         solution.Du                      =  0;
end
solution.Dw0                              =  0;
solution.Dw0_incremental                  =  0;
solution.w0_fixed                         =  str.data.acumulated_factor*str.electric_charge_w0;
%--------------------------------------------------------------------------
% Coefficients a, b, c, A, B and C in the arc length  
%--------------------------------------------------------------------------
physics.K_matrix                          =  str.assemb_matrix.reduced_matrix; 
physics.Residual                          =  str.Residual.Residual(str.freedof,1);
%physics.K_matrix                          =  str.assemb_matrix.total_matrix; 
%physics.Residual                          =  str.Residual.Residual(str.freedof,1);
physics.K_free_fixed                      =  str.assemb_matrix.total_matrix(str.freedof,str.fixdof);
solution.w0_fixed                         =  str.electric_charge_w0*str.data.acumulated_factor;       % Current applied surface charge.
%solution.w0                              =  solution.w0_fixed;
%w0_fixed_residual                         =  str.electric_charge.w*str.data.acumulated_factor;        % External residual for the current applied surface charge.
%w0_fixed_residual                         =  str.electric_charge.w;
w0_fixed_residual                         =  str.electric_charge.w(str.elec_freedof);
Rw0_fixed                                 =  sum(w0_fixed_residual);                                  % Du^2 + scailing^2*Rw0_fixed^2*Dw0^2 = s^2  (I consider the total surface charge in the surface)
total_u_fixed                             =  str.cons_val;                                            %  Fixed value for Dirichlet boundary conditions.
 

solution.Du_old                           =  solution.Du;
 if isfield(str,'arc_length_solution')
    if strcmp(arc_length_type,old_str.arc_length_type)
           solution.Du_old                =  str.arc_length_solution.Du;
    end
 end   
 
%    solution.DU                            =  str.arc_length_solution.DU;
%    solution.Dw0                           =  str.arc_length_solution.Dw0;
%    solution.w0                            =  str.arc_length_solution.w0;
%    str.data.acumulated_factor             =  (1 + solution.w0)*solution.w0_fixed/str.electric_charge_w0;
% 
%    
%    str                                    =  reduced_entities(str);                            %  Compute stiffness matrix and residuals.
%    str                                    =  Newton_Raphson_force_matrices_update(str);        %  Updated the external contribution of the residual
%    physics.K_matrix                       =  str.assemb_matrix.reduced_matrix;                 %  Stiffness matrix (Reduced)
%    physics.Residual                       =  str.Residual.Residual(str.freedof,1);             %  Residual (Reduced)
%    Residual0                              =  norm(str.Residual.Residual(str.freedof));
%    Residual_norm                          =  str.Residual.Residual(str.freedof)/norm(Residual0);
%    Residual_Residual                      =  zeros(1,1);
%    Residual_Residual(1)                   =  norm(Residual_norm);
%    Newton_Raphson_iteration               =  1;
%     
%       
% else        
   
% if isfield(str,'solution_arc_length')
%    solution.Du                            =  str.solution_arc_length.Du;
%    solution.Dw0                           =  0;
%    solution.w0                            =  0;
%    
%    str.solu.solution_incremented(str.freedof,...  
%        1)                                 =  [str.solution_arc_length.Dx;str.solution_arc_length.Dphi];
%    str                                    =  updated_incremental_potential(str);
%    str                                    =  updated_incremental_geometry(str);   
%  else
   
   [solution,str]                         =  output_arclength(physics,solution,str.arc_length.constraint_dof_u,Rw0_fixed,w0_fixed_residual,[0 0],total_u_fixed,str,0);
   str.solution_arc_length                =  solution;
% end  
   
   str.arc_length_calculation             =  1;  %  Compute stiffness matrices and residuals. If 0, it only computes the residuals.
   %old_old_str                            =  str;
   str                                    =  updated_constrained_potential(str);
   %str                                    =  Newton_Raphson_updated_initial_residual(str,old_old_str);
   
   str                                    =  reduced_entities(str);                            %  Compute stiffness matrix and residuals.
   str                                    =  Newton_Raphson_force_matrices_update(str);        %  Updated the external contribution of the residual
   physics.K_matrix                       =  str.assemb_matrix.total_matrix; 
   physics.Residual                       =  str.Residual.Residual(str.freedof,1);
   physics.K_matrix                      =  str.assemb_matrix.reduced_matrix;                 %  Stiffness matrix (Reduced)
   physics.Residual                      =  str.Residual.Residual(str.freedof,1);             %  Residual (Reduced)
   physics.K_free_fixed                   =  str.assemb_matrix.total_matrix(str.freedof,str.fixdof); % Stiffness matrix for Dirichlet boundary conditions
   Residual0                              =  norm(str.Residual.Residual(str.freedof));
   Residual_norm                          =  str.Residual.Residual(str.freedof)/norm(Residual0);
   Residual_Residual                      =  zeros(1,1);
   Residual_Residual(1)                   =  norm(Residual_norm);
   Newton_Raphson_iteration               =  1;
   
   
    
   
   
% end
%str.arc_length_solution                   =  solution;
%----------------------------------------------------------------------
% Coefficients a, b, c, A, B and C in the arc length           
%----------------------------------------------------------------------
while norm(Residual_norm)>tolerance
    Newton_Raphson_iteration              =  Newton_Raphson_iteration + 1;
    %sk                                   =  [solution.DU(str.arc_length.constraint_dof_u);  solution.Dw0*Rw0_fixed*scaling];
    sk                                    =  [solution.Du;  solution.Dw0*Rw0_fixed*scaling];
    %----------------------------------------------------------------------
    % Start arc length                             
    %----------------------------------------------------------------------    
    [solution,str]                        =  output_arclength(physics,solution,str.arc_length.constraint_dof_u,Rw0_fixed,...
                                                              w0_fixed_residual,sk,total_u_fixed,str,Newton_Raphson_iteration);  %  Obtain the outputs of the arck length. Moreover, 
                                                                                                            %  it obtains the new displacements and electric potential 
                                                                                                           %  distribution in the dielectric.
    str.solution_arc_length               =  solution;
    str.arc_length_solution               =  solution;                                                                                                           
     
    str.arc_length_calculation            =  1;                                                %  Compute stiffness matrices and residuals. If 0, it only computes the residuals.
    str                                   =  updated_constrained_potential(str);
    str                                   =  reduced_entities(str);                            %  Compute stiffness matrix and residuals.
    str                                   =  Newton_Raphson_force_matrices_update(str);        %  Updated the external contribution of the residual    
    physics.K_matrix                      =  str.assemb_matrix.reduced_matrix;                 %  Stiffness matrix (Reduced)  
    physics.Residual                      =  str.Residual.Residual(str.freedof,1);             %  Residual (Reduced)
    %----------------------------------------------------------------------
    % Residual convergence        
    %----------------------------------------------------------------------
    Residual_Residual(Newton_Raphson_iteration,...
        1)                                =  norm(str.Residual.Residual(str.freedof))/Residual0;
    Residual_norm                         =  Residual_Residual(Newton_Raphson_iteration);
    
    %----------------------------------------------------------------------
    % screen ouput for current Newton-Raphson iteration.  
    %----------------------------------------------------------------------
    fprintf('--------------------------------------------------------------------\n\n')
    fprintf('--------------------------------------------------------------------\n')
    fprintf('current newton-raphson iteration is %d\n',Newton_Raphson_iteration)
    fprintf('the residual is %12.5e\n',Residual_norm);
    fprintf('--------------------------------------------------------------------\n')
    fprintf('--------------------------------------------------------------------\n\n')
    if Newton_Raphson_iteration>6
        break; 
    end 
    if abs(solution.Dw0_incremental)<1e-8
          warning_convergence                         =  0;
          radius_convergence                          =  0;
        break;
    end
    %if Residual_norm>1e3;
    %  warning_convergence                         =  1;          
    %end
   if Newton_Raphson_iteration>=6
      if norm(Residual_norm)<tolerance
          warning_convergence                         =  0;
          radius_convergence                          =  0;
       else 
          warning_convergence                         =  1;          
       end
    end
    if warning_convergence
        arc_length_radius                           =  arc_length_radius/2;
        str.arc_length_radius                   =  arc_length_radius;
        old_str.arc_length_radius                   =  arc_length_radius;        
        break;
    end
    
end

if Newton_Raphson_iteration <=6
      if norm(Residual_norm)<tolerance
    radius_convergence               =  0;
      end
end

if Newton_Raphson_iteration <=4
      if norm(Residual_norm)<tolerance
          arc_length_radius         =  arc_length_radius*2;
       str.arc_length_radius        =  arc_length_radius;
       radius_convergence               =  0;
      end
      if abs(solution.Dw0_incremental)<1e-8
          arc_length_radius         =  arc_length_radius*2;
       str.arc_length_radius        =  arc_length_radius;
       radius_convergence               =  0;
      end
end

if radius_convergence==0
%--------------------------------------------------------------------------
% Printing orders for the converged case.
%--------------------------------------------------------------------------
fprintf('\n\n\n--------------------------------------------------------------------\n')
fprintf('--------------------------------------------------------------------\n')
fprintf('--------------------------------------------------------------------\n')
fprintf('--------------------------------------------------------------------\n')
fprintf('summary of results for the current load increment:\n')
fprintf('total number of newton-raphson iteration: %d\n',Newton_Raphson_iteration)
fprintf('the total acumulated load factor is %f\n',str.data.acumulated_factor)
fprintf('--------------------------------------------------------------------\n')
fprintf('--------------------------------------------------------------------\n')
fprintf('--------------------------------------------------------------------\n')
fprintf('--------------------------------------------------------------------\n\n\n')

 
             
%--------------------------------------------------------------
% Postprocessing for static case and saving results.
%--------------------------------------------------------------
incr_load                                   =  incr_load + 1;
jobfolder                                   =  (([str.jobfolder '\results']));
cd(jobfolder);
filename                                    =  ['Load_increment_' num2str(incr_load)];
str.time                                    =  incr_load;
save(filename);
end


if radius_convergence==1
   str                                      =  old_str;
end
end

TECPLOT_plotting(str);
%plot(log10(str.Residual.Residual_stored(incr_load,1:newton_raphson_iteration)),'b-o')
%figure(2)
%plot(log10(1:newton_raphson_iteration),log10(str.Residual.Residual_stored(incr_load,1:newton_raphson_iteration)),'b-o')
%format long e
%--------------------------------------------------------------
%--------------------------------------------------------------
% Postprocessing of vacuum
%--------------------------------------------------------------
%--------------------------------------------------------------
%general_postprocessor_vacuum_BEM(str);
