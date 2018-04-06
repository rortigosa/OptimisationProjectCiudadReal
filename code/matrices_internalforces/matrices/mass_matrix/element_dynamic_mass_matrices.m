%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This functions computes the stiffness matrix resulting from linearising
% the term D^2(Pi_int)[deltav,u].
% This matrix accounts for both constitutive and geometric stiffness
% matrices.
% [Kuu]11  [Kuu]12
% [Kuu]21  [Kuu]22
% Where
% [Kuu]E1E2 =  Kuu_E1E2     Kutheta_E1E2
%              KthetauE1E2  KthetathetaE1E2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [str]                                            =  element_dynamic_mass_matrices(str)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. main. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
%----------------------------------------------------------------------
%----------------------------------------------------------------------
%  Stiffness matrices.
%----------------------------------------------------------------------
%----------------------------------------------------------------------
%------------------------------------------------------------
% Compute second piola and D0
%------------------------------------------------------------
continuum_element                                         =  str.solid.BEAM_SHELL.continuum.continuum_element;
mechanical_element                                        =  str.solid.BEAM_SHELL.discrete.mechanical_element;
n_node_mechanical_element                                 =  size(str.solid.BEAM_SHELL.discrete.mesh.connectivities,2);
%------------------------------------------------------------------
% Stiffness Matrix corresponding to the motion. Kuu
%------------------------------------------------------------------
str.Maa                                                   =  zeros(3*n_node_mechanical_element);
str.Mww                                                   =  zeros(3*n_node_mechanical_element);
str.Mwa                                                   =  zeros(3*n_node_mechanical_element);
str.Maw                                                   =  zeros(3*n_node_mechanical_element);
%------------------------------------------------------------------
% Stiffness matricess Kuu, Kthetatheta, Kutheta and
% Kthetau.
%------------------------------------------------------------------
for alpha=1:n_node_mechanical_element
    for beta=1:n_node_mechanical_element
        MAA                                               =  zeros(3,3);
        MWW                                               =  zeros(3,3);
        MAW                                               =  zeros(3,3);
        MWA                                               =  zeros(3,3);
        %----------------------------------------------------------
        % Gradients of shape functions in matrix notation.
        %----------------------------------------------------------
        str.temp.nodal_Eulerian_covariants                =  str.solid.BEAM_SHELL.discrete.Eulerian_covariant(:,:,:,mechanical_element);
        for igauss=1:size(str.solid.BEAM_SHELL.continuum.inertial.quadrature.Chi,1)
            str.temp.continuum_element                    =  str.solid.BEAM_SHELL.continuum.continuum_element;
            str.temp.R                                    =  str.solid.BEAM_SHELL.continuum.inertial.discrete_information_at_gauss_level.Lagrangian_inner_position(:,igauss,continuum_element);
            str.temp.Lagrangian_contravariants            =  str.solid.BEAM_SHELL.continuum.inertial.discrete_information_at_gauss_level.Lagrangian_contravariant(:,:,igauss,continuum_element);
            str.temp.mec_Nshape                           =  str.solid.BEAM_SHELL.continuum.inertial.discrete_information_at_gauss_level.f_e.N(:,igauss,continuum_element);
            %------------------------------------------------------
            % Information for Gauss integration
            %------------------------------------------------------
            J_t                                           =  str.solid.BEAM_SHELL.continuum.inertial.grad.isoparametric_jacobean(igauss,continuum_element);
            W                                             =  str.solid.BEAM_SHELL.continuum.inertial.quadrature.W_v(igauss);
            %------------------------------------------------------
            % C. Mass matrix for thetatheta (dynamic problems).
            %------------------------------------------------------
            [Maa,Maw,Mwa,Mww]                             =  mass_matrix_beamshell(alpha,beta,str);
            MAA                                           =  MAA + Maa*eye(3)*(J_t*W);
            MAW                                           =  MAW + Maw*(J_t*W);
            MWA                                           =  MWA + Mwa*(J_t*W);
            MWW                                           =  MWW + Mww*(J_t*W);
        end
        %----------------------------------------------------------
        % Assembling of Kuu
        %----------------------------------------------------------
        str.Maa(3*alpha-(3-1):3*alpha,...
            3*beta-(3-1):3*beta)                          =  MAA   + str.Maa(3*alpha-(3-1):3*alpha,3*beta-(3-1):3*beta);
        str.Mww(3*alpha-(3-1):3*alpha,...
            3*beta-(3-1):3*beta)                          =  MWW   + str.Mww(3*alpha-(3-1):3*alpha,3*beta-(3-1):3*beta);
        str.Maw(3*alpha-(3-1):3*alpha,...
            3*beta-(3-1):3*beta)                          =  MAW   + str.Mwa(3*alpha-(3-1):3*alpha,3*beta-(3-1):3*beta);
        str.Mwa(3*alpha-(3-1):3*alpha,...
            3*beta-(3-1):3*beta)                          =  MWA   + str.Mwa(3*alpha-(3-1):3*alpha,3*beta-(3-1):3*beta);
    end
end

%------------------------------------------------------------------
% Merge traslational and rotational dofs into a single
% matrix to get the following matrix:
%------------------------------------------------------------------
telements                                                 =  (1:(6))';
add_elements                                              =  6*ones(6,1);
for ime=1:n_node_mechanical_element
    for jme=1:n_node_mechanical_element
        str.MAA(telements+(ime-1)*add_elements,...
            telements+(jme-1)*add_elements)               =  [[str.Maa((1:3) + 3*(ime-1)*ones(1,3),(1:3)+3*(jme-1)*ones(1,3))     str.Maw((1:3)+3*(ime-1)*ones(1,3),(1:3)+3*(jme-1)*ones(1,3))];...
                                                              [str.Mwa((1:3)+3*(ime-1)*ones(1,3),(1:3)+3*(jme-1)*ones(1,3))       str.Mww((1:3)+3*(ime-1)*ones(1,3),(1:3)+3*(jme-1)*ones(1,3))]];
    end
end

str.MAA                                                   =  (1-str.data.alpham_alpha_method)*str.MAA;



             