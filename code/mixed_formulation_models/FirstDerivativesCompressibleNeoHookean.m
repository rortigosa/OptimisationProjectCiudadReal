function mat_info             =  FirstDerivativesCompressibleNeoHookean(ielem,dim,...
                                                              F,J,mat_info)
%--------------------------------------------------------------------------                                                                                        
% Material number identifier
%--------------------------------------------------------------------------                                                                                        
mat_id                        =  mat_info.material_identifier(ielem);
%--------------------------------------------------------------------------                                                                                        
% Material parameters
%--------------------------------------------------------------------------                                                                                        
mu                            =  mat_info.parameters.NHookean.mu(mat_id);
kappa                         =  mat_info.parameters.NHookean.kappa(mat_id);
%--------------------------------------------------------------------------                                                                                        
% First derivatives of the model  
%--------------------------------------------------------------------------                                                                                        
mat_info.derivatives.DU.DUDF  =  mu*F;
mat_info.derivatives.DU.DUDJ  =  -mu./J + kappa*(J-1);



