function [Maa,Maw,Mwa,Mww]   =  mass_matrix_beamshell(alpha,beta,str)

rho                          =  str.data.Rho;
time_factor                  =  str.data.delta_t*str.data.gamma_alpha_method;
time_factor_2                =  str.data.delta_t^2*str.data.beta_alpha_method;
mechanical_element           =  str.solid.BEAM_SHELL.discrete.mechanical_element;
node_beta                    =  str.solid.BEAM_SHELL.discrete.mesh.connectivities(mechanical_element,beta);
Nshape                       =  str.temp.mec_Nshape;
R                            =  str.temp.R;
Eulerian_covariants          =  str.temp.nodal_Eulerian_covariants;
Lagrangian_contravariants    =  str.temp.Lagrangian_contravariants;
n_node_mechanical_element    =  size(str.solid.BEAM_SHELL.discrete.mesh.connectivities,2);
%--------------------------------------------------------------------------
% Nodal angular velocity and accelerations in node beta
%--------------------------------------------------------------------------
initial_dof_beta             =  node_beta*6-2;
final_dof_beta               =  node_beta*6;
angular_acceleration         =  str.solid.BEAM_SHELL.discrete.acceleration(initial_dof_beta:final_dof_beta);
angular_velocity             =  str.solid.BEAM_SHELL.discrete.velocity(initial_dof_beta:final_dof_beta);
%--------------------------------------------------------------------------
% Linear acceleration in a particular gauss node
%--------------------------------------------------------------------------
acceleration                 =  reshape(str.solid.BEAM_SHELL.discrete.acceleration,6,size(str.solid.BEAM_SHELL.discrete.Lagrangian_X,2));
linear_acceleration          =  acceleration(1:3,:);
nodal_linear_acceleration    =  linear_acceleration(:,str.solid.BEAM_SHELL.discrete.mesh.connectivities(mechanical_element,:));
gauss_linear_acceleration    =  nodal_linear_acceleration*Nshape;

Maa1                         =  rho*Nshape(alpha)*Nshape(beta);

