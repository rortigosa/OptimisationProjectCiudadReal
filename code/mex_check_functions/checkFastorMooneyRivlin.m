mu1 = 1.5;
mu2 = 1.5;
lambda = 10.5;
ngauss   =  8;
dim  =  2;

F  =  rand(dim,dim,ngauss);
H  =  rand(dim,dim,ngauss);
J  =  rand(ngauss,1);

N  =  5e4;
Piola  =  zeros(dim,dim,ngauss);
WFF    =  zeros(dim,dim,dim,dim,ngauss);

Itensor  =  zeros(dim,dim,dim,dim);
Id  =  eye(dim);
for ii=1:dim
    for II=1:dim
        for jj=1:dim
            for JJ=1:dim
                Itensor(ii,II,jj,JJ)  =  Id(ii,jj)*Id(II,JJ);
            end
        end
    end
end


tic
for i=1:N
for igauss=1:ngauss
    switch dim
        case 3
    Piola(:,:,igauss)  =  mu1*F(:,:,igauss) + ...
                          mu2*JavierDoubleCrossProduct(F(:,:,igauss),H(:,:,igauss)) + ...
                          (-(mu1+2*mu2)/J(igauss) + lambda*(J(igauss) - 1))*H(:,:,igauss);
        case 2
            
            SigmaH  =  mu2*H(:,:,igauss);
    Piola(:,:,igauss)  =  mu1*F(:,:,igauss) + ...
                          mu2*Cofactor(SigmaH,2) + ...
                          (-(mu1+2*mu2)/J(igauss) + lambda*(J(igauss) - 1))*H(:,:,igauss);
            
    end
    Idtensor  =  repmat(eye(dim^2),1,1,ngauss);                      
    WFFv  =  mu1*Idtensor;
    WHHv  =  mu2*Idtensor;
%     for ii=1:dim
%         for II=1:dim
%             for jj=1:dim
%                 for JJ=1:dim
% %                    WFF(ii,II,jj,JJ,igauss)  =  F(ii,jj,igauss)*H(II,JJ,igauss);                      
%                     %WFF(ii,II,jj,JJ,igauss)  =  F(ii,jj,igauss)*H(II,JJ,igauss);                      
%                     WFF(ii,II,jj,JJ,igauss)  =  mu1*Id(ii,jj)*Id(II,JJ);                      
% %                    WFF(ii,II,jj,JJ,igauss)  =  F(ii,II,igauss)*H(jj,JJ,igauss);                      
% %                    WFF(JJ,jj,II,ii,igauss)  =  H(ii,jj,igauss)*F(II,JJ,igauss);                      
%                 end
%             end
%         end
%     end
end
end
toc
 
%func = @(F,H,J) checkFastor15(F,H,J);
%func = @(mu1,mu2,lambda,F,H,J) MooneyRivlinModelMexC1(mu1,mu2,lambda,F,H,J);
tic
for i=1:N
%     [PiolaC,WFF1]  =  func(F,H,J);
%     [PiolaC,WFF2]  =  func(H,F,J);
%     [PiolaCC,WFF3]  =  func(permute(F,[2 1 3]),permute(H,[2 1 3]),J);
%     [PiolaCC,WFF4]  =  func(permute(H,[2 1 3]),permute(F,[2 1 3]),J);
    %[PiolaC,WFFC]  =  func(mu1,mu2,lambda,F,H,J);
    %[PiolaC,WFFC]   =  MooneyRivlinModelMexC1(mu1,mu2,lambda,F,H,J);
%    [PiolaC,WFFC]   =  MooneyRivlinModelMexC5(F,H,J);
    [PiolaC,WH,WJ,WFFC,WFHC,WFJC,WHHC,WHJC,WJJC]   =  MooneyRivlinModelMexC2(mu1,mu2,lambda,F,H,J);
end
toc

WFF   =  reshape(WFF(:,:,:,:,1),dim^2,dim^2);
WFF1  =  WFFC(:,:,1);

check1  =  norm(WFF(:) - WFF1(:));
