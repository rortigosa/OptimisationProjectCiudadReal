function [P,Elasticity,Elasticity3D]  =  MooneyRivlinPlaneStressMatLab(dim,ngauss,mu1,mu2,lambda,F,H,J)

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Mooney Rivlin in plane stress
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
P             =  zeros(dim,dim,ngauss);
Elasticity    =  zeros(dim^2,dim^2,ngauss);
Elasticity3D  =  zeros(9,9,ngauss);  
thickness_    =  zeros(ngauss,1);
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Plane stretch
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
for igauss=1:ngauss
%/*-------------------------------------------------------------------*/
%// Newton-Raphson to compute the thickness stretch
%/*-------------------------------------------------------------------*/
    thickness_stretch  =  1.;
    FTF                =  F(:,:,igauss)'*F(:,:,igauss);
    trace_FTF          =  trace(FTF);     
    %while (residual>tolerance)
    for iter=1:4
        DWDlambda          =  (mu1 + mu2*trace_FTF)*thickness_stretch - ...
                              (mu1 + 2*mu2)/thickness_stretch + ...
                              J(igauss)*lambda*(J(igauss)*thickness_stretch - 1);
        D2WDlambda         =  (mu1 + mu2*trace_FTF) + ...
                              (mu1 + 2*mu2)/(thickness_stretch*thickness_stretch) + ...
                              J(igauss)^2*lambda;
        thickness_stretch  =  thickness_stretch - (1/D2WDlambda)*DWDlambda;
    end
    thickness_(igauss)     =  thickness_stretch;
    %end
        t2    =  thickness_stretch*thickness_stretch;
        %/*-------------------------------------------------------------------*/
        %// IDENTITY SECOND ORDER TENSOR
        %/*-------------------------------------------------------------------*/
        Imatrix  =  eye(dim);
        %/*-------------------------------------------------------------------*/
        %// COMPUTE FIRST DERIVATIVES OF THE MODEL
        %/*-------------------------------------------------------------------*/
        WF  =  (mu1 + mu2*t2)*F(:,:,igauss);
        WJ =  -(mu1 + 2*mu2)/J(igauss) + ...
             lambda*thickness_stretch*(thickness_stretch*J(igauss) - 1) + ...
             mu2*J(igauss);
        %/*-------------------------------------------------------------------*/
        %// COMPUTE FIRST PIOLA STRESS TENSOR
        %/*-------------------------------------------------------------------*/
        P(:,:,igauss)   =  WF + WJ*H(:,:,igauss);
        %P(:,:,igauss)   =  thickness_stretch*eye(dim);
        %/*-------------------------------------------------------------------*/
        %// SECOND ORDER DERIVATIVES WITH RESPECT TO F2D
        %/*-------------------------------------------------------------------*/
        I_I  =  zeros(dim,dim,dim,dim);
        I4D  =  zeros(dim,dim,dim,dim);
        I4DT =  zeros(dim,dim,dim,dim);
        for ii=1:dim
            for II=1:dim
                for jj=1:dim 
                    for JJ=1:dim
                        I_I(ii,II,jj,JJ)  =  Imatrix(ii,II)*Imatrix(jj,JJ);             
                        I4D(ii,II,jj,JJ)  =  Imatrix(ii,jj)*Imatrix(II,JJ);
                        I4DT(ii,II,jj,JJ) =  Imatrix(ii,JJ)*Imatrix(jj,II);
                    end
                end
            end
        end
        WFF  =  (mu1 + mu2*t2)*I4D;                        
        WJJ  =  (mu1 + 2*mu2)/(J(igauss)^2) + ...
                lambda*(thickness_stretch*thickness_stretch) + mu2;
        H_H  =  zeros(dim,dim,dim,dim);
        for ii=1:dim
            for II=1:dim
                for jj=1:dim
                    for JJ=1:dim
                        H_H(ii,II,jj,JJ)  =  H(ii,II,igauss)*H(jj,JJ,igauss);             
                    end
                end
            end
        end
        C_Geom  =  WJ*(I_I - I4DT);
        %/*-------------------------------------------------------------------*/
        %// CROSS DERIVATIVES WITH RESPECT TO F2D AND THICKNESS STRETCH
        %/*-------------------------------------------------------------------*/
        WFt    =  2*mu2*thickness_stretch*F(:,:,igauss);
        WJt    =  lambda*(2*thickness_stretch*J(igauss) - 1);
        DPDt   =  WFt + WJt*H(:,:,igauss);
        DPDt_DPDt  =  zeros(dim,dim,dim,dim);
        for ii=1:dim
            for II=1:dim
                for jj=1:dim
                    for JJ=1:dim
                        DPDt_DPDt(ii,II,jj,JJ)  =  -(1/D2WDlambda)*DPDt(ii,II)*DPDt(jj,JJ);             
                    end
                end
            end
        end 
        %/*-------------------------------------------------------------------*/
        %// TOTAL CONTRIBUTION IN THE ELASTICITY TENSOR
        %/*-------------------------------------------------------------------*/
        Elasticity4D  =  WFF + WJJ*H_H + C_Geom + DPDt_DPDt;
        %Elasticity4D  =  H_H;
        Elasticity(:,:,igauss)    =  reshape(Elasticity4D,dim^2,dim^2);
