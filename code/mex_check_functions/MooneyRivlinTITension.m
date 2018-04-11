function [PMatLab,HMatLab]  =  MooneyRivlinTITension(dim,ngauss,mu1,mu2,muani,lambda,F,H,J,N0)

PMatLab    =  zeros(dim,dim,ngauss);  
HMatLab    =  zeros(dim^2,dim^2,ngauss);
Imatrix    =  eye(dim);
%/*----------------------------------------------------------------------*/
%// COMPUTE FIRST DERIVATIVES OF THE MODEL
%/*----------------------------------------------------------------------*/
if dim==2
%--------------------------------
% 2D
%--------------------------------
for igauss=1:ngauss
    N0N0       =  N0(:,igauss)*N0(:,igauss)';
    FN0N0      =  F(:,:,igauss)*N0N0;
    FN0N0FT    =  FN0N0*F(:,:,igauss)';
    invariant  =  trace(FN0N0FT) - 1;
    traction   =  1;
    if (invariant<=0.)
        invariant  =  0;
        traction   =  0;
    end
    WF  =  (mu1 + mu2)*F(:,:,igauss) + muani*invariant*FN0N0;
    WJ =  -(mu1 + 2*mu2)/J(igauss) + mu2*J(igauss) + lambda*(J(igauss) - 1);
    %/*------------------------------------------------------------------*/
    %// COMPUTE FIRST PIOLA STRESS TENSOR
    %/*------------------------------------------------------------------*/
    PMatLab(:,:,igauss)   =  WF + WJ*H(:,:,igauss);
    
    I_I          =  outer_iIjJ(Imatrix,Imatrix,dim);
    I4D          =  outer_ijIJ(Imatrix,Imatrix,dim);
    I4_N0N0      =  outer_ijIJ(Imatrix,N0N0,dim);
    I4DT         =  outer_iJjI(Imatrix,Imatrix,dim);    
    FN0N0_FN0N0  =  outer_iIjJ(FN0N0,FN0N0,dim);
    
    WFF          =  (mu1 + mu2)*I4D + muani*invariant*I4_N0N0 + 2*muani*traction*FN0N0_FN0N0;
    WJJ          =  (mu1 + mu2)/(J(igauss)^2) + mu2 + lambda;    
    H_H          =  outer_iIjJ(H(:,:,igauss),H(:,:,igauss),dim);        
    C_Geom       =  WJ*(I_I - I4DT); 
    HMatLab_     =  WFF + WJJ*H_H + C_Geom;    
    
    HMatLab(:,:,igauss)  =  reshape(HMatLab_,dim^2,dim^2);
end
%--------------------------------
% 3D
%--------------------------------
elseif dim==3
for igauss=1:ngauss
    N0N0       =  N0(:,igauss)*N0(:,igauss)';
    FN0N0      =  F(:,:,igauss)*N0N0;
    FN0N0FT    =  FN0N0*F(:,:,igauss)';
    invariant  =  trace(FN0N0FT) - 1;
    traction   =  1;
    if (invariant<=0.)
        invariant  =  0;
        traction   =  0;
    end
    WF  =  mu1*F(:,:,igauss) + muani*invariant*FN0N0;
    WH  =  mu2*H(:,:,igauss);
    WJ =  -(mu1 + 2*mu2)/J(igauss) + lambda*(J(igauss) - 1);
    %/*------------------------------------------------------------------*/
    %// COMPUTE FIRST PIOLA STRESS TENSOR
    %/*------------------------------------------------------------------*/
    PMatLab(:,:,igauss)   =  WF + cross(WH,F(:,:,igauss))  + WJ*H(:,:,igauss);
    
    I4D          =  outer_ijIJ(Imatrix,Imatrix,dim);
    I4_N0N0      =  outer_ijIJ(Imatrix,N0N0,dim);
    FN0N0_FN0N0  =  outer_iIjJ(FN0N0,FN0N0,dim);
    
    WFF          =  mu1*I4D + muani*invariant*I4_N0N0 + 2*muani*traction*FN0N0_FN0N0;
    WHH          =  mu2*I4D;
    WHH_F        =  Cross_42(WHH,F(:,:,igauss));
    F_WHH_F      =  Cross_24(F(:,:,igauss),WHH_F);
    WJJ          =  (mu1 + 2*mu2)/(J(igauss)^2) + lambda;    
    H_H          =  outer_iIjJ(H(:,:,igauss),H(:,:,igauss),dim);        
    Geom         =  WH + WJ*F(:,:,igauss);
    C_Geom       =  Cross_42(I4D,Geom); 
    HMatLab_     =  WFF + F_WHH_F + WJJ*H_H + C_Geom;    
    %HMatLab_     =  F_WHH_F;    
    
    HMatLab(:,:,igauss)  =  reshape(HMatLab_,dim^2,dim^2);
