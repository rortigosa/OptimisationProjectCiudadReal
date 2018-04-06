function mat_info             =  FirstDerivativesCompressibleMooneyRivlin(ielem,dim,...
                                                              F,H,J,mat_info)
%--------------------------------------------------------------------------                                                                                        
% Material number identifier
%--------------------------------------------------------------------------                                                                                        
mat_id                        =  mat_info.material_identifier(ielem);
%--------------------------------------------------------------------------                                                                                        
% Material parameters
%--------------------------------------------------------------------------                                                                                        
mu1                           =  mat_info.parameters.MRivlin.mu1(mat_id);
mu2                           =  mat_info.parameters.MRivlin.mu2(mat_id);
kappa                         =  mat_info.parameters.MRivlin.kappa(mat_id);
%--------------------------------------------------------------------------                                                                                        
% term for 2D for the Jacobian due to the conversion of the invariant in H
% from 3 to 2D
%--------------------------------------------------------------------------                                                                                        
switch dim
    case 2
         twoD_Jterm           =  mu2*J;
    case 3
         twoD_Jterm           =  0;
end
%--------------------------------------------------------------------------                                                                                        
% First derivatives of the model  
%--------------------------------------------------------------------------                                                                                        
mat_info.derivatives.DU.DUDF  =  mu1*F;
mat_info.derivatives.DU.DUDH  =  mu2*H;
mat_info.derivatives.DU.DUDJ  =  -(mu1 + 2*mu2)./J + kappa*(J-1) + twoD_Jterm;



