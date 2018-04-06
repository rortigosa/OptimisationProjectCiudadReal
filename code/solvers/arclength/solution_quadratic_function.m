%--------------------------------------------------------------------------
% We get dlambda and Dx(displacement) in this function
%--------------------------------------------------------------------------
function [Dxk1,maxangle,str]                    =  solution_quadratic_function(a,b,root,Dxk,uhat,ut,str)

switch str.data.problem
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    % Electromechanical case
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    case 'electromechanical'
      Dxk1                                            =  zeros((str.data.dim+1)*str.n_nodes,1);
      %----------------------------------------------------------------------
      % Solution of the quadratic equation.
      %----------------------------------------------------------------------
      dlambda_1                                       =  (-b - sqrt(root))/(2*a);
      dlambda_2                                       =  (-b + sqrt(root))/(2*a);
      disp1                                           =  Dxk(str.freedof) + uhat + dlambda_1*ut;
      disp2                                           =  Dxk(str.freedof) + uhat + dlambda_2*ut;
      %----------------------------------------------------------------------
      % Intermediate variables. 
      %----------------------------------------------------------------------
      Ext_force_vector                                =  zeros(str.n_nodes*(str.data.dim+1),1);                                               
      Ext_force_vector(1:str.n_nodes*str.data.dim,1)  =  str.nodal_loads.P;
      str.presc                                       =  zeros(str.n_nodes*(str.data.dim+1),1);
      index                                           =  (str.n_nodes-1)*str.data.dim;
      for iloop1=1:str.data.dim
          str.presc(iloop1:str.data.dim:index+...
                                          iloop1,1)   =  str.fixed_displacement(iloop1,:);
      end
      
      ini                                             =  str.n_nodes*str.data.dim;
      last                                            =  str.n_nodes*(str.data.dim+1);
      str.prescr_elec                                 =  zeros(str.n_nodes,1);
      str.prescr_elec(str.elec_fixdof)                =  str.elec_cons_val;
      str.presc(ini+1:last,1)                         =  str.prescr_elec;
      %----------------------------------------------------------------------
      % Cosines in the quadratic equation.
      %----------------------------------------------------------------------
      x1                                              =  disp1;
      x2                                              =  disp2;
      x                                               =  Dxk(str.freedof);
      y1                                              =  (str.arc_length.Dlambda + dlambda_1)*(str.arc_length.scaling_factor*Ext_force_vector...
                                                          + str.presc);
      y2                                              =  (str.arc_length.Dlambda + dlambda_2)*(str.arc_length.scaling_factor*Ext_force_vector...
                                                          + str.presc);
      y                                               =  (str.arc_length.Dlambda)*(str.arc_length.scaling_factor*Ext_force_vector...
                                                          + str.presc);
