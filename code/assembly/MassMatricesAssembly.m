%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assemblign of the resiual and stiffness matrix of the system.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Assembly            =  MassMatricesAssembly(Mesh,Geometry,Solution,Quadrature,FEM,MatInfo,Assembly)    

%--------------------------------------------------------------------------
% Dimension of the problem 
%--------------------------------------------------------------------------
fprintf('Begining of mass matrices assembly\n')
%--------------------------------------------------------------------------
% Dofs per element and initialisation of indexi, indexj and data
%--------------------------------------------------------------------------
n_dofs_elem_x0               =  Mesh.volume.x.n_node_elem*Geometry.dim;

n_dofs_elem                  =  n_dofs_elem_x0^2;
n_dofs                       =  n_dofs_elem*Mesh.volume.n_elem;
indexi                       =  zeros(n_dofs,1);
indexj                       =  zeros(n_dofs,1);
data                         =  zeros(n_dofs,1);
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
Mass                         =  MassMatricesComputation(Geometry.dim,Mesh,Quadrature,FEM,MatInfo);
for ielement=1:Mesh.volume.n_elem 
    %----------------------------------------------------------------------
    % Sparse assembly
    %----------------------------------------------------------------------
    [INDEXI,INDEXJ,DATA]     =  MassSparseAssembly(ielement,Geometry.dim,Mesh,Mass);
    
    initial                  =  n_dofs_elem*(ielement-1) + 1;
    final                    =  n_dofs_elem*(ielement);
    indexi(initial:final,1)  =  INDEXI;
    indexj(initial:final,1)  =  INDEXJ;
    data(initial:final,1)    =  DATA;
end   
%--------------------------------------------------------------------------
% Sparse assembly of the stiffness matrix.      
%--------------------------------------------------------------------------
Assembly.MassMatrix          =  sparse(indexi,indexj,data);

fprintf('End of mass matrices assembly\n')

end





