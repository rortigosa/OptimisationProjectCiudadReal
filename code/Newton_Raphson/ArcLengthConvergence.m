%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Convergence of the Newton-Raphson
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [NR,AL,Residual_dimensionless,...
    assembly,stopping_condition]  =  ArcLengthConvergence(NR,old_NR,assembly,bc,AL)
 

stopping_condition  =  1;
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
    %if assembly.Residual_stored{1}(NR.iteration)>1e4*assembly.Residual_stored{1}(NR.iteration-1)
    if assembly.Residual_stored{1}(NR.iteration)>1e3
        NR.convergence_warning                  =  1;
        AL.fail                                 =  1;        
    end 
end   
%--------------------------------------------------------------------------
% First convergence criterion (based on the Residual)
%--------------------------------------------------------------------------
NR.nonconvergence_criteria            =  norm(assembly.Residual(bc.Dirichlet.freedof))/norm(bc.Neumann.force_vector)>NR.tolerance;
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
if NR.iteration>AL.max_number_AL_iterations
   AL.fail                            =  1;
end
if NR.nonconvergence_criteria==0
   if NR.iteration<=3
%      if AL.fail==0  && AL.radius<0.5
      if AL.fail==0
         AL.radius                    =  AL.radius*2;    
      end
   end
end

if NR.nonconvergence_criteria==0
   %-----------------------------------------------------------------------
   % If the accumulated foactor reaches 1, then stop it
   %-----------------------------------------------------------------------
   if (NR.accumulated_factor-1)>0 && (NR.accumulated_factor-1)<=(AL.max_accumulated_factor-1)
      AL.fail            =  0; 
      stopping_condition = 0; % Stop the arc-length
   %-----------------------------------------------------------------------
   % Obtain a good estimate of the critical load
   %-----------------------------------------------------------------------
   else
      if AL.iteration>10  &&  AL.critical_load_estimation
         if (NR.accumulated_factor-old_NR.accumulated_factor)<AL.min_diff_accumulated_factor && abs(NR.accumulated_factor - old_NR.accumulated_factor)<abs(1-AL.max_accumulated_factor)
            stopping_condition  =  0;
            AL.fail             =  1;
         end
      end
   end
end

if AL.fail==1
   NR.nonconvergence_criteria         =  1; 
end