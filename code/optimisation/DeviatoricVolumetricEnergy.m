%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Energy of the following functional
%  
% W  =  F:F + (J-1)^2
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


function  W   =  DeviatoricVolumetricEnergy(F,H,J)

ngauss   =  size(F,3);
dim      =  size(F,1);
W        =  zeros(ngauss,1);

for igauss=1:ngauss
    WFF   =  (trace(F(:,:,igauss)'*F(:,:,igauss)) - dim)^2;
    U     =  (J(igauss)-1)^2;
    U     =  exp(-J(igauss));
    W(:,:,igauss)  =  0*WFF + U;    
end
    