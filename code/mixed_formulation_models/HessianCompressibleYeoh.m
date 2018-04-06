function mat_info   =  HessianCompressibleYeoh(ielem,dim,ngauss,...
                                                      F,J,mat_info)

%--------------------------------------------------------------------------
% Material number identifier
%--------------------------------------------------------------------------
mat_id              =  mat_info.material_identifier(ielem);
%--------------------------------------------------------------------------
% Material parameters
%--------------------------------------------------------------------------                                                                            
mu                  =  mat_info.parameters.Yeoh.mu(mat_id);
k1                  =  mat_info.parameters.Yeoh.k1(mat_id);
k2                  =  mat_info.parameters.Yeoh.k2(mat_id);
kappa               =  mat_info.parameters.Yeoh.kappa(mat_id);
beta                =  mu;
%--------------------------------------------------------------------------
% Auxiliar matrices
%--------------------------------------------------------------------------
Itensor             =  eye(dim^2);
%--------------------------------------------------------------------------
% 2D or 3D model
%--------------------------------------------------------------------------                                                                            
switch dim
    case 2
         twoDterm   =  2;
    case 3
         twoDterm   =  3;
end
%--------------------------------------------------------------------------
% Second derivatives of the model
%--------------------------------------------------------------------------                                                                            
for igauss=1:ngauss
    traceFF                                       =  trace(F(:,:,igauss)'*F(:,:,igauss)) - twoDterm;
    Fvector                                       =  reshape(F(:,:,igauss)',dim^2,1);
    
    mat_info.derivatives.D2U.D2UDFDF(:,:,igauss)  =  mu*(1 + 2*k1*traceFF + 3*k2*traceFF^2)*Itensor + ...
                                                     2*mu*(2*k1 + 6*k2*traceFF)*(Fvector*Fvector');
    mat_info.derivatives.D2U.D2UDJDJ(igauss)      =  beta/J(igauss)^2 + kappa;
end




