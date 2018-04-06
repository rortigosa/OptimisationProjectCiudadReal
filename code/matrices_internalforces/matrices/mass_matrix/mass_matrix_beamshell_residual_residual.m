%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  The intertial residuals in beams can be written as:
%  
%  Rintertial  = [Maa Maw][a0  ]   +  [Ta   ]
%              = [Mwa Mww][wdot]   +  [Twdot]
%
% We compute the residuals Ta and Twdot in this function.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Ta,Tw]             =  mass_matrix_beamshell_residual_residual(alpha,beta,str)

rho                          =  str.data.Rho;
mechanical_element           =  str.solid.BEAM_SHELL.discrete.mechanical_element;
node_beta                    =  str.solid.BEAM_SHELL.discrete.mesh.connectivities(mechanical_element,beta);
Nshape                       =  str.temp.mec_Nshape;
R                            =  str.temp.R;
Eulerian_covariants          =  str.temp.nodal_Eulerian_covariants;
Lagrangian_contravariants    =  str.temp.Lagrangian_contravariants;

%--------------------------------------------------------------------------
% Nodal angular velocity and accelerations in node beta
%--------------------------------------------------------------------------
initial_dof_beta             =  node_beta*6-2;
final_dof_beta               =  node_beta*6;
angular_velocity             =  str.solid.BEAM_SHELL.discrete.velocity(initial_dof_beta:final_dof_beta);


Ta                           =  zeros(3,1);
Tw                           =  zeros(3,1);
for inode=1:3
    a                        =  cross(angular_velocity,Eulerian_covariants(:,inode,beta)*Nshape(beta));
    Ta                       =  Ta + 0*rho*(Nshape(alpha)*cross(angular_velocity,a))*(Lagrangian_contravariants(:,inode)'*R);
end

for inode=1:3
    for jnode=1:3
        %------------------------------------------------------------------
        %------------------------------------------------------------------
        %------------------------------------------------------------------
        a                    =  cross(angular_velocity,Eulerian_covariants(:,jnode,beta)*Nshape(beta));
        Tw                   =  Tw -  rho*levi_civita(Eulerian_covariants(:,inode,alpha)*Nshape(alpha),3)*cross(angular_velocity,a)*(Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);
        %------------------------------------------------------------------
        %------------------------------------------------------------------
        %------------------------------------------------------------------
%        a                    =  cross(angular_velocity,Eulerian_covariants(:,jnode,beta)*Nshape(beta));
%        Tw                   =  Tw -  rho*levi_civita(Lagrangian_contravariants(:,inode)*Nshape(alpha),3)*cross(angular_velocity,a)*(Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);
%        Tw                   =  Tw -  rho*levi_civita(Lagrangian_contravariants(:,inode)*Nshape(alpha),3)*cross(angular_velocity,a)*(Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);
%        Tw                   =  Tw -  rho*levi_civita(Eulerian_covariants(:,inode,alpha)*Nshape(alpha),3)*cross(angular_velocity,a)*(Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);
         %--a                    =  cross(angular_velocity,Lagrangian_contravariants(:,jnode)*Nshape(beta));
         %--Tw                   =  Tw -  0*rho*levi_civita(Lagrangian_contravariants(:,inode)*Nshape(alpha),3)*cross(angular_velocity,a)*(Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);
    end
end