Maw2                         =  zeros(3,3);
Maw3                         =  zeros(3,3);
Mwa4                         =  zeros(3,3);
Mww4                         =  zeros(3,3);
Mww5                         =  zeros(3,3);
Mww6                         =  zeros(3,3);
for inode=1:3
    Maw2                     =  Maw2 + rho*(Nshape(alpha)*levi_civita(Eulerian_covariants(:,inode,beta)*Nshape(beta),3) + ...
                                            time_factor_2*Nshape(alpha)*levi_civita(angular_acceleration,3)*levi_civita(Eulerian_covariants(:,inode,beta)*Nshape(beta),3))*(Lagrangian_contravariants(:,inode)'*R);
    Maw3                     =  Maw3 + rho*(time_factor*Nshape(alpha)*levi_civita(cross(angular_velocity,(Eulerian_covariants(:,inode,beta)*Nshape(beta))),3) - ...
                                            time_factor*Nshape(alpha)*levi_civita(angular_velocity,3)*levi_civita(Eulerian_covariants(:,inode,beta)*Nshape(beta),3) +...
                                            time_factor_2*Nshape(alpha)*levi_civita(angular_velocity,3)*levi_civita(angular_velocity,3)*levi_civita(Eulerian_covariants(:,inode,beta)*Nshape(beta),3))*...
                                            (Lagrangian_contravariants(:,inode)'*R);
    Mwa4                     =  Mwa4 - rho*levi_civita(Eulerian_covariants(:,inode,alpha)*Nshape(alpha),3)*Nshape(beta)*(Lagrangian_contravariants(:,inode)'*R);
    node_comparison          =  alpha-beta;
    switch node_comparison
        case 0
             Mww4            =  Mww4 + rho*time_factor_2*levi_civita(gauss_linear_acceleration,3)*levi_civita(Eulerian_covariants(:,inode,alpha)*Nshape(alpha),3)*Nshape(beta)*(Lagrangian_contravariants(:,inode)'*R);                                        
    end
end

for inode=1:3
    for jnode=1:3
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
         Mww5                =  Mww5 + rho*(-levi_civita(Eulerian_covariants(:,inode,alpha)*Nshape(alpha),3)*levi_civita(Eulerian_covariants(:,jnode,beta)*Nshape(beta),3) + ...;
                                             time_factor_2*levi_civita(Eulerian_covariants(:,inode,alpha)*Nshape(alpha),3)*levi_civita(angular_acceleration,3)*levi_civita(Eulerian_covariants(:,jnode,beta)*Nshape(beta),3))*...
                                             (Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%       Mww5                =  Mww5 + rho*(-levi_civita(Lagrangian_contravariants(:,inode)*Nshape(alpha),3)*levi_civita(Eulerian_covariants(:,jnode,beta)*Nshape(beta),3) + ...;
%                                           time_factor_2*levi_civita(Lagrangian_contravariants(:,inode)*Nshape(alpha),3)*levi_civita(angular_acceleration,3)*levi_civita(Eulerian_covariants(:,jnode,beta)*Nshape(beta),3))*...
%                                           (Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);
%        Mww5                =  Mww5 + rho*(-levi_civita(Lagrangian_contravariants(:,inode)*Nshape(alpha),3)*levi_civita(Eulerian_covariants(:,jnode,beta)*Nshape(beta),3) + ...
%                                            str.data.beta_alpha_method*str.data.delta_t^2*levi_civita(Lagrangian_contravariants(:,inode)*Nshape(alpha),3)*levi_civita(angular_acceleration,3)*levi_civita(Eulerian_covariants(:,jnode,beta)*Nshape(beta),3))*(Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);
%--      Mww5                 =  Mww5 - rho*(levi_civita(Lagrangian_contravariants(:,inode)*Nshape(alpha),3)*levi_civita(Lagrangian_contravariants(:,jnode)*Nshape(beta),3))*(Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
           b                    =  cross(angular_velocity,Eulerian_covariants(:,jnode,beta)*Nshape(beta));  
           Mww6                 =  Mww6 + rho*(-time_factor*levi_civita(Eulerian_covariants(:,inode,alpha)*Nshape(alpha),3)*levi_civita(b,3) + ...
                                                time_factor*levi_civita(Eulerian_covariants(:,inode,alpha)*Nshape(alpha),3)*levi_civita(angular_velocity,3)*levi_civita(Eulerian_covariants(:,jnode,beta)*Nshape(beta),3) - ...
                                                time_factor_2*levi_civita(Eulerian_covariants(:,inode,alpha)*Nshape(alpha),3)*levi_civita(angular_velocity,3)*levi_civita(angular_velocity,3)*levi_civita(Eulerian_covariants(:,jnode,beta)*Nshape(beta),3))*(Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);                                            
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--         b                    =  cross(angular_velocity,Lagrangian_contravariants(:,jnode)*Nshape(beta));  
%--         Mww6                 =  Mww6 + rho*(-time_factor*levi_civita(Lagrangian_contravariants(:,inode)*Nshape(alpha),3)*levi_civita(b,3) + ...
%--                                               time_factor*levi_civita(Lagrangian_contravariants(:,inode)*Nshape(alpha),3)*levi_civita(angular_velocity,3)*levi_civita(Lagrangian_contravariants(:,jnode)*Nshape(beta),3))*(Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);                                            
%          b                    =  cross(angular_velocity,Eulerian_covariants(:,jnode,beta)*Nshape(beta));  
%          Mww6                 =  Mww6 + rho*(-time_factor*levi_civita(Lagrangian_contravariants(:,inode)*Nshape(alpha),3)*levi_civita(b,3) + ...
%                                               time_factor*levi_civita(Lagrangian_contravariants(:,inode)*Nshape(alpha),3)*levi_civita(angular_velocity,3)*levi_civita(Eulerian_covariants(:,jnode,beta)*Nshape(beta),3) ...
%                                               -time_factor_2*levi_civita(Lagrangian_contravariants(:,inode)*Nshape(alpha),3)*levi_civita(angular_velocity,3)*levi_civita(angular_velocity,3)*levi_civita(Eulerian_covariants(:,jnode,beta)*Nshape(beta),3))*(Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);                                            
    end
end

%--------------------------------------------------------------------------
% Matrices M55 and M66 of the form Maa
%--------------------------------------------------------------------------
M55aa                        =  zeros(3);
M66aa                        =  zeros(3);

node_comparison      =  alpha-beta;
switch node_comparison
  case 0 
       for il=1:n_node_mechanical_element
           %--------------------------------------------------------------------------
           % Nodal angular velocity and accelerations in node beta
           %--------------------------------------------------------------------------
           node_il                      =  str.solid.BEAM_SHELL.discrete.mesh.connectivities(mechanical_element,il);
           initial_dof_il               =  node_il*6-2;
           final_dof_il                 =  node_il*6;
           angular_acceleration         =  str.solid.BEAM_SHELL.discrete.acceleration(initial_dof_il:final_dof_il);
           angular_velocity             =  str.solid.BEAM_SHELL.discrete.velocity(initial_dof_il:final_dof_il);
           for inode=1:3
               for jnode=1:3
                   M55aa                =  M55aa + rho*time_factor_2*levi_civita(cross(angular_acceleration,Eulerian_covariants(:,jnode,il)*Nshape(il)),3)*levi_civita(Eulerian_covariants(:,inode,alpha)*Nshape(alpha),3)*(Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);
                    b                    =  cross(angular_velocity,Eulerian_covariants(:,jnode,il)*Nshape(il));
                    a                    =  cross(angular_velocity,b);
                    M66aa                =  M66aa + rho*time_factor_2*levi_civita(a,3)*levi_civita(Eulerian_covariants(:,inode,alpha)*Nshape(alpha),3)*(Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);
%                    b                    =  cross(angular_velocity,Lagrangian_contravariants(:,jnode)*Nshape(il));
%                    a                    =  cross(angular_velocity,b);
%                    M66aa                =  M66aa + rho*time_factor_2*levi_civita(a,3)*levi_civita(Eulerian_covariants(:,inode,alpha)*Nshape(alpha),3)*(Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);
               end
           end
       end
end


Mww5                         =  Mww5 + M55aa;
Mww6                         =  Mww6 + M66aa;

Maa                          =  Maa1;
Maw                          =  0*(Maw2 + Maw3);
Mwa                          =  0*Mwa4;
Mww                          =  0*Mww4 + Mww5 + Mww6;
             