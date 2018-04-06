function str                            =  ElementResidualInitialisationFormulation(str)

switch str.data.formulation
    case 'u'
         str.assembly.element_assembly  =  ElementResidualMatricesInitialisationU(str.geometry,str.mesh);
    case 'up'
         str.assembly.element_assembly  =  ElementResidualMatricesInitialisationUP(str.geometry,str.mesh);        
    case 'FHJ'
         str.assembly.element_assembly  =  ElementResidualMatricesInitialisationFHJ(str.geometry,str.mesh);        
    case 'CGC'
         str.assembly.element_assembly  =  ElementResidualMatricesInitialisationCGC(str.geometry,str.mesh);        
    case {'electro','electro_BEM_FEM','electro_Helmholtz','electro_Helmholtz_BEM_FEM'}
         str.assembly.element_assembly  =  ElementResidualMatricesInitialisationElectro(str.geometry,str.mesh);
    case {'electro_incompressible','electro_incompressible_BEM_FEM',...
          'electro_Helmholtz_incompressible','electro_Helmholtz_incompressible_BEM_FEM'}
         str.assembly.element_assembly  =  ElementResidualMatricesInitialisationElectroIncompressible(str.geometry,str.mesh);
    case {'electro_mixed_incompressible','electro_mixed_incompressible_BEM_FEM'}        
         str.assembly.element_assembly  =  ElementResidualMatricesInitialisationElectroMixedIncompressible(str.geometry,str.mesh);
end        