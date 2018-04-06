%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the following fourth order tensor
%
%  A_{iIjJ}  =  Id_{iJ}*Id_{jI}
%
% where Id represents the second order identity tensor
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Tensor  =  FourthOrderIdentityTranspose(dim)


Tensor    =  zeros(dim^2,dim^2);
if dim==2
   Tensor([1 7 10 16]) =  1;
elseif dim==3
   Tensor([1 13 25 29 41 53 57 69 81]) =  1;    
end


