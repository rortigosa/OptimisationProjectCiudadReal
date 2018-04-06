%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assembly of the residuals adding viscous and internal contributions to
% the internal one
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Assembly                =  ParallelResidualsTotalAssembly(analysis,Assembly,Solution,TimeIntegrator)                     


switch analysis
    case 'static'
          Assembly.total_force   =  Assembly.Tinternal;
    case 'dynamic' 
          Assembly.total_force   =  Assembly.Tinternal;        
        switch TimeIntegrator.type
            case 'alpha_method'
            case 'Newmark_beta'
                 mec_dofs            =  size(Solution.x.Eulerian_x(:),1);
                 %---------------------------------------------------------                                          
                 % Inertial contribution
                 %---------------------------------------------------------                                          
                 acceleration        =  Solution.x0.Eulerian_x_dot_dot(:);
                 Tinertial           =  Assembly.M_total*acceleration;
                 %---------------------------------------------------------                                          
                 % Viscous contribution
                 %---------------------------------------------------------                                          
                 velocity            =  Solution.x0.Eulerian_x_dot(:);
                 Tviscous            =  Assembly.Damping_total*velocity;
                 %---------------------------------------------------------                                          
                 % Total contribution
                 %---------------------------------------------------------                                          
                 Assembly.total_force(1:mec_dofs,...
                 1)                  =  Tinertial + Tviscous + Assembly.total_force(1:mec_dofs);
        end
end
