N            =  1e5;
Q            =  2;            
dim          =  3; 
ngauss       =  (Q + 1)^(dim);
n_node_elem  =  (Q + 1)^(dim);

xelem        =  rand(dim,n_node_elem);
Xelem        =  rand(dim,n_node_elem);
DNchi        =  rand(dim,n_node_elem,ngauss);  

Weight       =  rand(ngauss,1);
mu1          =  1;
mu2          =  2;
lambda       =  3;

tic
for i=1:N
%--------------------------------------------------------------------------
% Compute the kinematics 
%--------------------------------------------------------------------------
[F,H,J,DNX,IntWeight]  =  KinematicsFinalMexC(xelem,Xelem,DNchi,Weight);
%--------------------------------------------------------------------------
% Constitutive model
%--------------------------------------------------------------------------
[P,Hv]   =  MooneyRivlinModelFbasedMexC(mu1,mu2,lambda,F,H,J);
%--------------------------------------------------------------------------
% Stiffness matrix
%--------------------------------------------------------------------------
K        =  TangentOperatorUFormulationMexC(DNX,Hv,IntWeight);  
end
toc



