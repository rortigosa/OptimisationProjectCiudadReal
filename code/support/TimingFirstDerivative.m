clear all
N         =  1e4;
dim       =  2; 
ngauss    =  8;

mu1       =  10;
mu2       =  10;
e1        =  20;
kappa     =  30;

F         =  randi(10,dim,dim,ngauss);
H         =  randi(10,dim,dim,ngauss);
J         =  randi(10,ngauss,1);
E0        =  randi(10,dim,ngauss);


tic
for i=1:N
switch dim
    case 2
         twoD_Jterm                            =  mu2*J;
    case 3 
         twoD_Jterm                            =  0;
end
HE0                                            =  MatrixVectorMultiplication(dim,ngauss,H,E0);
HE0HE0                                         =  VectorVectorInnerMultiplication(ngauss,HE0,HE0);
HE0E0                                          =  VectorVectorOuterMultiplication(dim,ngauss,HE0,E0);
HTHE0                                          =  MatrixVectorMultiplication(dim,ngauss,permute(H,[2,1,3]),HE0);
invJ                                           =  1./J; 
material_information.derivatives.DPsi.DPsiDF   =  mu1*F;
material_information.derivatives.DPsi.DPsiDH   =  mu2*H - (1/e1)*MatrixScalarMultiplication(dim,ngauss,HE0E0,invJ);
material_information.derivatives.DPsi.DPsiDE0  =  -(1/e1)*VectorScalarMultiplication(dim,ngauss,HTHE0,invJ);
material_information.derivatives.DPsi.DPsiDJ   =  -(mu1 + 2*mu2)*invJ + kappa*(J-1) + 1/(2*e1)*((invJ.^2).*HE0HE0) + twoD_Jterm;


end
toc


material_information.derivatives.DPPsi.DPsiDF  =  zeros(dim,dim,ngauss);
material_information.derivatives.DPPsi.DPsiDH  =  zeros(dim,dim,ngauss);
material_information.derivatives.DPPsi.DPsiDE0  =  zeros(dim,ngauss);
material_information.derivatives.DPPsi.DPsiDJ  =  zeros(ngauss,1);
tic
for i=1:N
for igauss=1:ngauss
    HE0                                                        =  H(:,:,igauss)*E0(:,igauss);
    material_information.derivatives.DPPsi.DPsiDF(:,:,igauss)   =  mu1*F(:,:,igauss);
    material_information.derivatives.DPPsi.DPsiDH(:,:,igauss)   =  mu2*H(:,:,igauss) - 1/(e1*J(igauss))*((HE0)*E0(:,igauss)');
    material_information.derivatives.DPPsi.DPsiDJ(igauss)   =  -(mu1 + 2*mu2)/J(igauss) + mu2*J(igauss) + kappa*(J(igauss)-1) + 1/(2*e1*J(igauss)^2)*(HE0'*HE0);
    material_information.derivatives.DPPsi.DPsiDE0(:,igauss)    =  -1/(e1*J(igauss))*H(:,:,igauss)'*HE0;
end
switch dim
    case 2
for igauss=1:ngauss
    HE0                                                        =  H(:,:,igauss)*E0(:,igauss);
    material_information.derivatives.DPPsi.DPsiDJ(igauss)   =  -(mu1 + 2*mu2)/J(igauss) + mu2*J(igauss) + kappa*(J(igauss)-1) + 1/(2*e1*J(igauss)^2)*(HE0'*HE0);
end
    case 3
for igauss=1:ngauss
    HE0                                                        =  H(:,:,igauss)*E0(:,igauss);
    material_information.derivatives.DPPsi.DPsiDJ(igauss)      =  -(mu1 + 2*mu2)/J(igauss) + kappa*(J(igauss)-1) + 1/(2*e1*J(igauss)^2)*(HE0'*HE0);
end        
end
end
toc

asdf=98