%     v1                                              =  [x1;y1];
%     v2                                              =  [x2;y2];
%     v                                               =  [x ; y];
%     costheta1                                       =  (v1'*v)/str.arc_length.radius^2;
%     costheta2                                       =  (v2'*v)/str.arc_length.radius^2;
      costheta1                                       =  (x1'*x + y1'*y)/str.arc_length.radius^2;
      costheta2                                       =  (x2'*x + y2'*y)/str.arc_length.radius^2;
      maxangle                                        =  max(costheta1,costheta2);
      %--------------------------------------------------------------------------
      % Criterion to determine dlambda and disp(Dx) 
      %--------------------------------------------------------------------------
      if maxangle==costheta1
          str.arc_length.dlambda                       =  dlambda_1;
          Dxk1(str.freedof)                            =  Dxk(str.freedof) + uhat + dlambda_1*ut;
      elseif maxangle==costheta2
          str.arc_length.dlambda                       =  dlambda_2;
          Dxk1(str.freedof)                            =  Dxk(str.freedof) + uhat + dlambda_2*ut;
      end
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    % Mechanical case 
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    case 'mechanical'
      Dxk1                                            =  zeros(str.data.dim*str.n_nodes,1);
      %----------------------------------------------------------------------
      % Solution of the quadratic equation.
      %----------------------------------------------------------------------
      dlambda_1                                       =  (-b - sqrt(root))/(2*a);
      dlambda_2                                       =  (-b + sqrt(root))/(2*a);
      disp1                                           =  Dxk(str.freedof) + uhat + dlambda_1*ut;
      disp2                                           =  Dxk(str.freedof) + uhat + dlambda_2*ut;
      %----------------------------------------------------------------------
      % Intermediate variables.
      %----------------------------------------------------------------------
      Ext_force_vector                                =  zeros(length(str.freedof),1);                                               
      Ext_force_vector(1:length(str.mec_freedof),1)   =  str.nodal_loads.P(str.mec_freedof);
      str.int_presc                                   =  zeros(length(str.freedof),1);
      index                                           =  (str.n_nodes-1)*str.data.dim;
      for iloop1=1:str.data.dim
          str.int_presc(iloop1,str.data.dim:index+...
                                            iloop1)   =  str.fixed_displacement(iloop1,:);
      end
      str.presc(1:length(str.mec_freedof),1)          =  str.int_presc(str.mec_freedof,1);      
      %----------------------------------------------------------------------
      % Cosines in the quadratic equation.
      %----------------------------------------------------------------------
      x1                                              =  disp1;
      x2                                              =  disp2;
      x                                               =  Dxk(str.mec_freedof);
      y1                                              =  (str.arc_length.Dlambda + dlambda_1)*(str.arc_length.scaling_factor*Ext_force_vector...
                                                         + str.presc);
      y2                                              =  (str.arc_length.Dlambda + dlambda_2)*(str.arc_length.scaling_factor*Ext_force_vector...
                                                         + str.presc);
      y                                               =  (str.arc_length.Dlambda)*(str.arc_length.scaling_factor*Ext_force_vector...
                                                         + str.presc);
%     v1                                              =  [x1;y1];
%     v2                                              =  [x2;y2];
%     v                                               =  [x ; y];
%     costheta1                                       =  (v1'*v)/str.arc_length.radius^2;
%     costheta2                                       =  (v2'*v)/str.arc_length.radius^2;
      costheta1                                       =  (x1'*x + y1'*y)/str.arc_length.radius^2;
      costheta2                                       =  (x2'*x + y2'*y)/str.arc_length.radius^2;
      maxangle                                        =  max(costheta1,costheta2);
      %--------------------------------------------------------------------------
      % Criterion to determine dlambda and disp(Dx)
      %--------------------------------------------------------------------------
      if maxangle==costheta1
          str.arc_length.dlambda                       =  dlambda_1;
          Dxk1(str.mec_freedof)                        =  Dxk(str.mec_freedof) + uhat + dlambda_1*ut;
      elseif maxangle==costheta2
          str.arc_length.dlambda                       =  dlambda_2;
          Dxk1(str.mec_freedof)                        =  Dxk(str.mec_freedof) + uhat + dlambda_2*ut;
      end
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    % Electric case
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    case 'electric'
      Dxk1                                            =  zeros(str.data.dim*str.n_nodes,1);
      %----------------------------------------------------------------------
      % Solution of the quadratic equation.
      %----------------------------------------------------------------------
      dlambda_1                                       =  (-b - sqrt(root))/(2*a);
      dlambda_2                                       =  (-b + sqrt(root))/(2*a);
      disp1                                           =  Dxk(str.freedof) + uhat + dlambda_1*ut;
      disp2                                           =  Dxk(str.freedof) + uhat + dlambda_2*ut;
      %----------------------------------------------------------------------
      % Intermediate variables.
      %----------------------------------------------------------------------
      str.presc                                       =  zeros(length(str.freedof),1);
      str.presc                                       =  str.elec_cons_val;
      %----------------------------------------------------------------------
      % Cosines in the quadratic equation.
      %----------------------------------------------------------------------
      x1                                              =  disp1;
      x2                                              =  disp2;
      x                                               =  Dxk(str.mec_freedof);
      y1                                              =  (str.arc_length.Dlambda + dlambda_1)*(str.elec_cons_val);
      y2                                              =  (str.arc_length.Dlambda + dlambda_2)*(str.elec_cons_val);
      y                                               =  (str.arc_length.Dlambda)*(str.elec_cons_val);
      v1                                              =  [x1;y1];
      v2                                              =  [x2;y2];
      v                                               =  [x ; y];

      costheta1                                       =  (v1'*v)/str.arc_length.radius^2;
      costheta2                                       =  (v2'*v)/str.arc_length.radius^2;
      maxangle                                        =  max(costheta1,costheta2);
      %--------------------------------------------------------------------------
      % Criterion to determine dlambda and disp(Dx)
      %--------------------------------------------------------------------------
      if maxangle==costheta1
          str.arc_length.dlambda                       =  dlambda_1;
          Dxk1(str.mec_freedof)                        =  Dxk(str.mec_freedof) + uhat + dlambda_1*ut;
      elseif maxangle==costheta2
          str.arc_length.dlambda                       =  dlambda_2;
          Dxk1(str.mec_freedof)                        =  Dxk(str.mec_freedof) + uhat + dlambda_2*ut;
      end
end        