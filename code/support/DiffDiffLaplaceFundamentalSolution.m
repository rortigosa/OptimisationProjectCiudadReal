function d2Vdxdx                =  DiffDiffLaplaceFundamentalSolution(dim,r,r_norm)

n_gauss                         =  size(r,2);
d2Vdxdx                         =  zeros(dim,dim,n_gauss,1);
switch dim 
    case 2
         for igauss=1:n_gauss
             d2Vdxdx(:,:,igauss)  =  1/(2*pi*r_norm(igauss)^2)*(-eye(dim) + 2/r_norm(igauss)^2*(r(:,igauss)*r(:,igauss)'));
         end
    case 3
         for igauss=1:n_gauss
             d2Vdxdx(:,:,igauss)  =  1/(4*pi*r_norm(igauss)^3)*(-eye(dim) + 3/r_norm(igauss)^2*(r(:,igauss)*r(:,igauss)'));
         end
end
