%--------------------------------------------------------------------------
%--------------------------------------------------------------------------%
%   This function computes the first Piola-Kirchhoff stress tensor 
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function   Piola       =  FirstPiolaKirchhoffStressTensorUC(Piola,ngauss,dim,F,H,DUDF,DUDH,DUDJ)

PiolaH                 =  zeros(dim,dim);
SigmaH                 =  zeros(dim,dim);
Fg                     =  zeros(dim,dim);
for igauss=1:ngauss
   %-----------------------------------------------------------------------    
   % Variables per Gauss pointg
   %-----------------------------------------------------------------------    
   SigmaH              =  DUDH(:,:,igauss);
   Fg                  =  F(:,:,igauss);
   %-----------------------------------------------------------------------    
   % Piola contribution associated with H
   %-----------------------------------------------------------------------    
    switch dim
        case 2
            PiolaH     =  trace(DUDH(:,:,igauss))*eye(2) - DUDH(:,:,igauss)';
        case 3
            PiolaH     =  [[SigmaH(2,2)*Fg(3,3) - SigmaH(2,3)*Fg(3,2) - SigmaH(3,2)*Fg(2,3) + SigmaH(3,3)*Fg(2,2)        SigmaH(2,3)*Fg(3,1) - SigmaH(2,1)*Fg(3,3) - SigmaH(3,3)*Fg(2,1) + SigmaH(3,1)*Fg(2,3)     SigmaH(2,1)*Fg(3,2) - SigmaH(2,2)*Fg(3,1) - SigmaH(3,1)*Fg(2,2) + SigmaH(3,2)*Fg(2,1)];...
                           [SigmaH(3,2)*Fg(1,3) - SigmaH(3,3)*Fg(1,2) - SigmaH(1,2)*Fg(3,3) + SigmaH(1,3)*Fg(3,2)        SigmaH(3,3)*Fg(1,1) - SigmaH(3,1)*Fg(1,3) - SigmaH(1,3)*Fg(3,1) + SigmaH(1,1)*Fg(3,3)     SigmaH(3,1)*Fg(1,2) - SigmaH(3,2)*Fg(1,1) - SigmaH(1,1)*Fg(3,2) + SigmaH(1,2)*Fg(3,1)];...
                           [SigmaH(1,2)*Fg(2,3) - SigmaH(1,3)*Fg(2,2) - SigmaH(2,2)*Fg(1,3) + SigmaH(2,3)*Fg(1,2)        SigmaH(1,3)*Fg(2,1) - SigmaH(1,1)*Fg(2,3) - SigmaH(2,3)*Fg(1,1) + SigmaH(2,1)*Fg(1,3)     SigmaH(1,1)*Fg(2,2) - SigmaH(1,2)*Fg(2,1) - SigmaH(2,1)*Fg(1,2) + SigmaH(2,2)*Fg(1,1)]];
    end
    Piola(:,:,igauss)  =  DUDF(:,:,igauss) + PiolaH + DUDJ(igauss)*H(:,:,igauss);
end