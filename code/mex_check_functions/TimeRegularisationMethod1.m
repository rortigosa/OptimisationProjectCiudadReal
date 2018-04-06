m  =  4;
ngauss  =  4;
A  =  rand(m,m,ngauss);
A(1,1) =  -1;

N  =  1;

tic
for i=1:N
    AReg1   =  RegularisationElasticityMethod1(2,ngauss,A);
end
toc
 
tic
for i=1:N
    AReg2   =  RegularisationElasticity1MexC(m,ngauss,A);
end
toc

norm_  =  zeros(ngauss,1);
for igauss=1:ngauss
   norm_(igauss) = norm(AReg1(:,:,igauss) - AReg2(:,:,igauss));
end

asdf=98
