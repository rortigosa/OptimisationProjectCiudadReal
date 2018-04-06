function [str]                                      =  arclength_corrector(str)

%--------------------------------------------------------------------------
% Initialisation.
%--------------------------------------------------------------------------

if 0
Dxk                                                 =  str.arc_length.Dxk;
% str.arc_length.lambda                               =  str.arc_length.lambda+str.arc_length.Dlambda; % new version
%lambda_0                                           =  str.arc_length.lambda;
end

switch str.data.problem
    case 'electromechanical'
      str.arc_length.u                              =  zeros((str.data.dim + 1)*str.n_nodes,1);
      Dxk                                           =  zeros((str.data.dim + 1)*str.n_nodes,1);
    case 'mechanical'
      str.arc_length.u                              =  zeros(str.data.dim*str.n_nodes,1);
      Dxk                                           =  zeros(str.data.dim*str.n_nodes,1);      
    case 'electric'
      str.arc_length.u                              =  zeros(str.n_nodes,1);
      Dxk                                           =  zeros(str.n_nodes,1);      
end
str.arc_length.n_iterations                         =  0;
str.arc_length.dlambda                              =  str.arc_length.Dlambda;
normR                                               =  1e8;
str.calculation_option                              =  'matrices';
[str]                                               =  reduced_entities(str);
str.assemb_matrix.old_reduced_matrix                =  str.assemb_matrix.reduced_matrix;
str.arc_length.lambda                               =  str.arc_length.lambda + str.arc_length.dlambda;
%--------------------------------------------------------------------------
% Alternative way.
%--------------------------------------------------------------------------

switch str.data.problem 
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    % Electromechanical case
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    case 'electromechanical'
      iteration                                           =  0;
      %--------------------------------------------------------------------------
      % Corrector step.
      %--------------------------------------------------------------------------
      while normR>str.data.tolerance 
          iteration                                       =  iteration + 1;
          %----------------------------------------------------------------------
          % Computing updated residual.
          %----------------------------------------------------------------------               
%          [str]                                           =  reduced_entities(str);
          Ext_force_vector                                =  zeros(length(str.freedof),1);
          Ext_force_vector(1:length(str.mec_freedof),1)   =  str.nodal_loads.P(str.mec_freedof);
          %----------------------------------------------------------------------
          % Auxiliar displacements.
          %----------------------------------------------------------------------
          old_phi                                         =  str.phi;
          old_Eulerian_x                                  =  str.Eulerian_x;
          old_dlambda                                     =  str.arc_length.dlambda;
          
          %----------------------
          % ut
          %----------------------
