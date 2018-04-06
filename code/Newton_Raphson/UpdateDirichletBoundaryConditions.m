%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function updates the constrained variables for the next load
% increment.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function  Solution     =   UpdateDirichletBoundaryConditions(formulation,Solution,Bc,NR)

%--------------------------------------------------------------------------
% Update Dirichlet boundary conditions
%--------------------------------------------------------------------------
switch formulation
    case {'u','up','FHJ','CGC','CGCCascade','electro_mechanics','electro_mechanics_incompressible','electro_mechanics_mixed_incompressible',...
          'electro_mechanics_BEM_FEM','electro_mechanics_incompressible_BEM_FEM','electro_mechanics_mixed_incompressible_BEM_FEM',...
          'electro_mechanics_Helmholtz','electro_mechanics_Helmholtz_BEM_FEM',...
          'electro_mechanics_Helmholtz_incompressible','electro_mechanics_Helmholtz_incompressible_BEM_FEM'}
Solution.x.Eulerian_x(Bc.Dirichlet.x.fixdof)   =  Solution.x.Eulerian_x(Bc.Dirichlet.x.fixdof) + NR.load_factor*Bc.Dirichlet.x.cons_val;
end
switch formulation
    case {'electro_mechanics','electro_mechanics_incompressible','electro_mechanics_mixed_incompressible',...
          'electro_mechanics_BEM_FEM','electro_mechanics_incompressible_BEM_FEM','electro_mechanics_mixed_incompressible_BEM_FEM',...
          'electro_mechanics_Helmholtz','electro_mechanics_Helmholtz_BEM_FEM',...
          'electro_mechanics_Helmholtz_incompressible','electro_mechanics_Helmholtz_incompressible_BEM_FEM',...
          'electro_BEM_FEM','electro'}
Solution.phi(Bc.Dirichlet.phi.fixdof)          =  NR.accumulated_factor*Bc.Dirichlet.phi.cons_val;
end      
      
      