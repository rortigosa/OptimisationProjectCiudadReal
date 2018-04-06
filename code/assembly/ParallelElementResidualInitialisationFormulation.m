function global_residuals               =  ParallelElementResidualInitialisationFormulation(str)

switch str.data.formulation
    case {'electro','electro_BEM_FEM'}
         global_residuals               =  struct('Tx',[],'Tphi',[],'Tp',[]);
    case {'electro_incompressible','electro_incompressible_BEM_FEM'}
         global_residuals               =  struct('Tx',[],'Tphi',[],'Tp',[]);
    case {'electro_mixed_incompressible','electro_mixed_incompressible_BEM_FEM'}        
         str.assembly.element_assembly  =  ElementResidualMatricesInitialisationElectroMixedIncompressible(str.geometry,str.mesh);
         global_residuals               =  struct('Tx',[],'Tphi',[],'Tp',[]);
end        