%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function computes the volume of all the elements of the mesh
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Velem    =  ElementVolumeFunction(n_elem,IntWeight)
n_elem            =  size(n_elem,2);
Velem             =  zeros(n_elem,1);
for ielem=1:n_elem
    Velem(ielem)  =  sum(IntWeight);
end