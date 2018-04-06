%--------------------------------------------------------------------------
%--------------------------------------------------------------------------%
%   This function computes the first Piola-Kirchhoff stress tensor 
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function   Piola         =  FirstPiolaKirchhoffStressTensorElectroHelmholtz(ngauss,dim,F,H,DPsiDF,DPsiDH,DPsiDJ)

PiolaH                   =  PiolaHFunction(dim,ngauss,DPsiDH,F); 
PiolaJ                   =  MatrixScalarMultiplication(dim,dim,ngauss,H,DPsiDJ);
Piola                    =  DPsiDF + PiolaH + PiolaJ;



