%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assembly of the residuals adding viscous and internal contributions to
% the internal one
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str                         =  ResidualsTotalAssembly(str)                     

switch str.data.formulation
    case 'electro'
         Tinternal                   =  [str.assembly.Tx;str.assembly.Tphi];
    case {'electro_incompressible','electro_mixed_incompressible'}
         Tinternal                   =  [str.assembly.Tx;str.assembly.Tphi;str.assembly.Tp];        
    case 'electro_BEM_FEM'
         Tinternal                   =  [str.assembly.Tx;str.assembly.Tq0];        
    case {'electro_incompressible_BEM_FEM','electro_mixed_incompressible_BEM_FEM'}
         Tinternal                   =  [str.assembly.Tx;str.assembly.Tphi;str.assembly.Tp;str.assembly.Tq];                
end

switch str.data.analysis
    case 'static'
          str.assembly.total_force   =  Tinternal;
    case 'dynamic' 
          str.assembly.total_force   =  Tinternal;        
        switch str.time_integrator.type
            case 'alpha_method'
            case 'Newmark_beta'
                 mec_dofs            =  size(str.solution.x.Eulerian_x(:),1);
                 %---------------------------------------------------------                                          
                 % Inertial contribution
                 %---------------------------------------------------------                                          
                 acceleration        =  str.solution.x0.Eulerian_x_dot_dot(:);
                 Tinertial           =  str.assembly.M_total*acceleration;
                 %---------------------------------------------------------                                          
                 % Viscous contribution
                 %---------------------------------------------------------                                          
                 velocity            =  str.solution.x0.Eulerian_x_dot(:);
                 Tviscous            =  str.assembly.Damping_total*velocity;
                 %---------------------------------------------------------                                          
                 % Total contribution
                 %---------------------------------------------------------                                          
                 str.assembly.total_force(1:mec_dofs,...
                 1)                  =  Tinertial + Tviscous + str.assembly.total_force(1:mec_dofs);
        end
end
