%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Piola associated with the following energy functional:
%  
% W  =  F:F + (J-1)^2
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


function  Piola   =  DerivativeDeviatoricVolumetricEnergy(F,H,J)

ngauss   =  size(F,3);
dim      =  size(F,1);
Piola    =  zeros(dim,dim,ngauss);

for igauss=1:ngauss
    WF   =  4*(trace(F(:,:,igauss)'*F(:,:,igauss)) - 3)*F(:,:,igauss);
    WJ   =  2*(J(igauss)-1);
    WJ   =  -exp(-J(igauss));
    
    Piola(:,:,igauss)  =  0*WF + WJ*H(:,:,igauss);    
end
    