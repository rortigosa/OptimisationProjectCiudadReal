%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Sparse assembly for each of the formulations of the code
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [INDEXI,INDEXJ,DATA]   =  StiffnessSparseAssemblyInternalWork(ielement,dim,mesh,element_assembly,formulation)

switch formulation 
    case {'electro','electro_BEM_FEM'}       
         [INDEXI,INDEXJ,DATA]   =  StiffnessSparseAssemblyInternalWorkElectro(ielement,dim,mesh,...
                                                                                   element_assembly);   
    case {'electro_incompressible','electro_mixed_incompressible',...
          'electro_incompressible_BEM_FEM','electro_mixed_incompressible_BEM_FEM'}
         [INDEXI,INDEXJ,DATA]   =  StiffnessSparseAssemblyInternalWorkElectroIncompressible(ielement,dim,mesh,...
                                                                                   element_assembly);         
end
                                                            
                                                            