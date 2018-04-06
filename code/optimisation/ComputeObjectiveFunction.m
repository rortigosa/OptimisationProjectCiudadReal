%-------------------------------------------------------------------------
%-------------------------------------------------------------------------
%
% This function computes the derivative of the objective function with
% respect to density
%
%-------------------------------------------------------------------------
%-------------------------------------------------------------------------

function ObjFunc    =  ComputeObjectiveFunction(Optimisation,FEM,Bc,...
                                                  Quadrature,Mesh,Solution,MatInfo)

                                              
if strcmp(Optimisation.ObjFunction,'Compliance')
   %-----------------------------------------------------------------------
   % Objective function for nodal force location compliance
   %-----------------------------------------------------------------------    
   u         =  Solution.x.Eulerian_x - Solution.x.Lagrangian_X;
   ObjFunc   =  Bc.Neumann.force_vector'*u(:);
elseif strcmp(Optimisation.ObjFunction,'Stability')
   ObjFunc   =  EigenvaluePenaltyBasedObjectiveFunction(Optimisation,Solution,Mesh,MatInfo,Quadrature,FEM);
    
elseif strcmp(Optimisation.ObjFunction,'StrainEnergy')
   %-----------------------------------------------------------------------
   % Objective function for elastic energy optimsiation
   %-----------------------------------------------------------------------
   ObjFunc   =  ObjectiveFunctionEnergy(Optimisation,FEM,Quadrature,Mesh,Solution,MatInfo);       
end



