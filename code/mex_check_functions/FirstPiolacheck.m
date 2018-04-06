ngauss  =  8;
dim     =  2;

F       =  rand(dim,dim,ngauss);
H       =  rand(dim,dim,ngauss);
SigmaF  =  rand(dim,dim,ngauss);
SigmaH  =  rand(dim,dim,ngauss);
SigmaJ  =  rand(ngauss,1);

N       =  1e4;
%--------------------------------------------------------------------------
% First Piola. MatLab version
%--------------------------------------------------------------------------
Id  =  eye(dim);
Piola  =  zeros(dim,dim,ngauss);
tic
for i=1:N
for igauss=1:ngauss
    switch dim
        case 3
             Piola(:,:,igauss)  =  SigmaF(:,:,igauss) + ...
                                   JavierDoubleCrossProduct(SigmaH(:,:,igauss),F(:,:,igauss)) + ...
                                   SigmaJ(igauss)*H(:,:,igauss);
        case 2            
             Piola(:,:,igauss)  =  SigmaF(:,:,igauss) + ...
                                   Cofactor(SigmaH(:,:,igauss),2) + ...
                                   SigmaJ(igauss)*H(:,:,igauss);
            
    end
end
end
toc 
%--------------------------------------------------------------------------
% First Piola. C version
%--------------------------------------------------------------------------
tic
for i=1:N
    PiolaC   =  FirstPiolaMexC3(F,H,SigmaF,SigmaH,SigmaJ);
end
toc