end


%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% 3D representation
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
F3D  =  zeros(3,3,ngauss);
H3D  =  zeros(3,3,ngauss);
J3D  =  zeros(ngauss,1);
for igauss=1:ngauss
    F3D(1:2,1:2,igauss)  =  F(:,:,igauss); 
    F3D(3,3,igauss)      =  thickness_(igauss);
    H3D(1:2,1:2,igauss)  =  thickness_(igauss)*H(:,:,igauss); 
    H3D(3,3,igauss)      =  J(igauss);
    J3D(igauss)          =  J(igauss)*thickness_(igauss); 
end

for igauss=1:ngauss
        %/*-------------------------------------------------------------------*/
        %// IDENTITY SECOND ORDER TENSOR
        %/*-------------------------------------------------------------------*/
        Imatrix  =  eye(3);
        %/*-------------------------------------------------------------------*/
        %// COMPUTE FIRST DERIVATIVES OF THE MODEL
        %/*-------------------------------------------------------------------*/
        WF  =  mu1*F3D(:,:,igauss);
        WH  =  mu1*H3D(:,:,igauss);
        WJ =  -(mu1 + 2*mu2)/J(igauss) + lambda*(J(igauss) - 1);
        %/*-------------------------------------------------------------------*/
        %// SECOND ORDER DERIVATIVES WITH RESPECT TO F2D
        %/*-------------------------------------------------------------------*/
        I_I  =  zeros(3,3,3,3);
        I4D  =  zeros(3,3,3,3);
        for ii=1:3
            for II=1:3
                for jj=1:3
                    for JJ=1:3
                        I_I(ii,II,jj,JJ)  =  Imatrix(ii,II)*Imatrix(jj,JJ);             
                        I4D(ii,II,jj,JJ)  =  Imatrix(ii,jj)*Imatrix(II,JJ);
                    end
                end
            end
        end
        WFF  =  mu1*I4D;                        
        WHH  =  mu2*I4D;
        WJJ  =  (mu1 + 2*mu2)/(J(igauss)^2) + lambda;
        
        H_H  =  zeros(dim,dim,dim,dim);
        F_WHH   =  Cross_24(F3D(:,:,igauss),WHH);
        F_WHH_F =  Cross_42(F_WHH,F3D(:,:,igauss));
        Geom    =  WH + WJ*F3D(:,:,igauss);
        C_Geom  =  Cross_42(I4D,Geom);
        for ii=1:3
            for II=1:3
                for jj=1:3
                    for JJ=1:3
                        H_H(ii,II,jj,JJ)  =  H3D(ii,II,igauss)*H3D(jj,JJ,igauss);             
                    end
                end
            end
        end 
        %/*-------------------------------------------------------------------*/
        %// TOTAL CONTRIBUTION IN THE ELASTICITY TENSOR
        %/*-------------------------------------------------------------------*/
        Elasticity4D_  =  WFF + F_WHH_F + WJJ*H_H + C_Geom;
        Elasticity3D(:,:,igauss)    =  reshape(Elasticity4D_,9,9);
end

function Tensor  =  Cross_24(Tensor2,Tensor4)
Tensor  =  zeros(3,3,3,3);
E  =  zeros(3,3,3);
E(1,2,3)  =  1;
E(3,1,2)  =  1;
E(2,3,1)  =  1;
E(2,1,3)  =  -1;
E(1,3,2)  =  -1;
E(3,2,1)  =  -1;
for ii=1:3
    for II=1:3
        for jj=1:3
            for JJ=1:3
                for pp=1:3
                    for PP=1:3
                        for qq=1:3
                            for QQ=1:3
                                Tensor(ii,II,jj,JJ)  =  Tensor(ii,II,jj,JJ) + E(ii,pp,qq)*E(II,PP,QQ)*Tensor2(pp,PP)*Tensor4(qq,QQ,jj,JJ);
                            end
                        end
                    end
                end
            end
        end
    end
end
end

function Tensor  =  Cross_42(Tensor4,Tensor2)
Tensor  =  zeros(3,3,3,3);
E  =  zeros(3,3,3);
E(1,2,3)  =  1;
E(3,1,2)  =  1;
E(2,3,1)  =  1;
E(2,1,3)  =  -1;
E(1,3,2)  =  -1;
E(3,2,1)  =  -1;
for ii=1:3
    for II=1:3
        for jj=1:3
            for JJ=1:3
                for pp=1:3
                    for PP=1:3
                        for qq=1:3
                            for QQ=1:3
                                Tensor(ii,II,jj,JJ)  =  Tensor(ii,II,jj,JJ) + E(jj,pp,qq)*E(JJ,PP,QQ)*Tensor4(ii,II,pp,PP)*Tensor2(qq,QQ);
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

