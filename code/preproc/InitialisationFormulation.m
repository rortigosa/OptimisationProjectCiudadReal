%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Initialisation of the formulation.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [Solution,NR,Assembly,...
 FEM,Quadrature,MatInfo]  =  InitialisationFormulation(Data,Geometry,FEM,Mesh,NR,Quadrature,MatInfo)

%--------------------------------------------------------------------------
% Initialisation of the fields associated with the chosen formulation
%--------------------------------------------------------------------------  
Solution          =  InitialisedFields(Geometry,Mesh,Data.formulation);
%--------------------------------------------------------------------------
% Initialisation of parameters for the Newton-Raphson algorithm
%--------------------------------------------------------------------------
NR                =  NRInitialisation(NR);
%--------------------------------------------------------------------------
% Indices for sparse assembly of the stiffness matrix and the residual
%--------------------------------------------------------------------------
Assembly          =  SparseIndicesUFormulation(Geometry.dim,Mesh);    
%--------------------------------------------------------------------------
% Get the derivatives of the shape functions with respect to X.
%--------------------------------------------------------------------------
[FEM.volume.bilinear.x,...
  Quadrature.volume.bilinear]  =  MaterialGradientShapeFunctions(Geometry,...
                                         FEM.volume.bilinear.x,Quadrature.volume.bilinear,...
                                         Solution,Mesh.volume.x);
%--------------------------------------------------------------------------
% Compute stiffness matrix of an element in the solid in the origin 
% (no deformations)
%--------------------------------------------------------------------------
[K,Elasticity]                =  ElementStiffnessSolidOrigin(FEM,Solution,Mesh,...
                                                 Quadrature,MatInfo,Geometry);
MatInfo.Klinear           =  K;
MatInfo.ElasticityLinear  =  Elasticity;
%--------------------------------------------------------------------------
% Initialisation of kinematics
%--------------------------------------------------------------------------  
% if strcmp(Data.language,'MatLab')
%    Kinematics  =  InitialisedKinematics(Quad,Geometry.dim); 
% end
%--------------------------------------------------------------------------
% Preprocessing the vectorisation of the code                                                                                                                                                                                                                                                                                                                
%--------------------------------------------------------------------------
% if strcmp(Data.language,'MatLab')
%    Vectorisation  =  VectorisationMatlabCode(dim,Quad,Mesh);
% end
%--------------------------------------------------------------------------
% Initialisation for contact problems
%--------------------------------------------------------------------------
%str           =  ContactInitialisation(str);
%--------------------------------------------------------------------------
% Element mass matrix
%--------------------------------------------------------------------------  
%str.assembly.elem_mass  =  ElementMassMatrix(str.geometry,str.mesh,str.fem,str.quadrature);
