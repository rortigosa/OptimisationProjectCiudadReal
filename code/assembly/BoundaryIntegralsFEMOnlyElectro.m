%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Residual and Stiffness matrices due to vaccum effect in the principle of
%  virtual work
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function str                 =  BoundaryIntegralsFEMOnlyElectro(str)

%--------------------------------------------------------------------------
% Dimension of the problem 
%--------------------------------------------------------------------------
fprintf('Begining of static assembly for boundary integrals in the principle of virtual work\n')
%--------------------------------------------------------------------------
% Dofs per element and initialisation of indexi, indexj and data
%--------------------------------------------------------------------------
[Kindexi,Kindexj,Kdata,...
Tindexi,Tindexj,Tdata]      =  SparseStiffnessPreallocationBoundaryFEM(str.geometry.dim,str.mesh,str.data.formulation);
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
tic     
for iedge=1:size(str.mesh.surface.x.boundary_edges,2)
    %----------------------------------------------------------------------
    % Residuals and stiffness matrices
    %----------------------------------------------------------------------
    element_assembly         =  ResidualStiffnessElectroBoundaryFEMOnlyElectro(iedge,str.geometry.dim,str.quadrature,str.fem,...
                                               str.mesh,str.solution,str.material_information);    
    %----------------------------------------------------------------------
    % Sparse assembly
    %----------------------------------------------------------------------
    [INDEXI,INDEXJ,DATA]     =  StiffnessSparseAssemblyBoundaryFEMOnlyElectro(iedge,str.mesh,element_assembly);
    Kindexi(:,iedge)         =  INDEXI;
    Kindexj(:,iedge)         =  INDEXJ;
    Kdata(:,iedge)           =  DATA;
    %----------------------------------------------------------------------
    % Assembly of residuals
    %----------------------------------------------------------------------
    [INDEXI,INDEXJ,DATA]     =  VectorsAssemblyBoundaryFEMOnlyElectro(iedge,str.mesh,element_assembly);
    Tindexi(:,iedge)         =  INDEXI;
    Tindexj(:,iedge)         =  INDEXJ;
    Tdata(:,iedge)           =  DATA;
end     
toc 
%--------------------------------------------------------------------------
% Sparse assembly of the stiffness matrix.      
%--------------------------------------------------------------------------
total_dofs                   =  size(str.assembly.K_total,1);
str.assembly.K_total         =  str.assembly.K_total + sparse(Kindexi(:),Kindexj(:),Kdata(:),total_dofs,total_dofs);
%--------------------------------------------------------------------------
% Sparse assembly of the residual.       
%--------------------------------------------------------------------------
str.assembly.Tinternal       =  str.assembly.Tinternal + sparse(Tindexi(:),Tindexj(:),Tdata(:),total_dofs,1);

fprintf('End of static assembly\n')

end





