dim  =  3;
ngauss  =  27;
SigmaF=rand(dim,dim,ngauss);
SigmaH=rand(dim,dim,ngauss);
SigmaJ=rand(ngauss,1);
F=rand(dim,dim,ngauss);
H=rand(dim,dim,ngauss);

N      =  1e4;
tic
for i=1:N
P      =  FirstPiolaUFormulationC(dim,ngauss,SigmaF,SigmaH,SigmaJ,F,H);
end
toc
tic
for i=1:N
Piola  =  FirstPiolaKirchhoffStressTensorU(ngauss,dim,F,H,SigmaF,SigmaH,SigmaJ);
end
toc


DU.SigmaF = SigmaF;
DU.SigmaH = SigmaH;
DU.SigmaJ = SigmaJ;
kin.F   =  F;
kin.H   =  H;
str.geometry.dim  =  3;
tic
for i=1:N
P      =  FirstPiolaUFormulationC(str.geometry.dim,ngauss,DU.SigmaF,DU.SigmaH,DU.SigmaJ,kin.F,kin.H);
end
toc
tic
for i=1:N
Piola  =  FirstPiolaKirchhoffStressTensorU(ngauss,str.geometry.dim,kin.F,kin.H,DU.SigmaF,DU.SigmaH,DU.SigmaJ);
end
toc

tic
for i=1:N
    dim =  str.geometry.dim;
    SigmaF  =  DU.SigmaF;
    SigmaH  =  DU.SigmaH;
    SigmaJ  =  DU.SigmaJ;
    F       =  kin.F;
    H       =  kin.H;    
P      =  FirstPiolaUFormulationC(dim,ngauss,SigmaF,SigmaH,SigmaJ,F,H);
end
toc

