%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  The intertial residuals in beams can be written as:
%  
%  Rintertial  = [Maa Maw][a0  ]   +  [Ta   ]
%              = [Mwa Mww][wdot]   +  [Twdot]
%
% We compute both the mass matrix associated to this residual, which due to the
% nonlinearity involved, does not coincide with its linearisation and 
% the residuals Ta and Twdot. This is done here at element level.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [str]                                                     =  inertial_residual_beamshell(str)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. main. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------------------------------------------------------
% Dimension of the problem
%--------------------------------------------------------------------------
nodes                                                              =  str.connectivity(str.ielem,:);
xelem                                                              =  str.Eulerian_x(:,nodes);
Xelem                                                              =  str.Lagrangian_X(:,nodes);
phielem                                                            =  str.phi(nodes,1);
str                                                                =  gradients(xelem,Xelem,phielem,str);
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Mass matrix.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
continuum_element                                                  =  str.solid.BEAM_SHELL.continuum.continuum_element;
mechanical_element                                                 =  str.solid.BEAM_SHELL.discrete.mechanical_element;
n_node_mechanical_element                                          =  size(str.solid.BEAM_SHELL.discrete.mesh.connectivities,2);
%--------------------------------------------------------------------------
% Initialised residual
%--------------------------------------------------------------------------
T_a                                                                =  zeros(3,n_node_mechanical_element);
T_w                                                                =  zeros(3,n_node_mechanical_element);
%--------------------------------------------------------------------------
% Stiffness matricess Kuu, Kthetatheta, Kutheta and
% Kthetau.
%--------------------------------------------------------------------------
str.Kuu                                                            =  zeros(3*n_node_mechanical_element);
str.Kthetatheta                                                    =  zeros(3*n_node_mechanical_element);
str.Kutheta                                                        =  zeros(3*n_node_mechanical_element,3*n_node_mechanical_element);
str.Kthetau                                                        =  zeros(3*n_node_mechanical_element,3*n_node_mechanical_element)';
for alpha=1:n_node_mechanical_element
    for beta=1:n_node_mechanical_element
        M_aa                                                       =  zeros(3,3);
        M_ww                                                       =  zeros(3,3);
        M_aw                                                       =  zeros(3,3);
        M_wa                                                       =  zeros(3,3);
        %------------------------------------------------------------------
        % Gradients of shape functions in matrix notation.
        %------------------------------------------------------------------
        str.temp.nodal_Eulerian_covariants                         =  str.solid.BEAM_SHELL.discrete.Eulerian_covariant(:,:,:,mechanical_element);
        for igauss=1:size(str.solid.BEAM_SHELL.continuum.inertial.quadrature.Chi,1)
            str.temp.continuum_element                             =  str.solid.BEAM_SHELL.continuum.continuum_element;
            str.temp.R                                             =  str.solid.BEAM_SHELL.continuum.inertial.discrete_information_at_gauss_level.Lagrangian_inner_position(:,igauss,continuum_element);
            str.temp.Lagrangian_contravariants                     =  str.solid.BEAM_SHELL.continuum.inertial.discrete_information_at_gauss_level.Lagrangian_contravariant(:,:,igauss,continuum_element);
            str.temp.mec_Nshape                                    =  str.solid.BEAM_SHELL.continuum.inertial.discrete_information_at_gauss_level.f_e.N(:,igauss,continuum_element);
            %--------------------------------------------------------------
            % Information for Gauss integration
            %--------------------------------------------------------------
            J_t                                                    =  str.solid.BEAM_SHELL.continuum.inertial.grad.isoparametric_jacobean(igauss,continuum_element);
            W                                                      =  str.solid.BEAM_SHELL.continuum.inertial.quadrature.W_v(igauss);
            %--------------------------------------------------------------
            % C. Mass matrix 
            %--------------------------------------------------------------
            [Maa,Maw,Mwa,Mww]                                      =  mass_matrix_beamshell_residual(alpha,beta,str);
            M_aa                                                   =  M_aa + Maa*eye(3)*(J_t*W);
            M_aw                                                   =  M_aw + Maw*(J_t*W);
            M_wa                                                   =  M_wa + Mwa*(J_t*W);
            M_ww                                                   =  M_ww + Mww*(J_t*W);
            %--------------------------------------------------------------
            % Residuals 
            %--------------------------------------------------------------
            [Ta,Tw]                                                =  mass_matrix_beamshell_residual_residual(alpha,beta,str);
            T_a(:,alpha)                                           =  T_a(:,alpha) + Ta*(J_t*W);
            T_w(:,alpha)                                           =  T_w(:,alpha) + Tw*(J_t*W);
        end
        %------------------------------------------------------------------
        % Assembling of mass matrix
        %------------------------------------------------------------------
        str.Kuu(3*alpha-(3-1):3*alpha,...
            3*beta-(3-1):3*beta)                                   =  M_aa       + str.Kuu(3*alpha-(3-1):3*alpha,3*beta-(3-1):3*beta);
        str.Kthetatheta(3*alpha-(3-1):3*alpha,...
            3*beta-(3-1):3*beta)                                   =  M_ww       + str.Kthetatheta(3*alpha-(3-1):3*alpha,3*beta-(3-1):3*beta);
        str.Kutheta(3*alpha-(3-1):3*alpha,...
            3*beta-(3-1):3*beta)                                   =  M_aw       + str.Kutheta(3*alpha-(3-1):3*alpha,3*beta-(3-1):3*beta);
        str.Kthetau(3*alpha-(3-1):3*alpha,...
            3*beta-(3-1):3*beta)                                   =  M_wa       + str.Kthetau(3*alpha-(3-1):3*alpha,3*beta-(3-1):3*beta);
    end
end
%--------------------------------------------------------------------------
% Merge traslational and rotational dofs into a single
% matrix to get the following matrix:  
%--------------------------------------------------------------------------
telements                                                          =  (1:(6))';
add_elements                                                       =  6*ones(6,1);
for ime=1:n_node_mechanical_element
    for jme=1:n_node_mechanical_element
        str.KUU(telements+(ime-1)*add_elements,...
            telements+(jme-1)*add_elements)                        =  [[str.Kuu((1:3) + 3*(ime-1)*ones(1,3),(1:3)+3*(jme-1)*ones(1,3))     str.Kutheta((1:3)+3*(ime-1)*ones(1,3),(1:3)+3*(jme-1)*ones(1,3))];...
                                                                       [str.Kthetau((1:3)+3*(ime-1)*ones(1,3),(1:3)+3*(jme-1)*ones(1,3))   str.Kthetatheta((1:3)+3*(ime-1)*ones(1,3),(1:3)+3*(jme-1)*ones(1,3))]];
    end
end
%--------------------------------------------------------------------------
% Reshape force vector
%--------------------------------------------------------------------------
str.Tm_element                                                     =  [T_a; T_w];
str.Tm_element                                                     =  reshape(str.Tm_element,size(str.Tm_element,1)*size(str.Tm_element,2),1);

end


