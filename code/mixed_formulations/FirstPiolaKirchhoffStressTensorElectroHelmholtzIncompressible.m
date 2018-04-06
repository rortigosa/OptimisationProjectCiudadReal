%--------------------------------------------------------------------------
%--------------------------------------------------------------------------%
%   This function computes the first Piola-Kirchhoff stress tensor 
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function   Piola         =  FirstPiolaKirchhoffStressTensorElectroHelmholtzIncompressible(ngauss,dim,F,H,DPsiDF,DPsiDH,DPsiDJ,pressure)

PiolaH                   =  PiolaHFunction(dim,ngauss,DPsiDH,F); 
PiolaJ                   =  MatrixScalarMultiplication(dim,dim,ngauss,H,DPsiDJ);
Piolap                   =  MatrixScalarMultiplication(dim,dim,ngauss,H,pressure);
Piola                    =  DPsiDF + PiolaH + PiolaJ + Piolap;
