%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Assemblign of the resiual and stiffness matrix of the system.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function str                 =  InternalWorkElectroIncompressibleAssembly(str)    
%--------------------------------------------------------------------------
% Dimension of the problem 
%--------------------------------------------------------------------------
fprintf('Begining of static assembly\n')

%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
str.assembly                 =  GlobalResidualInitialisationFormulation(str.geometry,str.mesh,str.assembly,str.data.formulation);
%--------------------------------------------------------------------------
% Dofs per element and initialisation of indexi, indexj and data
%--------------------------------------------------------------------------
[indexi,indexj,data,...
    n_dofs_elem]             =  SparseStiffnessPreallocation(str.geometry,str.mesh,str.data.formulation);
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
tic     
for ielement=1:str.mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % Residuals and stiffness matrices 
    %----------------------------------------------------------------------
    str                      =  InternalWorkResidualStiffnessElectroIncompressible(ielement,str);
    %----------------------------------------------------------------------
    % Sparse assembly
    %----------------------------------------------------------------------
    [INDEXI,INDEXJ,DATA]     =  StiffnessSparseAssemblyInternalWorkElectroIncompressible(ielement,str.geometry.dim,str.mesh,...
                                                                                   str.assembly.element_assembly);         
    
   initial                  =  n_dofs_elem*(ielement-1) +  1;
   final                    =  n_dofs_elem*ielement;
    indexi(initial:final,1)  =  INDEXI;
    indexj(initial:final,1)  =  INDEXJ;
    data(initial:final,1)    =  DATA;
%     indexi(:,ielement)  =  INDEXI;
%     indexj(:,ielement)  =  INDEXJ;
%     data(:,ielement)    =  DATA;
    %----------------------------------------------------------------------
    % Assembly of residuals
    %----------------------------------------------------------------------
    str.assembly             =  InternalVectorsAssemblyElectroIncompressible(ielement,str.geometry.dim,str.mesh,str.assembly);
end     
toc 
%--------------------------------------------------------------------------
% Sparse assembly of the stiffness matrix.       
%--------------------------------------------------------------------------
if str.contact.lagrange_multiplier
   total_dofs                =  str.solution.n_dofs + size(str.solution.contact_multiplier,1);
else 
   total_dofs                =  str.solution.n_dofs;
end
str.assembly.K_total         =  sparse(indexi,indexj,data,total_dofs,total_dofs);

fprintf('End of static assembly\n')

end





