%--------------------------------------------------------------------------
%--------------------------------------------------------------------------%
%   This function computes the first Piola-Kirchhoff stress tensor 
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function   Piola         =  FirstPiolaKirchhoffStressTensorElectroIncompressible(ngauss,dim,F,H,DUDF,DUDH,DUDJ,DUDd,D0,pressure)

Piola                    =  zeros(dim,dim,ngauss);
for igauss=1:ngauss
    Piola_F              =  DUDF(:,:,igauss);
    Piola_H              =  JavierDoubleCrossProduct(DUDH(:,:,igauss),F(:,:,igauss));
    Piola_J              =  DUDJ(igauss)*H(:,:,igauss);
    Piola_d              =  DUDd(:,igauss)*D0(:,igauss)';
    Piola_p              =  pressure(igauss)*H(:,:,igauss);
    Piola(:,:,igauss)    =  Piola_F + Piola_H + Piola_J + Piola_d + Piola_p;
end