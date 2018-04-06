%-------------------------------------------------------------------------
%-------------------------------------------------------------------------
%
% This function computes the derivative of the objective function with
% respect to density
%
%-------------------------------------------------------------------------
%-------------------------------------------------------------------------

function DIDrho    =  ComputeDerivativeObjectiveFunction(p,Mesh,Optimisation,Solution,MatInfo,Geometry,NR,FEM,Quadrature,ObjFunc0,TimeIntegrator)


if Solution.instability==1
   NR.nonlinearity  =  'linearised_convexified';
end

switch TimeIntegrator.type
    %----------------------------------------------------------------------
    % Static cases
    %----------------------------------------------------------------------
    case 'Static'
%--------------------------------------------------------------------------
% Compute derivative of the objective function for the equilibrium part
%--------------------------------------------------------------------------
if strcmp(NR.nonlinearity,'linear')
    %----------------------------------------------------------------------
    % Linear elasticity 
    %----------------------------------------------------------------------
    DIDrho      =  DerivativeObjectiveFunctionLinearElasticityMexFiles(p,...
                              Mesh,Optimisation,Solution,MatInfo,Geometry);                    
elseif strcmp(NR.nonlinearity,'nonlinear')
    %----------------------------------------------------------------------
    % Stable solutions
    %----------------------------------------------------------------------
    DIDrho =  DerivativeObjectiveFunctionMexFiles(p,Mesh,Optimisation,...
                                 Solution,Geometry,FEM,Quadrature,MatInfo);    
elseif strcmp(NR.nonlinearity,'linearised_convexified')
    DIDrho   =  DerivativeObjectiveFunctionNonlinearConvexifiedMexFiles(p,...
                            Mesh,Optimisation,Solution,MatInfo,Geometry,...
                            FEM,Quadrature);    
end
    %----------------------------------------------------------------------
    % Central difference time integrator
    %----------------------------------------------------------------------
    case 'CentralDifference'
         DIDrho  =  DerivativeObjectiveFunctionCentralDifference(p,...
                            Mesh,Optimisation,Solution,MatInfo,Geometry,...
                            FEM,Quadrature);    
        
end        



%--------------------------------------------------------------------------
% Optmisation specific-type objective function contribution into the
% derivative 
%--------------------------------------------------------------------------
if strcmp(Optimisation.ObjFunction,'Compliance')
elseif strcmp(Optimisation.ObjFunction,'Stability')
     DIDrho_    =  EigenvaluePenaltyBasedDerivative(Optimisation,Solution,Mesh,MatInfo,Quadrature,FEM)/ObjFunc0;
     DIDrho     =  DIDrho + DIDrho_;
elseif strcmp(Optimisation.ObjFunction,'StrainEnergy')
   if strcmp(NR.nonlinearity,'linear')
      DIDrho_   =  DerivativeObjectiveFunctionEnergyLinearElasticityMexFiles(Mesh,...
                                            Optimisation,Solution,MatInfo);
   else
      DIDrho_   =  DerivativeObjectiveFunctionEnergyMexFiles(Mesh,...
                             Optimisation,Solution,MatInfo,FEM,Quadrature);
   end
   DIDrho          =  DIDrho_ + DIDrho;
      
end
    
    