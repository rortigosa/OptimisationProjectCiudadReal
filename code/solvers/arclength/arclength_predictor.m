function [str]                                 =  arclength_predictor(str)

switch str.data.problem
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    %  Electromechanical case
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    case 'electromechanical'
       dim                                            =  str.data.dim;
       str.arc_length.lambda0                         =  str.arc_length.lambda;
       %--------------------------------------------------------------------------
       % Stiffness matrix in the previous iteration.
       %--------------------------------------------------------------------------
       str.calculation_option                         =  'matrices';
       [str]                                          =  reduced_entities(str);
       %--------------------------------------------------------------------------
       %  Obtained dot product of up'*up +phip'*phip. up is the total prescribed displacement
       %  and phip is the total prescribed potential.
       %--------------------------------------------------------------------------
       str.arc_length.U_prsc_dp                       =  0;
       for iloop1=1:dim
           str.arc_length.U_prsc_dp                   =  str.arc_length.U_prsc_dp + str.fixed_displacement(iloop1,:)*str.fixed_displacement(iloop1,:)';
       end
       str.arc_length.U_prsc_dp                       =  str.arc_length.U_prsc_dp  + str.elec_cons_val'*str.elec_cons_val;
       %--------------------------------------------------------------------------
       %  External force.
       %--------------------------------------------------------------------------
       Ext_force_vector                               =  zeros(length(str.freedof),1);
       Ext_force_vector(1:length(str.mec_freedof),1)  =  str.nodal_loads.P(str.mec_freedof);       
       %--------------------------------------------------------------------------
       %  Necessary variables.
       %--------------------------------------------------------------------------
       str.arc_length.Dxk                             =  zeros((str.data.dim+1)*str.n_nodes,1);

       %--------------------------------------------------------------------------
       % Initialised necessary variables.
       %--------------------------------------------------------------------------
       K                                              =  str.assemb_matrix.reduced_matrix;
       determinant                                    =  det(K);
       KK                                             =  K*K;
       invKK                                          =  inv(KK);
       I                                              =  eye(size(K));
       matrix                                         =  invKK + str.arc_length.scaling_factor^2*I;
       
       %--------------------------------------------------------------------------
       %  Fixed point iterations in order to get Dlambda and lambda (iterating over the
       %  unknown initial internal forces).
       %--------------------------------------------------------------------------
       [str]                                          =  fixed_point_internalforce(str,determinant,invKK,matrix,Ext_force_vector,K);
