%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assembly of the residual and stiffness matrix of the system.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Assembly      =  SparseIndicesUFormulation(dim,Mesh)    

%--------------------------------------------------------------------------
% Dofs per element and initialisation of indexi, indexj and data
%--------------------------------------------------------------------------
n_dofs_elem_x          =  dim*size(Mesh.volume.x.connectivity,1);
total_dofs             =  n_dofs_elem_x;

n_dofs_Kxx             =  n_dofs_elem_x*n_dofs_elem_x;
n_dofs_elem            =  n_dofs_Kxx;

Kindexi                =  zeros(n_dofs_elem,Mesh.volume.n_elem);
Kindexj                =  zeros(n_dofs_elem,Mesh.volume.n_elem);
Tindexi                =  zeros(total_dofs,Mesh.volume.n_elem);
Tindexj                =  zeros(total_dofs,Mesh.volume.n_elem);

for ielem=1:Mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % Assembly of residuals  
    %----------------------------------------------------------------------
    [INDEXI,INDEXJ]    =  SparseIndicesStiffnessMatrix(ielem,dim,Mesh);         
    Kindexi(:,ielem)   =  INDEXI;
    Kindexj(:,ielem)   =  INDEXJ;
    %----------------------------------------------------------------------
    % Assembly of residuals  
    %----------------------------------------------------------------------
    [INDEXI,INDEXJ]    =  SparseIndicesResiduals(ielem,dim,Mesh);
    Tindexi(:,ielem)   =  INDEXI;
    Tindexj(:,ielem)   =  INDEXJ; 
end

Assembly.sparse.Kindexi     =  Kindexi(:);
Assembly.sparse.Kindexj     =  Kindexj(:);
Assembly.sparse.Tindexi     =  Tindexi(:);
Assembly.sparse.Tindexj     =  Tindexj(:);


