function [str,incr_load]                       =  arc_length_technique_v4(str,incr_load)


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Dof management
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
 
if isfield(str,'fixdof_arclength')
   elec_freedof                                =  str.elec_freedof_arclength;
   if isfield(str,'mec_freedof_arclength')
         mec_freedof                                 =  str.mec_freedof_arclength;         % Electric local dofs
   else
         mec_freedof                                 =  str.mec_freedof;         % Electric local dofs
   end
       
else  
   elec_freedof                                =  str.elec_freedof;         % Electric local dofs
   mec_freedof                                 =  str.mec_freedof;         % Electric local dofs
   str.fixdof_arclength                        =  str.fixdof;               % Fixed Dof's excluding those associated to dirichlet boundary conditions controlled by the arc length. 
   str.freedof_arclength                       =  str.freedof;              % Dof's including those associated to dirichlet boundary conditions controlled by the arc length. 
   str.freedof_prescribed                      =  [];                       % Dof's associated to dirichlet boundary conditions controlled by the arc length.
   str.mec.freedof_prescribed                  =  [];                       % Local dof's associated to the mechanical part.
   str.elec.freedof_prescribed                 =  [];                       % Local dof's associated to the mechanical part.
   str.elec.freedof_prescribed_value           =  [];
   str.mec.freedof_prescribed_value            =  [];   
end  
    
