%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Add to the stiffness matrix contributions from inertia, damping, internal
% work...
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function Assembly      =  StiffnessMatrixTotalAssembly(Data,Solution,Assembly,TimeIntegrator)

mec_dofs               =  size(Solution.x.Lagrangian_X(:),1);
%--------------------------------------------------------------------------
% Multiply matrices by the time integration factors.
%--------------------------------------------------------------------------
switch Data.analysis
    case 'static'
        %------------------------------------------------------------------
        % Final stiffness matrix for statics.
        %------------------------------------------------------------------
        Assembly.total_matrix            =  Assembly.K_total;
    case 'dynamic'
        switch TimeIntegrator.type
            case 'Newmark_beta'
                 Assembly.total_matrix   =  Assembly.K_total;
                 Dt                      =  TimeIntegrator.Deltat;
                 beta                    =  TimeIntegrator.beta;
                 gamma                   =  TimeIntegrator.gamma;
                 
                 Mfactor                 =  1/(beta*Dt^2);
                 Dfactor                 =  gamma/(beta*Dt);
                 Assembly.total_matrix(1:mec_dofs,...
                     1:mec_dofs)         =  Mfactor*Assembly.M_total + ...
                                            Dfactor*Assembly.Damping_total + ...
                                            Assembly.K_total(1:mec_dofs,1:mec_dofs);
        end
end
