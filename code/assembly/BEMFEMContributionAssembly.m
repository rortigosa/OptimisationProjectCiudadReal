%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assembling of the resiual and stiffness matrix of the system.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str  =  BEMFEMContributionAssembly(str)   

switch str.data.formulation
    case {'electro_mechanics_BEM_FEM','electro_mechanics_Helmholtz_BEM_FEM'}
          %----------------------------------------------------------------
          % Boundary integrals in the principle of virtual work
          %----------------------------------------------------------------
          str           =  BoundaryIntegralsFEM(str);
          %----------------------------------------------------------------
          % Boundary integrals due to the Boundary Element Method
          %----------------------------------------------------------------
          str           =  BoundaryIntegralsBEM(str);
    case {'electro_mechanics_incompressible_BEM_FEM','electro_mechanics_Helmholtz_incompressible_BEM_FEM',...
          'electro_mechanics_mixed_incompressible_BEM_FEM'}
          %----------------------------------------------------------------
          % Boundary integrals in the principle of virtual work
          %----------------------------------------------------------------
          str           =  BoundaryIntegralsFEMIncompressible(str);
          %----------------------------------------------------------------
          % Boundary integrals due to the Boundary Element Method
          %----------------------------------------------------------------
          str           =  BoundaryIntegralsBEMIncompressible(str);
    case 'electro_BEM_FEM'
          %----------------------------------------------------------------
          % Boundary integrals in the Gauss law
          %----------------------------------------------------------------
          str           =  BoundaryIntegralsFEMOnlyElectro(str);
          %----------------------------------------------------------------
          % Boundary integrals due to the Boundary Element Method
          %----------------------------------------------------------------
          str           =  BoundaryIntegralsBEMOnlyElectro(str);
end
