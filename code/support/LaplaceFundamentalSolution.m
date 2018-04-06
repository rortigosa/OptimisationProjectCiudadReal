
function V   =  LaplaceFundamentalSolution(dim,r_norm)

switch dim
    case 2
         V  =  -1/(2*pi)*log(r_norm);
    case 3
         V  =  1/(4*pi)*(1./r_norm);
end
