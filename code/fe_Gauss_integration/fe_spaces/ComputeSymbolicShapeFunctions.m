%function [N,DN_chi]  =  ComputeSymbolicShapeFunctions

Quadrature.Chi      =  NodesIsoparametricSpace(3,1);
[symbN,symbDN_chi]  =  SymbolicShapeFunctionsQuadsHexas(1,3);  

N        =  zeros(size(Quadrature.Chi,1),size(Quadrature.Chi,1));
DN_chi   =  zeros(3,size(Quadrature.Chi,1),size(Quadrature.Chi,1));

for inode=1:size(Quadrature.Chi,1)
    chi   =  Quadrature.Chi(inode,1);
    eta   =  Quadrature.Chi(inode,2);
    iota  =  Quadrature.Chi(inode,3);
    N(:,inode)         =  eval(symbN);
    DN_chi(:,:,inode)  =  [eval(symbDN_chi(1,:));eval(symbDN_chi(2,:));eval(symbDN_chi(3,:))];
    
end

save('Hexa_NodeShapeFunctions_Q1','N','DN_chi')

load(['Quad_NodeShapeFunctions_Q' num2str(1) '.mat']);
asdf=98


