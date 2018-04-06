
function dVdx                =  DiffLaplaceFundamentalSolution(dim,r,r_norm)

n_gauss                      =  size(r,2);
dVdx                         =  zeros(size(r,1),n_gauss,1);
switch dim
    case 2
         for igauss=1:n_gauss
             dVdx(:,igauss)  =  1/(2*pi)*r(:,igauss)/r_norm(igauss)^2;
         end
    case 3
         for igauss=1:n_gauss
             dVdx(:,igauss)  =  1/(4*pi)*(r(:,igauss)/r_norm(igauss)^3);
         end
end
