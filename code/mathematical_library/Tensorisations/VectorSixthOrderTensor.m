dim  =  3;
syms phia_1 phia_2 phia_3 phib_1 phib_2 phib_3
syms DNXa_1 DNXa_2 DNXa_3 DNXb_1 DNXb_2 DNXb_3 DNXc_1 DNXc_2 DNXc_3
syms aux

if dim==2
   phia  =  [phia_1; phia_2]; 
   phib  =  [phib_1; phib_2]; 
   DNXa  =  [DNXa_1; DNXa_2];
   DNXb  =  [DNXb_1; DNXb_2];
   DNXc  =  [DNXc_1; DNXc_2];
else
   phia  =  [phia_1; phia_2; phia_3]; 
   phib  =  [phib_1; phib_2; phib_3]; 
   DNXa  =  [DNXa_1; DNXa_2; DNXa_3];
   DNXb  =  [DNXb_1; DNXb_2; DNXb_3];    
   DNXc  =  [DNXc_1; DNXc_2; DNXc_3];    
end

A   =  sym('A%d', [dim^6 1]);
A   =  reshape(A,dim,dim,dim,dim,dim,dim);

R =  aux*zeros(dim,1);

for p=1:dim
    for P=1:dim
        for J=1:dim
            for j=1:dim
                for I=1:dim
                    for i=1:dim
                        R(p)  =  R(p) + A(i,I,j,J,p,P)*phia(i)*DNXa(I)*phib(j)*DNXb(J)*DNXc(P);                        
                    end
                end
            end
        end
    end
end

AA  =  reshape(A,dim*dim*dim*dim,dim*dim);
phiDNphiDN  =  zeros(dim,dim,dim,dim)*aux;
for J=1:dim
    for j=1:dim
        for I=1:dim
            for i=1:dim
                phiDNphiDN(i,I,j,J)  =  phia(i)*DNXa(I)*phib(j)*DNXb(J);             
            end
        end
    end
end
phiDNphiDN  =  reshape(phiDNphiDN,[],1);

Tensor  =  transpose(phiDNphiDN)*AA;
Tensor  =  reshape(Tensor,dim,dim);


R_  =  aux*zeros(dim,1);
for i=1:dim
    for j=1:dim
        R_(i)  =  R_(i) + Tensor(i,j)*DNXc(j);     
    end
end



asdf=98



