N                      =  10000;
dim                    =  3;
ngauss                 =  27;
DPsiDF                 =  randi(10,dim,dim,ngauss);
DPsiDH                 =  randi(10,dim,dim,ngauss);
DPsiDJ                 =  zeros(ngauss,1);
F                      =  randi(10,dim,dim,ngauss);
H                      =  randi(10,dim,dim,ngauss);

tic
for i=1:N
PiolaH                 =  PiolaHFunction(dim,ngauss,DPsiDH,F);  % Compute PiolaH
PiolaJ                 =  MatrixScalarMultiplication(dim,ngauss,H,DPsiDJ);
Piola                  =  DPsiDF + PiolaH + PiolaJ;
end
toc

tic
for i=1:N
PiolaH                 =  PiolaHFunction(dim,ngauss,DPsiDH,F);  % Compute PiolaH
for igauss=1:ngauss
    Piola_F            =  DPsiDF(:,:,igauss);
    Piola_J            =  DPsiDJ(igauss)*H(:,:,igauss);
    Piola(:,:,igauss)  =  Piola_F + PiolaH(:,:,igauss) + Piola_J;
end
end
toc

asdf=98