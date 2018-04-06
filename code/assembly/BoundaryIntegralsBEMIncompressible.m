%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Residual and Stiffness matrices due to vaccum effect in the principle of
%  virtual work
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function str                   =  BoundaryIntegralsBEMIncompressible(str)

%--------------------------------------------------------------------------
% Dimension of the problem 
%--------------------------------------------------------------------------
fprintf('Begining of static assembly for BEM integral\n')
%--------------------------------------------------------------------------
% Dofs per element and initialisation of indexi, indexj and data
%--------------------------------------------------------------------------
[Kindexi,Kindexj,Kdata,...
Tindexi,Tindexj,Tdata,...
BIKindexi,BIKindexj,BIKdata,...
BITindexi,BITindexj,BITdata]   =  SparseStiffnessPreallocationBoundaryBEM(str.geometry.dim,str.mesh,str.data.formulation);
%--------------------------------------------------------------------------
% Loop over collocation points
%--------------------------------------------------------------------------
tic     
for inode=1:str.mesh.surface.q0.n_nodes
    for iedge=1:size(str.mesh.surface.x.boundary_edges,2)
        %------------------------------------------------------------------
        % Residuals and stiffness matrices
        %------------------------------------------------------------------
        edge_assembly          =  ResidualStiffnessElectroBoundaryBEM(inode,iedge,str.geometry.dim,...
                                                                    str.mesh,str.fem,str.solution,str.quadrature);
        %------------------------------------------------------------------
        % Sparse assembly
        %------------------------------------------------------------------
        [INDEXI,INDEXJ,DATA]   =  StiffnessSparseAssemblyBoundaryBEMIncompressible(inode,str.geometry.dim,iedge,str.mesh,edge_assembly);                                                                      
        BIKindexi(:,iedge)     =  INDEXI;
        BIKindexj(:,iedge)     =  INDEXJ;
        BIKdata(:,iedge)       =  DATA;
        %------------------------------------------------------------------
        % Assembly of residuals
        %------------------------------------------------------------------
        [INDEXI,INDEXJ,DATA]   =  SparseVectorsAssemblyBoundaryBEM(inode,str.mesh,edge_assembly);
        BITindexi(:,iedge)     =  INDEXI;
        BITindexj(:,iedge)     =  INDEXJ;
        BITdata(:,iedge)       =  DATA;        
    end
    Kindexi(:,inode)           =  BIKindexi(:);
    Kindexj(:,inode)           =  BIKindexj(:);
    Kdata(:,inode)             =  BIKdata(:);
    Tindexi(:,inode)           =  BITindexi(:);
    Tindexj(:,inode)           =  BITindexj(:);
    Tdata(:,inode)             =  BITdata(:);    
end     
toc 
%--------------------------------------------------------------------------
% Sparse assembly of the stiffness matrix.      
%--------------------------------------------------------------------------
total_dofs                     =  size(str.assembly.K_total,1);
str.assembly.Tinternal         =  str.assembly.Tinternal + sparse(Tindexi,Tindexj,Tdata,total_dofs,1);
str.assembly.K_total           =  str.assembly.K_total + sparse(Kindexi,Kindexj,Kdata,total_dofs,total_dofs);

fprintf('End of static assembly\n')

end





