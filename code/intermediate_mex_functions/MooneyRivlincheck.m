profile on;
N            =  1e4;
Q            =  1;            
dim          =  2;
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
% Parent gradients
%--------------------------------------------------------------------------
[DNX,DetDXChi]  =  ParentGradientsMexC(xelem,Xelem,DNchi);
%--------------------------------------------------------------------------
% Compute kinematics
%--------------------------------------------------------------------------
[F,C,G,detC]      =  KinematicsCMexC(xelem,Xelem,DNX);
%--------------------------------------------------------------------------
% Compute first Piola-Kirchhoff stress tensor
%--------------------------------------------------------------------------
PC               =  MooneyRivlinModelCMexC25(mu1,mu2,lambda,F,C,G,detC);
end
