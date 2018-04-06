%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Solvers.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function  str          =  Solver(str)

switch str.data.analysis
    case 'static'
        str            =  StaticSolver(str);
    case 'dynamic'
        switch  str.time_integrator.type
            case 'Newmark_beta'
                str    =  ImplicitAlphaMethodSolver(str);
        end
end