%        str.arc_length.lambda                          =  str.arc_length.lambda0 + str.arc_length.Dlambda;       
%        %--------------------------------------------------------------------------
%        %  Initial value for displacement.
%        %--------------------------------------------------------------------------
%        Residual                                       =  str.assemb_force.reduced_force-str.arc_length.lambda*Ext_force_vector;       
%        str.arc_length.Dxk(str.freedof)                =  -K\Residual;
%        %----------------------------------------------------------------------
%        % Updated geometry.
%        %----------------------------------------------------------------------
%        str.arc_length.net_displacement                =  zeros((str.data.dim+1)*str.n_nodes,1);
%        last1                                          =  str.data.dim*str.n_nodes;
%        str.arc_length.net_displacement(1:last1,1)     =  str.arc_length.Dxk(1:last1,1);
%        [str]                                          =  updated_geometry(str);
%        %----------------------------------------------------------------------
%        % Updated potential.
%        %----------------------------------------------------------------------
%        last2                                           =  last1  + str.n_nodes;
%        str.arc_length.net_displacement(last1+1:last2,1)=  str.arc_length.Dxk(last1 + 1:last2,1);
%        [str]                                           =  updated_potential(str);
%       %----------------------------------------------------------------------
%       % Computing updated residual.
%       %----------------------------------------------------------------------
%       str.assemb_matrix.old_reduced_matrix            =  str.assemb_matrix.reduced_matrix;
%       %----------------------------------------------------------------------
%       % Updated constrained configuration.
%       %----------------------------------------------------------------------
%       [str]                                           =  updated_constrained_geometry(str);
%       [str]                                           =  updated_constrained_potential(str);      
%       [str]                                           =  reduced_entities(str);
%       str.assemb_matrix.reduced_matrix                =  str.assemb_matrix.old_reduced_matrix;
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    %  Mechanical case
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    case 'mechanical'
       [str]                                          =  reduced_entities(str);
       %--------------------------------------------------------------------------
       %  Necessary variables.
       %--------------------------------------------------------------------------
       str.arc_length.Dxk                             =  zeros(str.data.dim*str.n_nodes,1);
       K                                              =  str.assemb_matrix.reduced_matrix;
       determinant                                    =  det(K);
       KK                                             =  K*K;
       invKK                                          =  inv(KK);
       I                                              =  eye(size(K));
       matrix                                         =  invKK + str.arc_length.scaling_factor^2*I;
       iroot                                          =  str.nodal_loads.P(str.mec_freedof)'*matrix*str.nodal_loads.P(str.mec_freedof);
       Dlambda_1                                      =  str.arc_length.radius/sqrt(iroot);
       Dlambda_2                                      =  -str.arc_length.radius/sqrt(iroot);

       %--------------------------------------------------------------------------
       %  Criterion to choose initial value for DLambda.
       %--------------------------------------------------------------------------
       if sign(determinant)==sign(Dlambda_1)
           str.arc_length.Dlambda                      =  Dlambda_1;
       elseif sign(determinant)==sign(Dlambda_2)
           str.arc_length.Dlambda                      =  Dlambda_2;
       end

       %--------------------------------------------------------------------------
       %  Initial value for displacement.
       %--------------------------------------------------------------------------
       str.arc_length.Dxk(str.mec_freedof)            =  str.assemb_matrix.reduced_matrix\str.nodal_loads.P(str.mec_freedof);
       str.arc_length.Dxk                             =  str.arc_length.Dlambda*str.arc_length.Dxk;

       %--------------------------------------------------------------------------
       %  Update geometry.
       %--------------------------------------------------------------------------
       str.arc_length.net_displacement                =  str.arc_length.Dxk;
       [str]                                          =  updated_geometry(str);
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    %  Electric case
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    case 'electric'
       [str]                                          =  reduced_entities(str);
       %--------------------------------------------------------------------------
       %  Necessary variables.
       %--------------------------------------------------------------------------
       str.arc_length.Dxk                             =  zeros(str.data.dim*str.n_nodes,1);
       K                                              =  str.assemb_matrix.reduced_matrix;
       determinant                                    =  det(K);
       KK                                             =  K*K;
       invKK                                          =  inv(KK);
       I                                              =  eye(size(K));
       matrix                                         =  invKK + str.arc_length.scaling_factor^2*I;
       iroot                                          =  str.nodal_loads.P(str.mec_freedof)'*matrix*str.nodal_loads.P(str.mec_freedof);
       Dlambda_1                                      =  str.arc_length.radius/sqrt(iroot);
       Dlambda_2                                      =  -str.arc_length.radius/sqrt(iroot);

       %--------------------------------------------------------------------------
       %  Criterion to choose initial value for DLambda.
       %--------------------------------------------------------------------------
       if sign(determinant)==sign(Dlambda_1)
           str.arc_length.Dlambda                      =  Dlambda_1;
       elseif sign(determinant)==sign(Dlambda_2)
           str.arc_length.Dlambda                      =  Dlambda_2;
       end

       %--------------------------------------------------------------------------
       %  Initial value for displacement.
       %--------------------------------------------------------------------------
       str.arc_length.Dxk(str.mec_freedof)            =  str.assemb_matrix.reduced_matrix\str.nodal_loads.P(str.mec_freedof);
       str.arc_length.Dxk                             =  str.arc_length.Dlambda*str.arc_length.Dxk;

       %--------------------------------------------------------------------------
       %  Update geometry.
       %--------------------------------------------------------------------------
       str.arc_length.net_displacement                =  str.arc_length.Dxk;
       [str]                                          =  updated_geometry(str);
end