n_gauss=27;
N      =  1e4;
R      =  randi(10,3,n_gauss);

A=randi(10,3,3,n_gauss);
for igauss=1:n_gauss
    A(:,:,igauss)  =  A(:,:,igauss)*A(:,:,igauss)';
end


tic
for in=1:N
    DD1   =  zeros(3,n_gauss);
    for igauss=1:n_gauss
        DD1(:,igauss) =  A(:,:,igauss)\R(:,igauss);
    end
end
toc

tic
for in=1:N
    DD2   =  zeros(3,n_gauss);
    for igauss=1:n_gauss
        DD2(:,igauss) =  inv(A(:,:,igauss))*R(:,igauss);
    end
end
toc

indexi    =  reshape(repmat([1 2 3 1 2 3 1 2 3]',1,n_gauss) + repmat((0:3:3*(n_gauss-1)),9,1),[],1);
indexj    =  reshape(repmat(1:3*n_gauss,3,1),[],1);
tic
for in=1:N
    data    =  A(:);
    K       =  sparse(indexi,indexj,data);
    DD3     =  K\R(:); 
end
toc






