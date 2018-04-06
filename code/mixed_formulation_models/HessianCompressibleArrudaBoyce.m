function mat_info   =  HessianCompressibleArrudaBoyce(ielem,dim,ngauss,...
                                                      F,J,mat_info)

%--------------------------------------------------------------------------
% Material number identifier
%--------------------------------------------------------------------------
mat_id              =  mat_info.material_identifier(ielem);
%--------------------------------------------------------------------------
% Material parameters
%--------------------------------------------------------------------------                                                                            
mu                  =  mat_info.parameters.ABoyce.mu(mat_id);
m                   =  mat_info.parameters.ABoyce.m(mat_id);
kappa               =  mat_info.parameters.ABoyce.kappa(mat_id);
beta                =  mu*(1 + 6*m/10 + 297*m^2/525);
%--------------------------------------------------------------------------
% Auxiliar matrices
%--------------------------------------------------------------------------
Itensor             =  eye(dim^2);
%--------------------------------------------------------------------------
% 2D or 3D model
%--------------------------------------------------------------------------                                                                            
switch dim
    case 2
         twoDterm   =  1;
    case 3
         twoDterm   =  0;
end
%--------------------------------------------------------------------------
% Second derivatives of the model
%--------------------------------------------------------------------------                                                                            
ngauss                                            =  size(F,3);
for igauss=1:ngauss
    traceFF                                       =  trace(F(:,:,igauss)'*F(:,:,igauss)) + twoDterm;
    Fvector                                       =  reshape(F(:,:,igauss)',dim^2,1);
    mat_info.derivatives.D2U.D2UDFDF(:,:,igauss)  =  mu*(1 + 2*m/10*traceFF + 33*m^2/525*traceFF^2)*Itensor + ...
                                                     2*mu*(2*m/10 + 66*m^2/525*traceFF)*(Fvector*Fvector');
    mat_info.derivatives.D2U.D2UDJDJ(igauss)      =  beta/J(igauss)^2 + kappa;
end


