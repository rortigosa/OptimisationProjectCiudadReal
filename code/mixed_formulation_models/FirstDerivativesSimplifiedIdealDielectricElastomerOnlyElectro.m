function mat_info  =  FirstDerivativesSimplifiedIdealDielectricElastomerOnlyElectro(ielem,...
                                                                                     D0,mat_info)
%--------------------------------------------------------------------------                                                                                        
% Material number identifier
%--------------------------------------------------------------------------                                                                                        
mat_id                    =  mat_info.material_identifier(ielem)                                                                                        ;
%--------------------------------------------------------------------------                                                                                        
% Material parameters
%--------------------------------------------------------------------------                                                                                        
e                         =  mat_info.material_parameters.e1(mat_id);
%--------------------------------------------------------------------------                                                                                        
% First derivatives of the model
%--------------------------------------------------------------------------                                                                                        
mat_info.derivatives.DU.DUDD0    =  (1/e)*D0;
