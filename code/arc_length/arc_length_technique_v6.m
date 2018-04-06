function [str,incr_load]                       =  arc_length_technique_v6(str,incr_load)


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Dof management
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
 
if isfield(str,'fixdof_arclength')
else  
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
old_str                                        =  str;
radius_convergence                             =  1;

 if isfield(str,'arc_length_solution')
    arc_length_radius                          =  str.arc_length_radius;
 else
    arc_length_radius                          =  5;     
 end
   
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Start arc length 
%--------------------------------------------------------------------------
%-------------------------------------------------------------------------- 
str.arc_length_radius                         =  arc_length_radius;
while radius_convergence
      tolerance                                =  1e-6; 
      warning_convergence                      =  0;
      %--------------------------------------------------------------------
      % Initialisation of variables    
      %--------------------------------------------------------------------
      solution.Du                              =  zeros(size(str.freedof_arclength,1),1);
      solution.Dw0                             =  0;
      solution.Dw0_incremental                 =  0;
      solution.w0_fixed                        =  str.data.acumulated_factor*str.electric_charge_w0;
      %--------------------------------------------------------------------
      % Coefficients a, b, c, A, B and C in the arc length 
      %--------------------------------------------------------------------
      physics.K_matrix                         =  str.assemb_matrix.total_matrix(str.freedof_arclength,str.freedof_arclength);
      physics.Residual                         =  str.Residual.Residual;
      %str.T0_arclength                        =  zeros(size(str.freedof_prescribed ,1),1);                % Force vector associated to dirichlet bc's controlled by the arc length.
      str.T0_arclength                         =  -str.Residual.Residual(str.freedof_prescribed);                % Force vector associated to dirichlet bc's controlled by the arc length.
      solution.w0_fixed                        =  str.electric_charge_w0*str.data.acumulated_factor;       % Current applied surface charge.
      total_u_fixed                            =  str.cons_val;                                            %  Fixed value for Dirichlet boundary conditions.
   
    
      solution.Du_old                          =  solution.Du; 
      if isfield(str,'arc_length_solution')
         solution.Du_old                  =  str.arc_length_solution.Du;
      end   
  
      Newton_Raphson_iteration                 =  1;
      [solution,str]                           =  output_arclength_v6(physics,solution,str.arc_length.constraint_dof_u,[0 0],total_u_fixed,str,0);
      str.solution_arc_length                  =  solution;
      
      str                                      =  reduced_entities(str);                            %  Compute stiffness matrix and residuals.
      str                                      =  Newton_Raphson_force_matrices_update(str);        %  Updated the external contribution of the residual
      physics.K_matrix                         =  str.assemb_matrix.total_matrix(str.freedof_arclength,str.freedof_arclength);
      physics.Residual                         =  str.Residual.Residual;
      Residual0                                =  norm(str.Residual.Residual(str.freedof));
      Residual_norm                            =  str.Residual.Residual(str.freedof)/norm(Residual0);
      Residual_Residual                        =  zeros(1,1);
      Residual_Residual(1)                     =  norm(Residual_norm);
      %--------------------------------------------------------------------
      % Coefficients a, b, c, A, B and C in the arc length   
      %--------------------------------------------------------------------
      while norm(Residual_norm)>tolerance          
          Newton_Raphson_iteration             =  Newton_Raphson_iteration + 1;
          sk                                   =  solution.Du;
          %----------------------------------------------------------------
          % Start arc length  
          %----------------------------------------------------------------
          [solution,str]                       =  output_arclength_v6(physics,solution,str.arc_length.constraint_dof_u,...
                                                  sk,total_u_fixed,str,Newton_Raphson_iteration);  %  Obtain the outputs of the arck length. Moreover,
                                                                                                                     %  it obtains the new displacements and electric potential
                                                                                                                     %  distribution in the dielectric.
          str.solution_arc_length              =  solution;
          str.arc_length_solution              =  solution;
          
          str                                  =  reduced_entities(str);                            %  Compute stiffness matrix and residuals.
          str                                  =  Newton_Raphson_force_matrices_update(str);        %  Updated the external contribution of the residual
          physics.K_matrix                     =  str.assemb_matrix.total_matrix(str.freedof_arclength,str.freedof_arclength);
          physics.Residual                     =  str.Residual.Residual;
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
        
      if Newton_Raphson_iteration <=4
          if norm(Residual_norm)<tolerance
              arc_length_radius                =  arc_length_radius*2;
              str.arc_length_radius            =  arc_length_radius;
              radius_convergence               =  0;
          end
          %if abs(solution.Dw0_incremental)<1e-8
          %    arc_length_radius                =  arc_length_radius*2;
          %    str.arc_length_radius            =  arc_length_radius;
          %    radius_convergence               =  0;
          %end
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
          jobfolder                            =  (([str.jobfolder '\results']));
          cd(jobfolder);
          %filename                             =  ['Load_increment_' num2str(incr_load)];
          str.time                             =  incr_load;
          %save(filename);
          str.temp.incr_load                            =  incr_load;
          str  =  saving_to_memory(str,str.data.acumulated_factor,incr_load,1);
          
          
      end
      
      if radius_convergence==1
          str                                  =  old_str;
      end
end

%TECPLOT_plotting(str);
