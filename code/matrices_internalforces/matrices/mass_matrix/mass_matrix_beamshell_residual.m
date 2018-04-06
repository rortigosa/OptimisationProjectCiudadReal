%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  The intertial residuals in beams can be written as:
%  
%  Rintertial  = [Maa Maw][a0  ]   +  [Ta   ]
%              = [Mwa Mww][wdot]   +  [Twdot]
%
% We compute the mass matrix associated to this residual, which due to the
% nonlinearity involved, does not coincide with its linearisation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Maa,Maw,Mwa,Mww]   =  mass_matrix_beamshell_residual(alpha,beta,str)

rho                          =  str.data.Rho;
Nshape                       =  str.temp.mec_Nshape;
R                            =  str.temp.R;
Eulerian_covariants          =  str.temp.nodal_Eulerian_covariants;
Lagrangian_contravariants    =  str.temp.Lagrangian_contravariants;


Maa                          =  rho*Nshape(alpha)*Nshape(beta);
Maw                          =  zeros(3,3);
Mwa                          =  zeros(3,3);
Mww                          =  zeros(3,3);
for inode=1:3
    Maw                      =  Maw + 0*rho*Nshape(alpha)*levi_civita(Eulerian_covariants(:,inode,beta)*Nshape(beta),3)*(Lagrangian_contravariants(:,inode)'*R);
    Mwa                      =  Mwa - 0*rho*levi_civita(Eulerian_covariants(:,inode,alpha)*Nshape(alpha),3)*Nshape(beta)*(Lagrangian_contravariants(:,inode)'*R);
end

for inode=1:3
    for jnode=1:3
        %--------------------------------------------------------------------------
        %--------------------------------------------------------------------------
        %--------------------------------------------------------------------------        
        Mww                  =  Mww - rho*(levi_civita(Eulerian_covariants(:,inode,alpha)*Nshape(alpha),3)*levi_civita(Eulerian_covariants(:,jnode,beta)*Nshape(beta),3))*(Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);        
        %--------------------------------------------------------------------------
        %--------------------------------------------------------------------------
        %--------------------------------------------------------------------------
       %Mww                  =  Mww - rho*(levi_civita(Lagrangian_contravariants(:,inode)*Nshape(alpha),3)*levi_civita(Eulerian_covariants(:,jnode,beta)*Nshape(beta),3))*(Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);        
        %--Mww                  =  Mww - rho*(levi_civita(Lagrangian_contravariants(:,inode)*Nshape(alpha),3)*levi_civita(Lagrangian_contravariants(:,jnode)*Nshape(beta),3))*(Lagrangian_contravariants(:,inode)'*R)*(Lagrangian_contravariants(:,jnode)'*R);        
    end
end

