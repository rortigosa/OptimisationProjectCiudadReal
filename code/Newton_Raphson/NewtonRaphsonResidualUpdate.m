%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function updates the forces and matrices for the next Newton Raphson 
% iteration.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Assembly     =  NewtonRaphsonResidualUpdate(dim,Data,Mesh,...
                             UserDefinedFuncs,Bc,Assembly,NR,TimeIntegrator)

%--------------------------------------------------------------------------
% Compute Neumann forces/electric charges
%--------------------------------------------------------------------------
Bc                    =  NeumannBcs(dim,Data.formulation,Mesh,UserDefinedFuncs,Bc);
%--------------------------------------------------------------------------
% Initialise the residual
%--------------------------------------------------------------------------
Assembly.Residual     =  Assembly.total_force;
dofs                      =  (1:size(Bc.Neumann.force_vector,1))';        
%--------------------------------------------------------------------------
% Compute the residual for static or dynamic simulations
%--------------------------------------------------------------------------
switch TimeIntegrator.type
    case 'Static'
        Assembly.Residual(dofs,...
            1)            =  Assembly.total_force(dofs) -  ...
                             Bc.Neumann.force_vector*NR.accumulated_factor;
%      case 'generalised_alpha'
%          Assembly.Residual(dofs,...
%                      1)   =  Assembly.total_force(dofs,1) -...
%                              ((1-TimeIntegrator.alpha)*Bc.Neumann.force_vector + ...
%                              TimeIntegrator.alpha*Bc.Neumann.force_vector);
    case {'ExplicitNewmarkBeta','CentralDifference'}
          Assembly.Residual(dofs,...
                    1)    =  Assembly.total_force(dofs) -  Bc.Neumann.force_vector;                
end


