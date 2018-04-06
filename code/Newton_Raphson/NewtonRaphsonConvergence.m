%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Convergence of the Newton-Raphson
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [NR,...
    Residual_dimensionless,assembly]  =  NewtonRaphsonConvergence(NR,assembly,bc)
 
%--------------------------------------------------------------------------
% Initialise the dimensionless residual
%--------------------------------------------------------------------------
NR.convergence_warning                =  'desactivated';
if NR.iteration>1 
   oldResidual_dimensionless          =  assembly.Residual_stored{NR.incr_load}(NR.iteration-1);
else
   oldResidual_dimensionless          =  1; 
end
%--------------------------------------------------------------------------
% Store the residual
%--------------------------------------------------------------------------
if NR.iteration == 1   
    NR.convergence_factor                                  =  norm(assembly.Residual(bc.Dirichlet.freedof));
    Residual_dimensionless                                 =  1;
    assembly.Residual_stored{NR.incr_load}(NR.iteration)   =  Residual_dimensionless;
elseif NR.iteration>1
    assembly.Residual_stored{NR.incr_load}(NR.iteration)   =  norm(assembly.Residual(bc.Dirichlet.freedof))/NR.convergence_factor;
    Residual_dimensionless                                 =  assembly.Residual_stored{NR.incr_load}(NR.iteration);
    if assembly.Residual_stored{NR.incr_load}(NR.iteration)>1e3*assembly.Residual_stored{NR.incr_load}(NR.iteration-1)
%        NR.load_factor                                     =  NR.load_factor/2;
%        NR.accumulated_factor                               =  NR.accumulated_factor - NR.load_factor;
%        NR.load_factor                                     =  NR.load_factor;
    %    NR.incr_load                                       =  NR.incr_load - 1;
        NR.convergence_warning                             =  1;
        fprintf('the load factor is too large. reduction of the load increment will be performed\n')
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
% Third convergence criterion (based on the variation of the Residual)
%--------------------------------------------------------------------------
if NR.nonconvergence_criteria
   if NR.iteration>4
      residual_variation              =  abs(assembly.Residual_stored{NR.incr_load}(NR.iteration)-...
                                                             assembly.Residual_stored{NR.incr_load}(NR.iteration-1));
      residual_variation              =  residual_variation/assembly.Residual_stored{NR.incr_load}(NR.iteration-1)*1e2;                    
      if residual_variation < 1e-3
         NR.nonconvergence_criteria   =  0; 
      end
   end 
end         
%--------------------------------------------------------------------------
% Fourth convergence criterion (based on the variation of the Residual)
%--------------------------------------------------------------------------
if NR.nonconvergence_criteria
   if NR.iteration>1
      if Residual_dimensionless>1e2
        NR.convergence_warning      =  1;
      end
   end 
end         
%--------------------------------------------------------------------------
% Maximum number of iterations reached.  
%--------------------------------------------------------------------------
if NR.iteration>40
   NR.nonconvergence_criteria         =  0;
end
    