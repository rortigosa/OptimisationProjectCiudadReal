function [str]                                 =  initial_radius(str)

switch str.data.problem
    case 'electromechanical'
      %--------------------------------------------------------------------------
      %  Necessary variables. 
      %--------------------------------------------------------------------------
      str.arc_length.scaling_factor                  =  str.data.scaling_factor;
      save results.mat
      load results.mat
      str.arc_length.displacement                    =  zeros((str.data.dim+1)*str.n_nodes,1);
      str.arc_length.lambda                          =  str.data.initial_lambda;
      str.arc_length.Dlambda                         =  str.arc_length.lambda;
      str.arc_length.dlambda                         =  str.arc_length.Dlambda;
      Ext_force_vector                               =  zeros(length(str.freedof),1);
      Ext_force_vector(1:length(str.mec_freedof),1)  =  str.arc_length.lambda*str.nodal_loads.P(str.mec_freedof);
      %--------------------------------------------------------------------------
      % Calculate reduced stiffness matrix and internal force vector. 
      %--------------------------------------------------------------------------
      str.calculation_option                         =  'matrices';
      [str]                                          =  reduced_entities(str);
      %--------------------------------------------------------------------------
      %  Obtained dot product of up'*up +phip'*phip. up is the total prescribed displacement
      %  and phip is the total prescribed potential.
      %--------------------------------------------------------------------------
      [str]                                          =  updated_constrained_geometry(str);
      str.arc_length.U_prsc_dp                       =  0;
      for iloop1=1:str.data.dim
          str.arc_length.U_prsc_dp                   =  str.arc_length.U_prsc_dp + str.fixed_displacement(iloop1,:)*str.fixed_displacement(iloop1,:)';
      end
      [str]                                          =  updated_constrained_potential(str);
      str.arc_length.U_prsc_dp                       =  str.arc_length.U_prsc_dp  + str.elec_cons_val'*str.elec_cons_val;
      %--------------------------------------------------------------------------
      % Calculate reduced stiffness matrix and internal force vector. 
      %--------------------------------------------------------------------------
      str.calculation_option                         =  'fvectors';
      [str]                                          =  reduced_entities(str);
      %--------------------------------------------------------------------------
      % Residual.
      %--------------------------------------------------------------------------
      Residual                                       =  (str.assemb_force.reduced_force - Ext_force_vector);
      %--------------------------------------------------------------------------
      % Initial radius.
      %--------------------------------------------------------------------------
      str.arc_length.Dxk                             =  zeros((str.data.dim+1)*str.n_nodes,1);
      str.arc_length.Dxk(str.freedof)                =  -str.assemb_matrix.reduced_matrix\Residual;
      xv                                             =  str.arc_length.Dxk'*str.arc_length.Dxk;
      yv                                             =  str.arc_length.lambda^2*(str.arc_length.scaling_factor^2*Ext_force_vector'*Ext_force_vector...
                                                        + str.arc_length.U_prsc_dp);
      str.arc_length.radius                          =  sqrt(xv + yv);
      radius                                         =  str.arc_length.radius;
      str.arc_length.lambda                          =  0;
      lambda                                         =  str.arc_length.lambda;
      str.arc_length.Fint0                           =  str.assemb_force.reduced_force;
      Fint0                                          =  str.arc_length.Fint0;
      save('radius.mat','radius')
      save('lambda.mat','lambda')
      save('Fint.mat','Fint0')
    case 'mechanical'
      str.arc_length.scaling_factor                  =  str.data.scaling_factor;
      str.arc_length.displacement                    =  zeros(str.data.dim*str.n_nodes,1);
      str.arc_length.lambda                          =  str.data.initial_lambda;
      external_force                                 =  str.arc_length.lambda*str.nodal_loads.P(str.mec_freedof);
      %--------------------------------------------------------------------------
      % Calculate reduced stiffness matrix and internal force vector.
      %--------------------------------------------------------------------------
      % [str]                                        =  reduced_matrix(str);
      % [str]                                        =  reduced_total_vector(str);
      [str]                                          =  reduced_entities(str);
      %--------------------------------------------------------------------------
      % Residual.
      %--------------------------------------------------------------------------
      Residual                                       =  (str.assemb_force.reduced_force - external_force);
      %--------------------------------------------------------------------------
      %  Obtained dot product of up'*up +phip'*phip. up is the total prescribed displacement
      %  and phip is the total prescribed potential.
      %--------------------------------------------------------------------------
      [str]                                          =  updated_constrained_geometry(str);
      str.arc_length.U_prsc_dp                       =  0;
      for iloop1=1:str.data.dim
          str.arc_length.U_prsc_dp                   =  str.arc_length.U_prsc_dp + str.fixed_displacement(iloop1,:)'*str.fixed_displacement(iloop1,:);
      end
      %--------------------------------------------------------------------------
      % Initial radius.
      %--------------------------------------------------------------------------
      str.arc_length.displacement(str.mec_freedof)   =  -str.assemb_matrix.reduced_matrix\Residual;
      xv                                             =  sqrt(str.arc_length.displacement'*str.arc_length.displacement);
      yv                                             =  sqrt(norm(str.arc_length.scaling_factor*external_force)^2 + str.arc_length.lambda^2*str.arc_length.U_prsc_dp);
      %str.arc_length.radius                          =  sqrt(str.arc_length.displacement'*str.arc_length.displacement);
      str.arc_length.radius                          =  sqrt(xv^2 + yv^2);
    case 'electric'
      str.arc_length.scaling_factor                  =  str.data.scaling_factor;
      str.arc_length.displacement                    =  zeros(str.data.dim*str.n_nodes,1);
      str.arc_length.lambda                          =  str.data.initial_lambda;
      %--------------------------------------------------------------------------
      % Calculate reduced stiffness matrix and internal force vector.
      %--------------------------------------------------------------------------
      % [str]                                        =  reduced_matrix(str);
      % [str]                                        =  reduced_total_vector(str);
      [str]                                          =  reduced_entities(str);
      %--------------------------------------------------------------------------
      % Residual.
      %--------------------------------------------------------------------------
      Residual                                       =  (str.assemb_force.reduced_force);
      %--------------------------------------------------------------------------
      %  Obtained dot product of up'*up +phip'*phip. up is the total prescribed displacement
      %  and phip is the total prescribed potential.
      %--------------------------------------------------------------------------
      [str]                                          =  updated_constrained_potential(str);
      str.arc_length.U_prsc_dp                       =  str.arc_length.U_prsc_dp  + str.elec_cons_val'*str.elec_cons_val;
      %--------------------------------------------------------------------------
      % Initial radius.
      %--------------------------------------------------------------------------
      str.arc_length.displacement(str.mec_freedof)   =  -str.assemb_matrix.reduced_matrix\Residual;
      xv                                             =  sqrt(str.arc_length.displacement'*str.arc_length.displacement);
      yv                                             =  sqrt(str.arc_length.lambda^2*str.arc_length.U_prsc_dp);
      %str.arc_length.radius                          =  sqrt(str.arc_length.displacement'*str.arc_length.displacement);
      str.arc_length.radius                          =  sqrt(xv^2 + str.arc_length.scaling_factor*yv^2);
end        