N       =  1e6;
Matrix  = randi(10,3,3,27);

tic
dim        =  3;
for i=1:N
    ngauss  =  27;
    Vector  =  Matrix2Vector(dim^2,ngauss,Matrix);
end
toc


tic
dim        =  3;
for i=1:N      
    Vector  =  reshape(permute(Matrix,[2 1 3]),dim^2,[]);
end
toc