%           str.arc_length.dlambda                          =  1;
%           [str]                                           =  updated_constrained_geometry(str);
%           [str]                                           =  updated_constrained_potential(str);
%           str.calculation_option                          =  'fvectors';          
%           [str]                                           =  reduced_entities(str);
%           Internal                                        =  str.assemb_force.reduced_force;
%           ut                                              =  -str.assemb_matrix.old_reduced_matrix\(Internal - Ext_force_vector);

          Internal                                        =  zeros((str.data.dim + 1)*str.n_nodes,1);
          Internal(str.fixdof,1)                          =  str.cons_val;   % Total value of the Dirichlet boundary conditions.
          ut                                              =  str.assemb_matrix.old_reduced_matrix\(Ext_force_vector);
          Internal_force                                  =  str.assemb_matrix.Dirichlet*Internal;
          ut                                              =  ut - str.assemb_matrix.old_reduced_matrix\Internal_force;
          
          %---------------------- 
          % uhat
          %----------------------
          str.phi                                         =  old_phi;
          str.Eulerian_x                                  =  old_Eulerian_x;
          str.arc_length.dlambda                          =  old_dlambda;
          [str]                                           =  updated_constrained_geometry(str);
          [str]                                           =  updated_constrained_potential(str);
          str.calculation_option                          =  'fvectors';
          [str]                                           =  reduced_entities(str);
          Residual                                        =  str.assemb_force.reduced_force - str.arc_length.lambda*Ext_force_vector;
          uhat                                            =  -str.assemb_matrix.old_reduced_matrix\Residual;
          
          %--------------------------------------------------------------------------
          %  Obtained dot product of up'*up +phip'*phip. up is the total prescribed displacement
          %  and phip is the total prescribed potential.
          %--------------------------------------------------------------------------
          str.arc_length.U_prsc_dp                        =  0;
          for iloop1=1:str.data.dim
              str.arc_length.U_prsc_dp                    =  str.arc_length.U_prsc_dp + str.fixed_displacement(iloop1,:)*str.fixed_displacement(iloop1,:)';
          end
          str.arc_length.U_prsc_dp                        =  str.arc_length.U_prsc_dp  + str.elec_cons_val'*str.elec_cons_val;
          %----------------------------------------------------------------------
          % Quadratic equation.
          %----------------------------------------------------------------------
          [a,b,c,root]                                    =  quadratic_function(ut,uhat,Dxk,str);
          check                                           =  (b^2-4*a*c)/b^2;
          if check<0 && check>1e-4
              root                                         =  0;
          end 
          %----------------------------------------------------------------------
          % Checking for sign of the factor inside the root of the quadratic equation.
          %----------------------------------------------------------------------
          if root<0
              str.arc_length.tolerance_warning            =  'exceeded';
              fprintf('\nThe root of the quadratic root is negative. The value of the radius will be decreased\n')
              break;
          else
              str.arc_length.tolerance_warning            =  'satisfied';
          end
          %----------------------------------------------------------------------
          % Number of iterations.
          %----------------------------------------------------------------------
          str.arc_length.n_iterations                     =  str.arc_length.n_iterations + 1;
          %----------------------------------------------------------------------
          % Solving the quadratic equation in order to get dlambda and Dx1.
          %----------------------------------------------------------------------
          [Dxk1,maxangle,str]                             =  solution_quadratic_function(a,b,root,Dxk,uhat,ut,str);
          %----------------------------------------------------------------------
          % Updating variables. 
          %----------------------------------------------------------------------
          str.arc_length.Dlambda                          =  str.arc_length.Dlambda + str.arc_length.dlambda;
          str.arc_length.lambda                           =  str.arc_length.lambda + str.arc_length.dlambda;
          %----------------------------------------------------------------------
          % Calculate reduced stiffness matrix and internal force vector.
          %----------------------------------------------------------------------
          %   [str]                                           =  reduced_matrix(str);
          %   [str]                                           =  reduced_total_vector(str);
          %----------------------------------------------------------------------
          % Updated geometry.
          %----------------------------------------------------------------------
          last1                                           =  str.data.dim*str.n_nodes;
          str.arc_length.net_displacement(1:last1,1)      =  Dxk1(1:last1,1) - Dxk(1:last1,1);
          [str]                                           =  updated_geometry(str);        
          %----------------------------------------------------------------------
          % Updated potential.
          %----------------------------------------------------------------------
          last2                                           =  last1  + str.n_nodes;
          str.arc_length.net_displacement(last1+1:last2,1)=  Dxk1(last1 + 1:last2,1) - Dxk(last1 + 1:last2,1);
          [str]                                           =  updated_potential(str);
          %----------------------------------------------------------------------
          % New Residual.
          %----------------------------------------------------------------------
          str.calculation_option                          =  'matrices';
          [str]                                           =  reduced_entities(str);
          str.calculation_option                          =  'fvectors';
          [str]                                           =  reduced_entities(str);
          str.assemb_matrix.old_reduced_matrix            =  str.assemb_matrix.reduced_matrix;
          str.assemb_matrix.reduced_matrix                =  str.assemb_matrix.old_reduced_matrix;
          str.Residual.Residual(str.freedof)              =  (str.assemb_force.reduced_force ...
                                                              - str.arc_length.lambda*Ext_force_vector);
          nondResidual(iteration,1)                       =  norm(str.Residual.Residual(str.freedof));            
          normR                                           =  nondResidual(iteration,1)/nondResidual(1,1);
%         normR                                           =  norm(str.Residual.Residual(str.freedof));
          fprintf('The residual is %12.5e\n',normR);           
