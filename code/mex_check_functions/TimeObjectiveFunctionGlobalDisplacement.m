uGauss=rand(2,4);
IntWeight  =  rand(4,1);


N  =  1e5;

tic
for i=1:N
    ObjFunC  =  ObjectiveFunctionGlobalDisplacementMexC(uGauss,IntWeight);    
end
toc


tic
for i=1:N
ObjFun  =  0;
for igauss=1:4
    u   =  uGauss(:,igauss);
    ObjFun  =  ObjFun + sqrt(u'*u)*IntWeight(igauss);
end
end
toc