

function ObjFun      =  ObjectiveFunctionGlobalDisplacement(str)    
%--------------------------------------------------------------------------
% Extract from the structures 
%--------------------------------------------------------------------------

x                    =  str.solution.x.Eulerian_x;
X                    =  str.solution.x.Lagrangian_X;
connectivity         =  str.mesh.volume.x.connectivity;
NShape               =  str.fem.volume.bilinear.x.N;
IntWeight            =  str.quadrature.volume.bilinear.IntWeight;
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
ObjFun            =  0;
for ielem=1:str.mesh.volume.n_elem  
    u_elem        =  x(:,connectivity(:,ielem)) - X(:,connectivity(:,ielem));              
    uGauss        =  FEMVectorInterpolationMexC(u_elem,NShape);
    ObjFun        =  ObjFun + ObjectiveFunctionGlobalDisplacementv2MexC(uGauss,IntWeight);
end