%           %----------------------------------------------------------------------
%           % Computing residual
%           %----------------------------------------------------------------------
%           str.assemb_matrix.old_reduced_matrix            =  str.assemb_matrix.reduced_matrix;
%           [str]                                           =  reduced_entities(str);
%           str.assemb_matrix.reduced_matrix                =  str.assemb_matrix.old_reduced_matrix;
          %----------------------------------------------------------------------
          % Displacements in iteration k
          %----------------------------------------------------------------------
          Dxk                                             =  Dxk1;
          %----------------------------------------------------------------------
          % Last internal forces of the carrent .
          %----------------------------------------------------------------------
          str.arc_length.Fint0                           =  str.assemb_force.reduced_force;         
%           %----------------------------------------------------------------------
%           % Checking the constraint.
%           %----------------------------------------------------------------------
%           str.presc                                       =  zeros(str.n_nodes*(str.data.dim+1),1);
%           index                                           =  (str.n_nodes-1)*str.data.dim;
%           for iloop1=1:str.data.dim
%               str.presc(iloop1:str.data.dim:index+...
%                                              iloop1,1)   =  str.fixed_displacement(iloop1,:);
%           end
% 
%           ini                                             =  str.n_nodes*str.data.dim;
%           last                                            =  str.n_nodes*(str.data.dim+1);
%           str.prescr_elec                                 =  zeros(str.n_nodes,1);
%           str.prescr_elec(str.elec_fixdof)                =  str.elec_cons_val;
%           str.presc(ini+1:last,1)                         =  str.prescr_elec;
%           
%           restriction                                     =  (Dxk1'*Dxk1 + str.arc_length.Dlambda^2*(str.nodal_loads.P'*str.nodal_loads.P + str.presc'*str.presc));
%           restriction                                     =  sqrt(restriction);
%           str.arc_length.restriction_check                = (str.arc_length.radius-restriction)/str.arc_length.radius;
          %----------------------------------------------------------------------
          % Checking convergence.
          %----------------------------------------------------------------------
          if str.arc_length.n_iterations>str.arc_length.desired_n_iterations
              str.arc_length.tolerance_warning             =  'exceeded';
              fprintf('\nThe maximum number of iterations of the corrector step has been %s\n',str.arc_length.tolerance_warning);
              break;
          else
              str.arc_length.tolerance_warning             =  'satisfied';
              fprintf('\nThe maximum number of iterations criterion of the corrector step is %s\n',str.arc_length.tolerance_warning);
          end
          Residualplot(iteration,1)                        =  log10(normR);
          figure(12) 
          plot(Residualplot,'-*')
      end
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    % Mechanical case
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    case 'mechanical'
      %--------------------------------------------------------------------------
      % Corresctor step.
      %--------------------------------------------------------------------------
      while normR>str.data.tolerance
          %----------------------------------------------------------------------
          % Auxiliar displacements.
          %----------------------------------------------------------------------
          Ext_force_vector                                =  zeros(length(str.freedof),1);
          Ext_force_vector(1:length(str.mec_freedof),1)   =  str.nodal_loads.P(str.mec_freedof);
          uhat                                            =  -str.assemb_matrix.reduced_matrix\(str.assemb_force.reduced_force ...
                                                              - str.arc_length.lambda*Ext_force_vector);
          ut                                              =  str.assemb_matrix.reduced_matrix\Ext_force_vector;
          %--------------------------------------------------------------------------
          %  Obtained dot product of up'*up +phip'*phip. up is the total prescribed displacement
          %  and phip is the total prescribed potential.
          %--------------------------------------------------------------------------
          [str]                                           =  updated_constrained_geometry(str);
          str.arc_length.U_prsc_dp                        =  0;
          for iloop1=1:str.data.dim
              str.arc_length.U_prsc_dp                    =  str.arc_length.U_prsc_dp + str.fixed_displacement(iloop1,:)*str.fixed_displacement(iloop1,:)';
          end
          %----------------------------------------------------------------------
          % Quadratic equation.
          %----------------------------------------------------------------------
          [a,b,c,root]                                    =  quadratic_function(ut,uhat,Dxk,str);
          check                                           =  (b^2-4*a*c)/b^2;
          if check<0 && check>1e-4
              root                                         =  0;
          end
          %----------------------------------------------------------------------
          % Checking for sign of the factor inside the root of the quadratic equation.
          %----------------------------------------------------------------------
          if root<0
              str.arc_length.warning                      =  'exceeded';
              fprintf('\nThe root of the quadratic root is negative with value %f with %f, %f, %f and %f. The value of the radius will be decreased\n',root,a,b,c,check)
              break;
          else
              str.arc_length.warning                      =  'satisfied';
          end
          %----------------------------------------------------------------------
          % Number of iterations.
          %----------------------------------------------------------------------
          str.arc_length.n_iterations                     =  str.arc_length.n_iterations + 1;
          %----------------------------------------------------------------------
          % Solving the quadratic equation in order to get dlambda and Dx1.
          %----------------------------------------------------------------------
          [Dxk1,maxangle,str]                             =  solution_quadratic_function(a,b,root,Dxk,uhat,ut,str);
          %----------------------------------------------------------------------
          % Updating variables.
          %----------------------------------------------------------------------
          str.arc_length.Dlambda                          =  str.arc_length.Dlambda + str.arc_length.dlambda;
          str.arc_length.lambda                           =  lambda_0 + str.arc_length.Dlambda;
          %----------------------------------------------------------------------
          % Updated geometry.
          %----------------------------------------------------------------------
          last1                                           =  str.data.dim*str.n_nodes;
          str.arc_length.net_displacement(1:last1,1)      =  Dxk1(1:last1,1) - Dxk(1:last1,1);
          [str]                                           =  updated_geometry(str);
          %----------------------------------------------------------------------
          % Displacements in iteration k
          %----------------------------------------------------------------------
          Dxk                                             =  Dxk1;
          %----------------------------------------------------------------------
          % Calculate reduced stiffness matrix and internal force vector.
          %----------------------------------------------------------------------
          %   [str]                                           =  reduced_matrix(str);
          %   [str]                                           =  reduced_total_vector(str);
          [str]                                           =  reduced_entities(str);
          %----------------------------------------------------------------------
          % Checking the constraint.
          %----------------------------------------------------------------------
          restriction                                     =  (Dxk1'*Dxk1 + str.arc_length.Dlambda^2*str.nodal_loads.P'*str.nodal_loads.P);
          restriction                                     =  sqrt(restriction);
          str.arc_length.restriction_check                = (str.arc_length.radius-restriction)/str.arc_length.radius;
          %----------------------------------------------------------------------
          % Computing updated residual.
          %----------------------------------------------------------------------
          str.Residual.Residual(str.freedof)              =  (str.assemb_force.reduced_force ...
                                                              - str.arc_length.lambda*Ext_force_vector);
          normR                                           =  norm(str.Residual.Residual(str.freedof));
          %----------------------------------------------------------------------
          % Checking convergence.
          %----------------------------------------------------------------------
          if str.arc_length.n_iterations>str.arc_length.desired_n_iterations
              str.arc_length.tolerance_warning             =  'exceeded';
              fprintf('\nThe maximum number of iterations of the corrector step has been %s\n',str.arc_length.tolerance_warning);
              break;
          else
              str.arc_length.tolerance_warning             =  'satisfied';
              fprintf('\nThe maximum number of iterations criterion of the corrector step is %s\n',str.arc_length.tolerance_warning);
          end
      end
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    % Electric case
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    case 'electric'
      %--------------------------------------------------------------------------
      % Corresctor step.
      %--------------------------------------------------------------------------
      while normR>str.data.tolerance
          %----------------------------------------------------------------------
          % Auxiliar displacements.
          %----------------------------------------------------------------------
          Ext_force_vector                                =  zeros(length(str.freedof),1);
          uhat                                            =  -str.assemb_matrix.reduced_matrix\(str.assemb_force.reduced_force ...
                                                             - str.arc_length.lambda*Ext_force_vector);
          ut                                              =  str.assemb_matrix.reduced_matrix\Ext_force_vector;
          %--------------------------------------------------------------------------
          %  Obtained dot product of up'*up +phip'*phip. up is the total prescribed displacement
          %  and phip is the total prescribed potential.
          %--------------------------------------------------------------------------
          [str]                                           =  updated_constrained_geometry(str);
          str.arc_length.U_prsc_dp                        =  0;
          for iloop1=1:str.data.dim
              str.arc_length.U_prsc_dp                    =  str.arc_length.U_prsc_dp + str.fixed_displacement(iloop1,:)*str.fixed_displacement(iloop1,:)';
          end
          [str]                                           =  updated_constrained_potential(str);
          str.arc_length.U_prsc_dp                        =  str.arc_length.U_prsc_dp  + str.elec_cons_val'*str.elec_cons_val;
          %----------------------------------------------------------------------
          % Quadratic equation.
          %----------------------------------------------------------------------
          [a,b,c,root]                                    =  quadratic_function(ut,uhat,Dxk,str);
          check                                           =  (b^2-4*a*c)/b^2;
          if check<0 && check>1e-4
              root                                         =  0;
          end
          %----------------------------------------------------------------------
          % Checking for sign of the factor inside the root of the quadratic equation.
          %----------------------------------------------------------------------
          if root<0
              str.arc_length.warning                      =  'exceeded';
              fprintf('\nThe root of the quadratic root is negative with value %f with %f, %f, %f and %f. The value of the radius will be decreased\n',root,a,b,c,check)
              break;
          else
              str.arc_length.warning                      =  'satisfied';
          end
          %----------------------------------------------------------------------
          % Number of iterations.
          %----------------------------------------------------------------------
          str.arc_length.n_iterations                     =  str.arc_length.n_iterations + 1;
          %----------------------------------------------------------------------
          % Solving the quadratic equation in order to get dlambda and Dx1.
          %----------------------------------------------------------------------
          [Dxk1,maxangle,str]                             =  solution_quadratic_function(a,b,root,Dxk,uhat,ut,str);
          %----------------------------------------------------------------------
          % Updating variables.
          %----------------------------------------------------------------------
          str.arc_length.Dlambda                          =  str.arc_length.Dlambda + str.arc_length.dlambda;
          str.arc_length.lambda                           =  lambda_0 + str.arc_length.Dlambda;
          %----------------------------------------------------------------------
          % Updated geometry.
          %----------------------------------------------------------------------
          last1                                           =  str.data.dim*str.n_nodes;
          str.arc_length.net_displacement(1:last1,1)      =  Dxk1(1:last1,1) - Dxk(1:last1,1);
          [str]                                           =  updated_geometry(str);
          %----------------------------------------------------------------------
          % Updated potential.
          %----------------------------------------------------------------------
          last2                                           =  last1  + str.n_nodes;
          str.arc_length.net_displacement(last1+1:last2,1)=  Dxk1(last1 + 1:last2,1) - Dxk(last1 + 1:last2,1);
          [str]                                           =  updated_potential(str);
          %----------------------------------------------------------------------
          % Displacements in iteration k
          %----------------------------------------------------------------------
          Dxk                                             =  Dxk1;
          %----------------------------------------------------------------------
          % Calculate reduced stiffness matrix and internal force vector.
          %----------------------------------------------------------------------
          %   [str]                                           =  reduced_matrix(str);
          %   [str]                                           =  reduced_total_vector(str);
          [str]                                           =  reduced_entities(str);
          %----------------------------------------------------------------------
          % Checking the constraint.
          %----------------------------------------------------------------------
          restriction                                     =  (Dxk1'*Dxk1 + str.arc_length.Dlambda^2*str.nodal_loads.P'*str.nodal_loads.P);
          restriction                                     =  sqrt(restriction);
          str.arc_length.restriction_check                = (str.arc_length.radius-restriction)/str.arc_length.radius;
          %----------------------------------------------------------------------
          % Computing updated residual.
          %----------------------------------------------------------------------
          str.Residual.Residual(str.freedof)              =  (str.assemb_force.reduced_force ...
              - str.arc_length.lambda*Ext_force_vector);
          normR                                           =  norm(str.Residual.Residual(str.freedof));
          %----------------------------------------------------------------------
          % Checking convergence.
          %----------------------------------------------------------------------
          if str.arc_length.n_iterations>str.arc_length.desired_n_iterations
              str.arc_length.tolerance_warning             =  'exceeded';
              fprintf('\nThe maximum number of iterations of the corrector step has been %s\n',str.arc_length.tolerance_warning);
              break;
          else
              str.arc_length.tolerance_warning             =  'satisfied';
              fprintf('\nThe maximum number of iterations criterion of the corrector step is %s\n',str.arc_length.tolerance_warning);
          end
      end
end
