%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Convergence of the Newton-Raphson
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [NR,AL,...
    Residual_dimensionless,assembly]  =  ArcLengthConvergence(NR,assembly,bc,AL)
 
%--------------------------------------------------------------------------
% Initialise the dimensionless residual
%--------------------------------------------------------------------------
NR.convergence_warning                =  0;
if NR.iteration>1 
   oldResidual_dimensionless          =  assembly.Residual_stored{1}(NR.iteration-1);
else
   oldResidual_dimensionless          =  1; 
end
%--------------------------------------------------------------------------
% Store the residual
%--------------------------------------------------------------------------
if NR.iteration == 1   
    NR.convergence_factor                       =  norm(assembly.Residual(bc.Dirichlet.freedof));
    Residual_dimensionless                      =  1;
    assembly.Residual_stored{1}(NR.iteration)   =  Residual_dimensionless;
elseif NR.iteration>1
    assembly.Residual_stored{1}(NR.iteration)   =  norm(assembly.Residual(bc.Dirichlet.freedof))/NR.convergence_factor;
    Residual_dimensionless                      =  assembly.Residual_stored{1}(NR.iteration);
    if assembly.Residual_stored{1}(NR.iteration)>1e1*assembly.Residual_stored{1}(NR.iteration-1)
        NR.convergence_warning                  =  1;
        AL.fail                                 =  1;        
    end 
end  
%--------------------------------------------------------------------------
% First convergence criterion (based on the Residual)
%--------------------------------------------------------------------------
NR.nonconvergence_criteria            =  norm(assembly.Residual(bc.Dirichlet.freedof))>NR.tolerance;
if NR.nonconvergence_criteria==0
    if  NR.iteration<0 
        NR.nonconvergence_criteria    =  1;
    end
end 
%--------------------------------------------------------------------------
% Second convergence criterion (based on the scaled Residual)
%--------------------------------------------------------------------------
if NR.nonconvergence_criteria
   NR.nonconvergence_criteria         =  Residual_dimensionless>NR.tolerance && abs((oldResidual_dimensionless-Residual_dimensionless)/Residual_dimensionless)>0.00000001;
   if NR.nonconvergence_criteria==0
      if  NR.iteration<2
          NR.nonconvergence_criteria  =  1;
      end
   end 
end 
%--------------------------------------------------------------------------
% Maximum number of iterations reached.  
%--------------------------------------------------------------------------
if NR.iteration>6
   AL.fail                            =  1;
end
if NR.nonconvergence_criteria==0
   if NR.iteration<=3
      if AL.fail==0
         AL.radius                    =  AL.radius*2;    
      end
   end
end
if AL.fail==1
   NR.nonconvergence_criteria         =  1; 
end


