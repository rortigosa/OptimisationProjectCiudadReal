%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the fourth order tensor II:
%
%  II_{iIjJ}  =  Id_{iI}*Id_{jJ}, where Id is the second order identity
%  tensor
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function Itensor  =  FourthOrderIdentityTensorOuter(dim)

Itensor        =  zeros(dim^2,dim^2);
if dim==2
    Itensor([1 4 13 16 ]) = 1;
elseif dim==3
    Itensor([1 5 9 37 41 45 73 77 81]) =  1;
end


