function mat_info      =  FirstDerivativesCompressibleGent(ielem,ngauss,dim,...
                                                              F,J,mat_info)
%--------------------------------------------------------------------------                                                                                        
% Material number identifier
%--------------------------------------------------------------------------                                                                                        
mat_id                 =  mat_info.material_identifier(ielem);
%--------------------------------------------------------------------------                                                                                        
% Material parameters
%--------------------------------------------------------------------------                                                                                        
mu                     =  mat_info.parameters.Gent.mu(mat_id);
Imax3                  =  mat_info.parameters.Gent.Imax(mat_id) - 3;
kappa                  =  mat_info.parameters.Gent.kappa(mat_id);
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
        igauss)        =  mu/(1- traceFF/Imax3)*F(:,:,igauss);
    mat_info.derivatives.DU.DUDJ(igauss,...
        1)             =  -beta/J(igauss) + kappa*(J(igauss)-1);
end


