function mat_info      =  FirstDerivativesCompressibleArrudaBoyce(ielem,ngauss,dim,...
                                                              F,J,mat_info)
%--------------------------------------------------------------------------                                                                                        
% Material number identifier
%--------------------------------------------------------------------------                                                                                        
mat_id                 =  mat_info.material_identifier(ielem);
%--------------------------------------------------------------------------                                                                                        
% Material parameters
%--------------------------------------------------------------------------                                                                                        
mu                     =  mat_info.parameters.ABoyce.mu(mat_id);
m                      =  mat_info.parameters.ABoyce.m(mat_id);
kappa                  =  mat_info.parameters.ABoyce.kappa(mat_id);
beta                   =  mu*(1 + 6*m/10 + 297*m^2/525);
%--------------------------------------------------------------------------                                                                                        
% Difference between 2D and 3D model
%--------------------------------------------------------------------------                                                                                        
switch dim
    case 2
         twoDterm      =  1;
    case 3
        twoDterm       =  0;
end
%--------------------------------------------------------------------------                                                                                        
% First derivatives of the model  
%--------------------------------------------------------------------------                                                                                        
for igauss=1:ngauss
    traceFF            =  trace(F(:,:,igauss)'*F(:,:,igauss)) + twoDterm;
    mat_info.derivatives.DU.DUDF(:,:,...
        igauss)        =  mu*(1 + 2*m/10*traceFF + 33*m^2/525*traceFF^2)*F(:,:,igauss);
    mat_info.derivatives.DU.DUDJ(igauss,...
        1)             =  -beta/J(igauss) + kappa*(J(igauss)-1);
end


    