end    
end


function E   =  LeviCivita
   E         =  zeros(3,3,3);
   E(1,2,3)  =  1;
   E(3,1,2)  =  1;
   E(2,3,1)  =  1;
   E(2,1,3)  =  -1;
   E(1,3,2)  =  -1;
   E(3,2,1)  =  -1;   
end

function Out  =  cross(A,B)
    Out  =  zeros(3,3);
    LeviCivita_  =  LeviCivita;
    for ii=1:3
        for II=1:3
            for pp=1:3
                for PP=1:3
                    for qq=1:3
                        for QQ=1:3
                            Out(ii,II)  =  LeviCivita_(ii,pp,qq)*LeviCivita_(II,PP,QQ)*A(pp,PP)*B(qq,QQ);     
                        end
                    end
                end
            end
        end
    end
end

function Out  =  outer_ijIJ(A,B,dim)
Out  =  zeros(dim,dim,dim,dim);
for ii=1:dim
    for II=1:dim
        for jj=1:dim
            for JJ=1:dim
                Out(ii,II,jj,JJ)  =  A(ii,jj)*B(II,JJ);                  
            end
        end
    end
end
end

function Out  =  outer_iIjJ(A,B,dim)
Out  =  zeros(dim,dim,dim,dim);
for ii=1:dim
    for II=1:dim
        for jj=1:dim
            for JJ=1:dim
                Out(ii,II,jj,JJ)  =  A(ii,II)*B(jj,JJ);                  
            end
        end
    end
end
end

function Out  =  outer_iJjI(A,B,dim)
Out  =  zeros(dim,dim,dim,dim);
for ii=1:dim
    for II=1:dim
        for jj=1:dim
            for JJ=1:dim
                Out(ii,II,jj,JJ)  =  A(ii,JJ)*B(jj,II);                  
            end
        end
    end
end
end

function Tensor  =  Cross_42(Tensor4,Tensor2)
Tensor  =  zeros(3,3,3,3);
LeviCivita_  =  LeviCivita;
for ii=1:3
    for II=1:3
        for jj=1:3
            for JJ=1:3
                for pp=1:3
                    for PP=1:3
                        for qq=1:3
                            for QQ=1:3
                                Tensor(ii,II,jj,JJ)  =  Tensor(ii,II,jj,JJ) + LeviCivita_(jj,pp,qq)*LeviCivita_(JJ,PP,QQ)*Tensor4(ii,II,pp,PP)*Tensor2(qq,QQ);
                            end
                        end
                    end
                end
            end
        end
    end
end
end

function Tensor  =  Cross_24(Tensor2,Tensor4)
Tensor  =  zeros(3,3,3,3);
LeviCivita_  =  LeviCivita;
for ii=1:3
    for II=1:3
        for jj=1:3
            for JJ=1:3
                for pp=1:3
                    for PP=1:3
                        for qq=1:3
                            for QQ=1:3
                                Tensor(ii,II,jj,JJ)  =  Tensor(ii,II,jj,JJ) + LeviCivita_(ii,pp,qq)*LeviCivita_(II,PP,QQ)*Tensor2(pp,PP)*Tensor4(qq,QQ,jj,JJ);
                            end
                        end
                    end
                end
            end
        end
    end
end

end

end
