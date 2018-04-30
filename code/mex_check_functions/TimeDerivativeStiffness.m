
dim               =  3;
n_node_elem       =  8;
ngauss            =  8;

DNX               =  rand(dim,n_node_elem,ngauss);
EigenVector       =  rand(dim,n_node_elem);
SixthOrderTensor  =  rand(dim,dim,dim,dim,dim,dim,ngauss);
IntWeight         =  rand(ngauss,1);
Elasticity        =  rand(dim,dim,dim,dim,ngauss);

N  =  1e5;

tic
for i=1:N
    DKMexC     =  DerivativeStiffnessTrialMexC6(DNX,EigenVector,SixthOrderTensor,IntWeight);
end
toc

tic
for i=1:N
    Kxx        =  TangentOperatorUFormulationMexC(DNX,Elasticity,IntWeight);
end
toc
% tic
% for i=1:N
%     DKMatLab   =  DerivativeStiffnessMatLab(dim,n_node_elem,ngauss,DNX,EigenVector,SixthOrderTensor,IntWeight);
% end
% toc
% 
% 
