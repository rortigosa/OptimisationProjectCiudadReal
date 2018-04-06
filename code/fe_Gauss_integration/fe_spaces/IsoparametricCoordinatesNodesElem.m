%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Coordinates of the nodes of an element in the isoparametric domain
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function iso_coordinates   =  IsoparametricCoordinatesNodesElem(shape,degree,dim)
switch shape
    case 1
         iso_coordinates   =  IsoparametricCoordinatesQuadsHexas(degree,dim);
    case 0
         iso_coordinates   =  IsoparametricCoordinatesTrisTets(degree,dim);
end
