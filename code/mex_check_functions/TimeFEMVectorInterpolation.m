
N   =  1e6;

VectorField  =  rand(6,4);
NShape       =  rand(4,4);

tic
for i=1:N
Field  =  FEMVectorInterpolationMexC(VectorField,NShape);
end
toc

tic
a     =  zeros(size(VectorField,1),4);
for i=1:N
    for igauss=1:4
        a(:,igauss) = (VectorField(:,1)*NShape(1,igauss) + ...
                       VectorField(:,2)*NShape(2,igauss) + ...
                       VectorField(:,3)*NShape(3,igauss) + ...
                       VectorField(:,4)*NShape(4,igauss));
    end
end
toc

