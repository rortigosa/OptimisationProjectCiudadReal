%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Assemblign of the resiual and stiffness matrix of the system.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function str    =  ParallelInternalWorkOnlyElectroBEMFEMAssembly(str)    
%--------------------------------------------------------------------------
% Dimension of the problem 
%--------------------------------------------------------------------------
fprintf('Begining of static assembly\n')
%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
str.assembly    =  GlobalResidualInitialisationFormulation(str.geometry,str.mesh,str.assembly,str.data.formulation);
%--------------------------------------------------------------------------
% Dofs per element and initialisation of indexi, indexj and data
%--------------------------------------------------------------------------
[Kindexi,Kindexj,Kdata,...
 Tindexi,Tindexj,Tdata]   =  SparseStiffnessPreallocation(str.geometry,str.mesh,str.data.formulation);
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
tic     
parfor ielem=1:str.mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % Residuals and stiffness matrices 
    %----------------------------------------------------------------------
    element_assembly      =  ParallelInternalWorkResidualStiffnessElectro(ielem,str.quadrature,str.solution,...
                                      str.geometry,str.mesh,str.fem,...
                                      str.vectorisation,str.material_information);    
    %----------------------------------------------------------------------
    % Sparse assembly
    %----------------------------------------------------------------------
    [INDEXI,INDEXJ,DATA]  =  StiffnessSparseAssemblyInternalWorkOnlyElectro(ielem,str.mesh,...
                                                    element_assembly);         
    Kindexi(:,ielem)      =  INDEXI;
    Kindexj(:,ielem)      =  INDEXJ;
    Kdata(:,ielem)        =  DATA;
    %----------------------------------------------------------------------
    % Assembly of residuals 
    %----------------------------------------------------------------------
    [INDEXI,INDEXJ,DATA]  =  ParallelInternalVectorsAssemblyOnlyElectro(ielem,str.mesh,element_assembly);
    Tindexi(:,ielem)      =  INDEXI;
    Tindexj(:,ielem)      =  INDEXJ;
    Tdata(:,ielem)        =  DATA;
end     
toc 
%--------------------------------------------------------------------------
% Sparse assembly of the residual.            
%--------------------------------------------------------------------------
str.assembly.Tinternal    =  sparse(Tindexi,Tindexj,Tdata);
%--------------------------------------------------------------------------
% Sparse assembly of the stiffness matrix.          
%--------------------------------------------------------------------------
if str.contact.lagrange_multiplier
   total_dofs             =  str.solution.n_dofs + size(str.solution.contact_multiplier,1);
else 
   total_dofs             =  str.solution.n_dofs;
end
str.assembly.K_total      =  sparse(Kindexi,Kindexj,Kdata,total_dofs,total_dofs);

fprintf('End of static assembly\n')

end





