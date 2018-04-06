%--------------------------------------------------------------------------
%--------------------------------------------------------------------------%
%   This function computes the first Piola-Kirchhoff stress tensor 
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function   Piola        =  FirstPiolaKirchhoffStressTensorU(ngauss,dim,F,H,DUDF,DUDH,DUDJ)

PiolaH                   =  PiolaHFunction(dim,ngauss,DUDH,F); 
PiolaJ                   =  MatrixScalarMultiplication(dim,dim,ngauss,H,DUDJ);
Piola                    =  DUDF + PiolaH + PiolaJ;
