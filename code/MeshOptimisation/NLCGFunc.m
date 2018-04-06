%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Non-Linear Conjugate Gradient (NLCG) Method
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function [x,fval,iteration]   =  NLCGFunc(x,Func,DFuncDx,D2FuncDxDx,MaxNiter)

%--------------------------------------------------------------------------
% NLCG method
%--------------------------------------------------------------------------
iteration            =  0;
fval                 =  zeros(MaxNiter,1);
while iteration<MaxNiter
    iteration        =  iteration + 1;
    Dx               =  -DFuncDx(x);
    if norm(Dx)==0
       break;
    end
    if iteration==1
       s             =  Dx;
    else
       beta          =  BetaFunc(Dx,Dxold);
       s             =  Dx + beta*s; 
    end 
    alpha            =  LineSearch(DFuncDx,D2FuncDxDx,x,Dx);
    x                =  x + alpha*Dx;
    Dxold            =  Dx;
    fval(iteration)  =  Func(x);
end


function beta   =  BetaFunc(Dx,Dxold)
    beta        =  Dx'*(Dx - Dxold)/(Dx'*Dxold);
    if isnan(beta)
       beta     =  -1;
       beta     =  max(0,beta);
    end
end

function alpha = LineSearch(DFuncDx,D2FuncDxDx,x,Dx)
    Residual   =  1;
    Tol        =  1e-6;
    alpha      =  0; 
    b          =  x + alpha*Dx;
    while abs(Residual)>Tol
       Residual   =  DFuncDx(b)'*Dx;
       Stiffness  =  Dx'*D2FuncDxDx(b)*Dx;
       alpha      =  alpha -(1/Stiffness)*Residual;
       b          =  x + alpha*Dx;
    end
end

end