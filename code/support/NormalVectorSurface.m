

function Normal_vector   =  NormalVectorSurface(dim,DX_chi,DX_eta)
 
switch dim
    case 2
         N               =  cross([DX_chi;0],[0;0;1]);
         Normal_vector   =  N(1:2);
    case 3
         Normal_vector   =  cross(DX_chi,DX_eta);
end
Normal_vector            =  Normal_vector/norm(Normal_vector);
