Piola_c    =  zeros(dim,dim,ngauss);
Hessian_c  =  zeros(dim,dim,dim,dim,ngauss);

Jc   =  0.8;
for igauss=1:ngauss
    WJ      =  - (mu1 + 2*mu2)/J(igauss);
    WJJ     =    (mu1 + 2*mu2)/(J(igauss)^2);
    if (J(igauss)>=Jc)
        WJ_   =  WJ;
        WJJ_  =  WJJ;
    else
        fc    =  - (mu1 + 2*mu2)*log(Jc);
        fpc   =  - (mu1 + 2*mu2)/Jc;
        fppc  =    (mu1 + 2*mu2)/Jc^2;
        a1    =  fppc/2;
        a2    =  fpc - 2*a1*Jc;
        a3    =  fc - a1*Jc^2 - a2*Jc;
        WJ_   =  2*a1*J(igauss) + a2;
        WJJ_  =  2*a1;
    end
    WJc      =  WJ_  -  WJ;
    WJJc     =  WJJ_ -  WJJ;
    Piola_c(:,:,igauss)  =  Piola(:,:,igauss) + WJc*H(:,:,igauss);
    %----------------------------------------------------------------*/
    % Corrected Hessian
    %----------------------------------------------------------------*/
    Tensor1  =  zeros(dim,dim,dim,dim);
    for ii=1:dim
        for II=1:dim
            for jj=1:dim
                for JJ=1:dim
                    Tensor1(ii,II,jj,JJ)  =  H(ii,II,igauss)*H(jj,JJ,igauss);
                end
            end
        end
    end
    Tensor2 =  WJJc*Tensor1;
    Hessian1  =  Hessian(:,:,:,:,igauss) + Tensor2;
    %----------------------------------------------------------------*/
    % Corrected (geometric) Hessian
    %----------------------------------------------------------------*/
    if (dim==2)
        FourthOrderIdentity_iIjJ  =  zeros(2,2,2,2);
        FourthOrderIdentity_iJjI  =  zeros(2,2,2,2);
        Id                        =  eye(2);
        for ii=1:2
            for II=1:2
                for jj=1:2
                    for JJ=1:2
                        FourthOrderIdentity_iIjJ(ii,II,jj,JJ)  =  Id(ii,II)*Id(jj,JJ);
                        FourthOrderIdentity_iJjI(ii,II,jj,JJ)  =  Id(ii,JJ)*Id(jj,II);
                    end
                end
            end
        end
        Tensor2  =  FourthOrderIdentity_iIjJ - FourthOrderIdentity_iJjI;
    elseif (dim==3)
        FourthOrderIdentity_ijIJ  =  zeros(3,3,3,3);
        for ii=1:3
            for II=1:3
                for jj=1:3
                    for JJ=1:3
                        FourthOrderIdentity_ijIJ(ii,II,jj,JJ)  =  Id(ii,jj)*Id(II,JJ);
                    end
                end
            end
        end
        Tensor2  =  zeros(3,3,3,3);
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
                        for p=1:3
                            for P=1:3
                                for q=1:3
                                    for Q=1:3
                                        Tensor2(ii,II,jj,JJ)  =  Tensor2(ii,II,jj,JJ) + ...
                                                                 FourthOrderIdentity_ijIJ(ii,II,p,P)*E(jj,p,q)*E(JJ,P,Q)*F(q,Q,igauss);
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    Hessian2  =  WJc*Tensor2;
    %----------------------------------------------------------------*/
    % Add material and geometrical contributions
    %----------------------------------------------------------------*/
    Hessian_c(:,:,:,:,igauss)  =  Hessian1 + Hessian2;
end