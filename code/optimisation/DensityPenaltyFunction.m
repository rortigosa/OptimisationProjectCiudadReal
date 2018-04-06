%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function increases the objective function by penalising it for
%  densities which are not 1 or 0
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function [density_penalty,derivative_penalty]  =  DensityPenaltyFunction(str,Iteration)

if Iteration > 2000
% %    %-----------------------------------------------------------------------
% %    % Element volume
% %    %-----------------------------------------------------------------------
% % %   Volume                          =  str.fem.volume.bilinear.x.DX_chi_Jacobian(1)*(2^str.geometry.dim);
   %-----------------------------------------------------------------------
   % Penalty term for low and high densities
   %-----------------------------------------------------------------------
%    inf_density_penalty             =  str.mat_info.optimisation.inf_density_penalty/2*(str.mat_info.optimisation.rho - 0).^2;
%    sup_density_penalty             =  str.mat_info.optimisation.sup_density_penalty/2*(str.mat_info.optimisation.rho - 1).^2;
%    %-----------------------------------------------------------------------
%    % Choose minimum of  them
%    %-----------------------------------------------------------------------
%    [density_penalty,I]             =  min([inf_density_penalty sup_density_penalty],[],2);
% %   density_penalty                 =  sum(density_penalty*Volume);
%    density_penalty                 =  sum(density_penalty);
%    %-----------------------------------------------------------------------
%    % Derivative of the penalty term for low and high densitiesn 
%    %-----------------------------------------------------------------------
%    inf_derivative_penalty          =  str.mat_info.optimisation.inf_density_penalty*(str.mat_info.optimisation.rho - 0);
%    sup_derivative_penalty          =  str.mat_info.optimisation.sup_density_penalty*(str.mat_info.optimisation.rho - 1);
%    derivative                      =  [inf_derivative_penalty  sup_derivative_penalty];
%    derivative_penalty              =  zeros(size(derivative,1),1);
%    for iloop=1:size(derivative,1)
% %       derivative_penalty(iloop)   =  derivative(iloop,I(iloop))*Volume;
%        derivative_penalty(iloop)   =  derivative(iloop,I(iloop));
%    end 
%---quadratic (concave) function of value 0 at rho=0 and rho=1;
%     alpha1  =  4*str.mat_info.optimisation.inf_density_penalty;
%     alpha2  =  -alpha1; 
%     density_penalty = alpha1*str.mat_info.optimisation.rho + alpha2*str.mat_info.optimisation.rho.^2;
%     density_penalty  =  sum(density_penalty);
%     derivative_penalty  =  alpha1 + alpha2*str.mat_info.optimisation.rho;
%---linear (concave) function penalising;
    critical_rho                           =  0.4;
    rho                                    =  str.mat_info.optimisation.rho;
    kappa                                  =  str.mat_info.optimisation.inf_density_penalty;
    slope1                                 =  kappa/critical_rho;
    slope2                                 =  -kappa/(1 - critical_rho);
    density_penalty                        =  zeros(length(rho),1);
    derivative_penalty                     =  zeros(length(rho),1);
    density_penalty(rho<=critical_rho)     =  slope1*rho(rho<=critical_rho);
    density_penalty(rho>critical_rho)      =  slope2*(rho(rho>critical_rho) - 1);
    density_penalty                        =  sum(density_penalty)/str.mesh.volume.n_elem;
    derivative_penalty(rho<=critical_rho)  =  slope1/str.mesh.volume.n_elem;  
    derivative_penalty(rho>critical_rho)   =  slope2/str.mesh.volume.n_elem;  
    
    
else
   density_penalty                 =  0;
   derivative_penalty              =  0;
end