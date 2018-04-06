%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the difference between the fields of a specific
% formulation at two different stages of the simulation
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function diff_fields  =  DiffFieldsFunction(formulation,solution,old_solution)

switch formulation
    case {'u','FHJ','CGC','CGCCascade'}
        diff_x        =  solution.x.Eulerian_x - old_solution.x.Eulerian_x;
        diff_fields   =  diff_x(:);
    case {'up'}
        diff_x        =  solution.x.Eulerian_x(:) - old_solution.x.Eulerian_x(:);
        diff_p        =  solution.pressure - old_solution.pressure;
        diff_fields   =  [diff_x(:);diff_p];
    case 'electro'
        diff_phi      =  solution.phi - old_solution.phi;
        diff_fields   =  diff_phi;
    case 'electro_BEM_FEM'
        diff_phi      =  solution.phi - old_solution.phi;
        diff_q        =  solution.q - old_solution.q;        
        diff_fields   =  [diff_phi;diff_q];
    case {'electro_mechanics','electro_mechanics_Helmholtz'}
        diff_x        =  solution.x.Eulerian_x - old_solution.x.Eulerian_x;
        diff_phi      =  solution.phi - old_solution.phi;
        diff_fields   =  [diff_x(:);diff_phi];
    case {'electro_mechanics_incompressible','electro_mechanics_mixed_incompressible','electro_mechanics_Helmholtz_incompressible'}
        diff_x        =  solution.x.Eulerian_x(:) - old_solution.x.Eulerian_x(:);
        diff_phi      =  solution.phi - old_solution.phi;
        diff_p        =  solution.pressure - old_solution.pressure;
        diff_fields   =  [diff_x(:);diff_phi;diff_p];
    case {'electro_mechanics_BEM_FEM','electro_mechanics_Helmholtz_BEM_FEM'}
        diff_x        =  solution.x.Eulerian_x - old_solution.x.Eulerian_x;
        diff_phi      =  solution.phi - old_solution.phi;
        diff_q        =  solution.q - old_solution.q;        
        diff_fields   =  [diff_x(:);diff_phi;diff_q];
    case {'electro_mechanics_incompressible_BEM_FEM','electro_mechanics_mixed_incompressible_BEM_FEM','electro_mechanics_incompressible_Helmholtz_BEM_FEM'}
        diff_x        =  solution.x.Eulerian_x - old_solution.x.Eulerian_x;
        diff_phi      =  solution.phi - old_solution.phi;
        diff_p        =  solution.pressure - old_solution.pressure;
        diff_q        =  solution.q - old_solution.q;                
        diff_fields   =  [diff_x(:);diff_phi;diff_p;diff_q];
end