Residual_External_action                       =  str.Residual.External_action;
switch str.data.formulation.mixed_type
    case {'u_p_phi_incompressible','full_mixed_formulation_electroelasticity_F_D0_V_incompressible'}
        mec_freedof                            =  [mec_freedof; (1:size(str.nodes_p,1))' + 3*str.n_nodes];
        Residual_External_action               =  [Residual_External_action; zeros(size(str.nodes_p,1),1)];
    case 'u_phi_D0_c_formulation'
        mec_freedof                            =  [mec_freedof; (1:3*size(str.nodes_E0,1))' + 3*str.n_nodes];
        Residual_External_action               =  [Residual_External_action; zeros(3*size(str.nodes_E0,1),1)];
    case 'full_mixed_formulation_electroelasticity_F_D0_V_c'
        n_nodes                                =  3*size(str.nodes_E0,1) + 2*9*size(str.nodes_F,1) + 2*9*size(str.nodes_H,1) + 2*size(str.nodes_J,1) + 2*3*size(str.nodes_V,1);
        mec_freedof                            =  [mec_freedof;  + (1:n_nodes)' + 3*str.n_nodes];
        Residual_External_action               =  [Residual_External_action; zeros(n_nodes,1)];
end

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Initial parameters  
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
str.data.scaling_area =  1.5;
scaling                                        =  0*1/sqrt(str.properties.material_parameters.mu(1)*str.properties.material_parameters.e(1))/str.data.scaling_area;
str.arc_length_scaling                         =  scaling;
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
      % Initialisation of variables    
      %--------------------------------------------------------------------
      switch arc_length_type
          case 'all_dof'
              solution.Du                      =  zeros(size(str.freedof_arclength,1),1);
          otherwise
              solution.Du                      =  0;
      end
      solution.Dw0                             =  0;
      solution.Dw0_incremental                 =  0;
      solution.w0_fixed                        =  str.data.acumulated_factor*str.electric_charge_w0;
      %--------------------------------------------------------------------
      % Coefficients a, b, c, A, B and C in the arc length
      %--------------------------------------------------------------------
      physics.K_matrix                         =  str.assemb_matrix.total_matrix(str.freedof_arclength,str.freedof_arclength);
      %physics.Residual                        =  str.Residual.Residual(str.freedof_arclength,1);
      physics.Residual                         =  str.Residual.Residual;
      %str.T0_arclength                        =  zeros(size(str.freedof_prescribed ,1),1);                % Force vector associated to dirichlet bc's controlled by the arc length.
      str.T0_arclength                         =  -str.Residual.Residual(str.freedof_prescribed);                % Force vector associated to dirichlet bc's controlled by the arc length.
      solution.w0_fixed                        =  str.electric_charge_w0*str.data.acumulated_factor;       % Current applied surface charge.
      w0_fixed_residual                        =  str.electric_charge.w(elec_freedof);
      p0_fixed_residual                        =  Residual_External_action(mec_freedof)/str.data.acumulated_factor;
      Rw0_fixed                                =  sum(w0_fixed_residual);                                  % Du^2 + scailing^2*Rw0_fixed^2*Dw0^2 = s^2  (I consider the total surface charge in the surface)
      total_u_fixed                            =  str.cons_val;                                            %  Fixed value for Dirichlet boundary conditions.
   
   
      solution.Du_old                          =  solution.Du;
      if isfield(str,'arc_length_solution')
          if strcmp(arc_length_type,old_str.arc_length_type)
              solution.Du_old                  =  str.arc_length_solution.Du;
          end
      end  
  
      Newton_Raphson_iteration                 =  1;
      %str.newton_raphson_iteration             =  Newton_Raphson_iteration;
      str.arc_length.theta                     =  0;   %  Rotation angle in rotational Dirichlet boundary conditions.
      str.previous_Eulerian_x                       =  str.Eulerian_x;  % Previous Eulerian configuration for the case of rotational Dirichlet boundary conditions.
      [solution,str]                           =  output_arclength_v4(physics,solution,str.arc_length.constraint_dof_u,Rw0_fixed,w0_fixed_residual,p0_fixed_residual,[0 0],total_u_fixed,str,0);
      str.solution_arc_length                  =  solution;
      
      str.arc_length_calculation               =  1;  %  Compute stiffness matrices and residuals. If 0, it only computes the residuals.
       
      str.Residual.External_action             =  str.Residual.External_action*0;
      str                                      =  reduced_entities(str);                            %  Compute stiffness matrix and residuals.
      str                                      =  Newton_Raphson_force_matrices_update(str);        %  Updated the external contribution of the residual
      p0_fixed_residual                        =  Residual_External_action(mec_freedof)/str.data.acumulated_factor;
      physics.K_matrix                         =  str.assemb_matrix.total_matrix(str.freedof_arclength,str.freedof_arclength);
      physics.Residual                         =  str.Residual.Residual;
      %physics.Residual                        =  str.Residual.Residual(str.freedof_arclength,1);
      Residual0                                =  norm(str.Residual.Residual(str.freedof));
      Residual_norm                            =  str.Residual.Residual(str.freedof)/norm(Residual0);
      Residual_Residual                        =  zeros(1,1);
      Residual_Residual(1)                     =  norm(Residual_norm);
      %--------------------------------------------------------------------
      % Coefficients a, b, c, A, B and C in the arc length  
      %--------------------------------------------------------------------
      while norm(Residual_norm)>tolerance          
          Newton_Raphson_iteration             =  Newton_Raphson_iteration + 1;
          %str.newton_raphson_iteration         =  Newton_Raphson_iteration;
          sk                                   =  [solution.Du;  solution.Dw0*Rw0_fixed*scaling];
          %----------------------------------------------------------------
          % Start arc length 
          %----------------------------------------------------------------
          [solution,str]                       =  output_arclength_v4(physics,solution,str.arc_length.constraint_dof_u,Rw0_fixed,...
                                                  w0_fixed_residual,p0_fixed_residual,sk,total_u_fixed,str,Newton_Raphson_iteration);  %  Obtain the outputs of the arck length. Moreover,
                                                                                                                     %  it obtains the new displacements and electric potential
                                                                                                                     %  distribution in the dielectric.
          str.solution_arc_length              =  solution;
          str.arc_length_solution              =  solution;
          
          str.arc_length_calculation           =  1;                                                %  Compute stiffness matrices and residuals. If 0, it only computes the residuals.
          str.Residual.External_action         =  str.Residual.External_action*0;
          str                                  =  reduced_entities(str);                            %  Compute stiffness matrix and residuals.
          str                                  =  Newton_Raphson_force_matrices_update(str);        %  Updated the external contribution of the residual
          p0_fixed_residual                    =  Residual_External_action(mec_freedof)/str.data.acumulated_factor;
          physics.K_matrix                     =  str.assemb_matrix.total_matrix(str.freedof_arclength,str.freedof_arclength);
          physics.Residual                     =  str.Residual.Residual;
          %physics.Residual                    =  str.Residual.Residual(str.freedof_arclength,1);
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
