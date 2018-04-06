function  str   =  InternalWorkAssemblyFormulation(str)

switch str.data.formulation
    case {'electro','electro_BEM_FEM'}
         str    =  InternalWorkElectroIncompressibleAssembly(str);
    case {'electro_incompressible','electro_incompressible_BEM_FEM'}
         str    =  InternalWorkElectroIncompressibleAssembly(str);
    case {'electro_mixed_incompressible','electro_mixed_incompressible_BEM_FEM'}        

