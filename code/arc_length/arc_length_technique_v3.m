function [str,incr_load]                       =  arc_length_technique_v3(str,incr_load)


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Dof management
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

if isfield(str,'fixdof_arclength')
   elec_freedof                                =  str.elec_freedof_arclength;
else
   elec_freedof                                =  str.elec_freedof;         % Electric local dofs
   str.fixdof_arclength                        =  str.fixdof;               % Fixed Dof's excluding those associated to dirichlet boundary conditions controlled by the arc length. 
   str.freedof_arclength                       =  str.freedof;              % Dof's including those associated to dirichlet boundary conditions controlled by the arc length. 
   str.freedof_prescribed                      =  [];                       % Dof's associated to dirichlet boundary conditions controlled by the arc length.
   str.mec.freedof_prescribed                  =  [];                       % Local dof's associated to the mechanical part.
   str.elec.freedof_prescribed                 =  [];                       % Local dof's associated to the mechanical part.
   str.elec.freedof_prescribed_value           =  [];
   str.mec.freedof_prescribed_value            =  [];
end  
    
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Initial parameters  
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
str.data.scaling_area =  1.5;
scaling                                        =  0*1/sqrt(str.properties.material_parameters.mu*str.properties.material_parameters.e)/str.data.scaling_area;
str.arc_length_scaling                         =  scaling;
old_str                                        =  str;
radius_convergence                             =  1;

 if isfield(str,'arc_length_solution')
    arc_length_radius                          =  str.arc_length_radius;
 else
    arc_length_radius                          =  0.1;     
 end
   
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Start arc length
%--------------------------------------------------------------------------
%-------------------------------------------------------------------------- 
%str.arc_length_radius                         =  min(arc_length_radius,2.5);
str.arc_length_radius                         =  arc_length_radius;
while radius_convergence
      tolerance                                =  1e-6; 
      warning_convergence                      =  0; 
      %--------------------------------------------------------------------
      % Initialisation of Newton-Raphson algorithm
      %--------------------------------------------------------------------
      str.problem_type_modification            =  0;
      %arc_length_type                         =  'one_dof';
      arc_length_type                          =  'all_dof';
      str.arc_length_type                      =  arc_length_type;
      %--------------------------------------------------------------------
      % Coefficients a, b, c, A, B and C in the arc length
      %--------------------------------------------------------------------
      str.T0_arclength                         =  zeros(size(str.freedof_prescribed ,1),1);                % Force vector associated to dirichlet bc's controlled by the arc length.
 

 
      Newton_Raphson_iteration                 =  1;
      str                                      =  output_arclength_v3(str);
      str                                      =  reduced_entities(str);                            %  Compute stiffness matrix and residuals.

      str                                      =  Newton_Raphson_force_matrices_update(str);        %  Updated the external contribution of the residual
      Residual0                                =  norm(str.Residual.Residual(str.freedof));
      Residual_norm                            =  str.Residual.Residual(str.freedof)/norm(Residual0);
      Residual_Residual                        =  zeros(1,1);
      Residual_Residual(1)                     =  norm(Residual_norm);
      %--------------------------------------------------------------------
      % Coefficients a, b, c, A, B and C in the arc length
      %--------------------------------------------------------------------
      while norm(Residual_norm)>tolerance          
          Newton_Raphson_iteration             =  Newton_Raphson_iteration + 1;
          %----------------------------------------------------------------
          % Start arc length
          %----------------------------------------------------------------
          str                                  =  output_arclength_v3(str);  %  Obtain the outputs of the arck length. Moreover,
                                                                                                                     %  it obtains the new displacements and electric potential
                                                                                                                     %  distribution in the dielectric.
          str                                  =  reduced_entities(str);                            %  Compute stiffness matrix and residuals.
          str                                  =  Newton_Raphson_force_matrices_update(str);        %  Updated the external contribution of the residual
          %----------------------------------------------------------------
          % Residual convergence   
          %----------------------------------------------------------------
          Residual_Residual(Newton_Raphson_iteration,...
              1)                               =  norm(str.Residual.Residual(str.freedof))/Residual0;
          Residual_norm                        =  Residual_Residual(Newton_Raphson_iteration);
          
          %----------------------------------------------------------------
          % screen ouput for current Newton-Raphson iteration.  
          %----------------------------------------------------------------
          fprintf('---------------------------------------------------\n\n')
          fprintf('----------------------------------------------------\n')
          fprintf('current newton-raphson iteration is %d\n',Newton_Raphson_iteration)
          fprintf('the residual is %12.5e\n',Residual_norm);
          fprintf('----------------------------------------------------\n')
          fprintf('--------------------------------------------------\n\n')
          %----------------------------------------------------------------
          %----------------------------------------------------------------
          % Convergence criteria
          %----------------------------------------------------------------
          %----------------------------------------------------------------
          if Newton_Raphson_iteration>6
              break;
          end
          %if abs(solution.Dw0_incremental)<1e-8
          %    warning_convergence              =  0;
          %    radius_convergence           =  0;
          %end
          if Newton_Raphson_iteration>=6
              if norm(Residual_norm)<tolerance
                  warning_convergence          =  0;
                  radius_convergence           =  0;
              else
                  warning_convergence          =  1;
              end
          end
          if warning_convergence
              arc_length_radius                =  arc_length_radius/2;
              str.arc_length_radius            =  arc_length_radius;
              old_str.arc_length_radius        =  arc_length_radius;
              break;
          end
          
      end      
      if Newton_Raphson_iteration <=6
          if norm(Residual_norm)<tolerance
              radius_convergence               =  0;
          end
      end
      
      if Newton_Raphson_iteration <=2
          if norm(Residual_norm)<tolerance
              arc_length_radius                =  arc_length_radius*2;
              str.arc_length_radius            =  arc_length_radius;
              radius_convergence               =  0;
          end
      end
      if radius_convergence==0
          %----------------------------------------------------------------
          % Printing orders for the converged case.
          %----------------------------------------------------------------
          fprintf('\n\n\n----------------------------------------------\n')
          fprintf('----------------------------------------------------\n')
          fprintf('----------------------------------------------------\n')
          fprintf('----------------------------------------------------\n')
          fprintf('summary of results for the current load increment:\n')
          fprintf('total number of newton-raphson iteration: %d\n',Newton_Raphson_iteration)
          fprintf('the total acumulated load factor is %f\n',str.data.acumulated_factor)
          fprintf('----------------------------------------------------\n')
          fprintf('----------------------------------------------------\n')
          fprintf('----------------------------------------------------\n')
          fprintf('------------------------------------------------\n\n\n')
          %----------------------------------------------------------------
          % Postprocessing for static case and saving results.
          %----------------------------------------------------------------
          incr_load                            =  incr_load + 1;
          str.temp.incr_load                   =  incr_load;
          str.time                             =  incr_load;
          str  =  saving_to_memory(str,str.time,incr_load,str.time);
      end
      
      if radius_convergence==1
          str                                  =  old_str;
      end
end

%TECPLOT_plotting(str);
