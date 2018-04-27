%--------------------------------------------------------------------------
%  This function implements the arc-length method to obtain the load
%  factor. 
%--------------------------------------------------------------------------
function  [uR,AL,NR,...
    solution]          =  ArcLengthRootFindingV2(AL,NR,uR,uF,solution)

AL.fail                =  0;
%--------------------------------------------------------------------------
% Initialisation.
%--------------------------------------------------------------------------
uRdx                   =  0;
dxdx                   =  0;
%--------------------------------------------------------------------------
% First obtains all the dot products required.
%--------------------------------------------------------------------------
uFuF                   =  uF'*uF;
uRuR                   =  uR'*uR;
uFuR                   =  uF'*uR;
%--------------------------------------------------------------------------
% For the first iteration set up  
% (current Uf)X(last incr. total incremental uR.)
% then zero total incremental uR. ready for current increment.
%--------------------------------------------------------------------------
uFdx                   =  uF'*solution.x.xincr;
if NR.iteration==1
   solution.x.xincr    =  0;
   %----------------------------------------------------------------------
   % a 'patch' because K(inverse)*residual should not be
   % included in the update on the 1st. increment.
   %----------------------------------------------------------------------
   uR                  =  0*uR;
else
   uRdx                =  uR'*solution.x.xincr;
   dxdx                =  solution.x.xincr'*solution.x.xincr;
end
%--------------------------------------------------------------------------
% Set up arcln for first increment, first iteration.
%--------------------------------------------------------------------------
% if AL.iteration*NR.iteration==1
%     AL.radius          =  sqrt(uRuR);   
% end 
%--------------------------------------------------------------------------
% Finding first iteration gamma and the sign of gamma.
%--------------------------------------------------------------------------
if (NR.iteration==1) 
   gamma = abs(AL.radius)/sqrt(uFuF);
   if uFdx==0
   else
      gamma            =  gamma*sign(uFdx);
   end
  else
     %---------------------------------------------------------------------
     % Solves quadratic equation.
     %---------------------------------------------------------------------
     a1                =  uFuF;
     a2                =  2*(uFdx+uFuR);
     a3                =  dxdx + 2*uRdx + uRuR - AL.radius*AL.radius;
     discr             =  a2^2 - 4*a1*a3;
     if (discr<0)
        AL.fail        =  1;
        return
     end
     discr             =  sqrt(discr);
     if (a2<0) 
        discr          =  -discr;
     end
     discr             =  -(a2+discr)/2;
     gamm1             =  discr/a1;
     gamm2             =  a3/discr;
     %---------------------------------------------------------------------
     % Determines which of the two solutions is better.
     % using Crisfields generalised cosine check.
     %---------------------------------------------------------------------
     gamma             =  gamm1;
     cos1              =  uRdx+gamm1*uFdx;
     cos2              =  uRdx+gamm2*uFdx;
     if(cos2>cos1) 
         gamma         =  gamm2;
     end
end
%--------------------------------------------------------------------------
% Updates the uRacements and the accumulated uRacements.
%--------------------------------------------------------------------------
uR                     =  uR + gamma*uF;
solution.x.xincr       =  solution.x.xincr + uR;
%--------------------------------------------------------------------------
% Updates the values of the increment of lambda and lambda.
%--------------------------------------------------------------------------
%CON.dlamb = CON.dlamb+gamma;
NR.accumulated_factor  =  NR.accumulated_factor + gamma;
%--------------------------------------------------------------------------
% Check infinite numbers for xlamb (additional failure criterion).
%--------------------------------------------------------------------------
if isnan(NR.accumulated_factor)
   AL.fail             =  1; 
end
%--------------------------------------------------------------------------
% Stop also the arc-length when the acuumulated factor is larger than 1.
%--------------------------------------------------------------------------
if isfield(AL,'max_accumulated_factor')
   if NR.accumulated_factor>AL.max_accumulated_factor
      AL.fail          =  1; 
   end
end    
