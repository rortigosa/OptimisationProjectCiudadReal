%--------------------------------------------------------------------------
% This function proves that deltaF:(F - Fx) results in deltaF'*(F - Fx) = 0
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Input
%--------------------------------------------------------------------------
str         =  [];
orderx      =  1;
orderF      =  1;
str         =  GaussQuadrature(str,max(orderx,orderF),2);
W           =  str.quadrature.W_v;
Nx          =  ShapeFunctionComputation(1,orderx,2,str.quadrature);
NF          =  ShapeFunctionComputation(1,orderF,2,str.quadrature);
Nnodex      =  size(Nx,1);
NnodeF      =  size(NF,1);
ngauss      =  size(W,1);
%--------------------------------------------------------------------------
% Initialisastion
%--------------------------------------------------------------------------
M           =  zeros(4*NnodeF);
R           =  zeros(4*NnodeF,1);
%--------------------------------------------------------------------------
% Mass matrix
%--------------------------------------------------------------------------
for anode=1:NnodeF
    for bnode=1:NnodeF
        adof              =  4*anode-3:4*anode;
        bdof              =  4*bnode-3:4*bnode;
        for igauss=1:ngauss
            M(adof,bdof)  =  M(adof,bdof) + NF(anode,igauss)*NF(bnode,igauss)*eye(4,4)*W(igauss);
        end
    end
end
%--------------------------------------------------------------------------
% Interpolate Fx
%--------------------------------------------------------------------------
Fx                    =  zeros(4,ngauss);
Fxv                   =  rand(4,Nnodex);
for igauss=1:ngauss
    for anode=1:Nnodex
        Fx(:,igauss)  =   Fx(:,igauss) + Nx(anode,igauss)*Fxv(:,anode);
    end
end
%--------------------------------------------------------------------------
% Compute residual
%--------------------------------------------------------------------------
for anode=1:NnodeF
    adof              =  4*anode-3:4*anode;
    for igauss=1:ngauss
        R(adof)       =  R(adof) + NF(anode,igauss)*Fx(:,igauss)*W(igauss);
    end
end
%--------------------------------------------------------------------------
% Solve for F
%--------------------------------------------------------------------------
Fv                    =  M\R;
Fv                    =  reshape(Fv,4,[]);
%--------------------------------------------------------------------------
% Interpolate SigmaF and F
%--------------------------------------------------------------------------
F                     =  zeros(4,ngauss);
SigmaF                =  zeros(4,ngauss);
SigmaFv               =  rand(4,NnodeF);
for igauss=1:ngauss
    for anode=1:NnodeF
        SigmaF(:,igauss)  =   SigmaF(:,igauss) + NF(anode,igauss)*SigmaFv(:,anode);
        F(:,igauss)       =   F(:,igauss)      + NF(anode,igauss)*Fv(:,anode);
    end
end
%--------------------------------------------------------------------------
% check
%--------------------------------------------------------------------------
check1              =  zeros(4,4);
check2              =  0;
for igauss=1:ngauss
    check1          =  check1 + (SigmaF(:,igauss)'*(Fx(:,igauss) - F(:,igauss)))*W(igauss);
    check2          =  check2 + trace(SigmaF(:,igauss)'*(Fx(:,igauss) - F(:,igauss)))*W(igauss);
end



v   =  zeros(12,1);
for i=1:12
    v(i)  =  sum(M(i,:));
end



