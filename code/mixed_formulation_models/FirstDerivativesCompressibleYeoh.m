function mat_info      =  FirstDerivativesCompressibleYeoh(ielem,ngauss,dim,...
                                                              F,J,mat_info)
%--------------------------------------------------------------------------                                                                                        
% Material number identifier
%--------------------------------------------------------------------------                                                                                        
mat_id                 =  mat_info.material_identifier(ielem);
%--------------------------------------------------------------------------                                                                                        
% Material parameters
%--------------------------------------------------------------------------                                                                                        
mu                     =  mat_info.parameters.Yeoh.mu(mat_id);
k1                     =  mat_info.parameters.Yeoh.k1(mat_id);
k2                     =  mat_info.parameters.Yeoh.k2(mat_id);
kappa                  =  mat_info.parameters.Yeoh.kappa(mat_id);
beta                   =  mu;
%--------------------------------------------------------------------------                                                                                        
% Homogenised material parameters
%--------------------------------------------------------------------------                                                                                        
%--------------------------------------------------------------------------                                                                                        
% Difference between 2D and 3D model
%--------------------------------------------------------------------------                                                                                        
switch dim
    case 2
         twoDterm      =  2;
    case 3
        twoDterm       =  3;
end
%--------------------------------------------------------------------------                                                                                        
% First derivatives of the model  
%--------------------------------------------------------------------------                                                                                        
for igauss=1:ngauss
    traceFF            =  trace(F(:,:,igauss)'*F(:,:,igauss)) - twoDterm;

    mat_info.derivatives.DU.DUDF(:,:,...
        igauss)        =  mu*(1 + 2*k1*traceFF + 3*k2*traceFF^2)*F(:,:,igauss);
    mat_info.derivatives.DU.DUDJ(igauss,...
        1)             =  -beta/J(igauss) + kappa*(J(igauss)-1);
end


