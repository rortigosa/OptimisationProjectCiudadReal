
N   =  1e5;

tic
for i=1:N
Field  =  FEMScalarInterpolationMexC(ScalarField,NShape);
end
toc

tic
for i=1:N
a = (ScalarField(1)*NShape(1,:) + ScalarField(2)*NShape(2,:) + ScalarField(3)*NShape(3,:) + ScalarField(4)*NShape(4,:));
end
toc

N   =  1e5;

