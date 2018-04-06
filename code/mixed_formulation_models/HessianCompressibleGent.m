function mat_info   =  HessianCompressibleGent(ielem,dim,ngauss,...
                                                      F,J,mat_info)

%--------------------------------------------------------------------------
% Material number identifier
%--------------------------------------------------------------------------
mat_id              =  mat_info.material_identifier(ielem);
%--------------------------------------------------------------------------
% Material parameters
%--------------------------------------------------------------------------                                                                            
mu                  =  mat_info.parameters.Gent.mu(mat_id);
Imax3               =  mat_info.parameters.Gent.Imax(mat_id) - 3;
kappa               =  mat_info.parameters.Gent.kappa(mat_id);
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
    const                                         =  1 - traceFF/Imax3;
    Fvector                                       =  reshape(F(:,:,igauss)',dim^2,1);
    mat_info.derivatives.D2U.D2UDFDF(:,:,igauss)  =  mu/const*Itensor + ...
                                                     2*mu/Imax3/const^2*(Fvector*Fvector');
    mat_info.derivatives.D2U.D2UDJDJ(igauss)      =  beta/J(igauss)^2 + kappa;
end





