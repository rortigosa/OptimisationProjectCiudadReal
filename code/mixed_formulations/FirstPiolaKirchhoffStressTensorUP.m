%--------------------------------------------------------------------------
%--------------------------------------------------------------------------%
%   This function computes the first Piola-Kirchhoff stress tensor 
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function   Piola   =  FirstPiolaKirchhoffStressTensorUP(ngauss,dim,F,H,DUDF,DUDH,DUDJ,pressure)

PiolaH             =  PiolaHFunction(dim,ngauss,DUDH,F); 
PiolaJ             =  MatrixScalarMultiplication(dim,dim,ngauss,H,DUDJ);
Piolap             =  MatrixScalarMultiplication(dim,dim,ngauss,H,pressure);
Piola              =  DUDF + PiolaH + PiolaJ + Piolap;
