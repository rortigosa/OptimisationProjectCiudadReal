%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assembly of the residual and stiffness matrix of the system.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function T       =  AdjointProblemGlobalDisplacement(str)    

%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
str.assembly       =  GlobalResidualInitialisationFormulation(str.geometry,str.mesh,str.assembly,str.data.formulation);
%--------------------------------------------------------------------------
% Dofs per element and initialisation of indexi, indexj and data
%--------------------------------------------------------------------------
[Kdata,Tdata]      =  SparseStiffnessPreallocationv2(str.geometry,str.mesh,str.data.formulation);
%--------------------------------------------------------------------------
% Extract from the structures
%--------------------------------------------------------------------------
x                  =  str.solution.x.Eulerian_x;
X                  =  str.solution.x.Lagrangian_X;
connectivity       =  str.mesh.volume.x.connectivity;
NShape             =  str.fem.volume.bilinear.x.N;
IntWeight          =  str.quadrature.volume.bilinear.IntWeight;
for ielem=1:str.mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % Displacements in nodes and Gauss points of the element
    %----------------------------------------------------------------------
    u_elem          =  x(:,connectivity(:,ielem)) - X(:,connectivity(:,ielem));              
    uGauss          =  FEMVectorInterpolationMexC(u_elem,NShape);
    Tdata(:,ielem)  =  LinearisationGlobalDisplacementsv2MexC(NShape,uGauss,IntWeight);    
end     
T     =  sparse(str.sparse.Tindexi,str.sparse.Tindexj,Tdata,str.solution.n_dofs,1);

end





