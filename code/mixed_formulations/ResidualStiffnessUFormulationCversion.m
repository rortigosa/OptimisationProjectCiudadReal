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

LHS_indices_vector     =  zeros(dim^2*n_node_elem,ngauss);
RHS_indices_vector     =  zeros(dim^2*n_node_elem,ngauss);
for igauss=1:ngauss
    switch dim 
       case 2 
            LHS_indices   =  repmat([1,2,7,8]',n_node_elem,1)+reshape(repmat(0:8:8*(n_node_elem-1),4,1),[],1);
            RHS_indices   =  repmat([1,2,1,2]',n_node_elem,1)+reshape(repmat(0:2:2*(n_node_elem-1),4,1),[],1);
       case 3
            LHS_indices   =  repmat([1,2,3,13,14,15,25,26,27]',n_node_elem,1) + reshape(repmat(0:27:27*(n_node_elem-1),9,1),[],1);
            RHS_indices   =  repmat([1,2,3,1,2,3,1,2,3]',n_node_elem,1)+reshape(repmat(0:3:3*(n_node_elem-1),9,1),[],1);
    end
    LHS_indices_vector(:,igauss)  =  LHS_indices + (dim^3*n_node_elem)*(igauss - 1);
    RHS_indices_vector(:,igauss)  =  RHS_indices + dim*n_node_elem*(igauss - 1);    
end
B_LHS  =  LHS_indices_vector(:);
B_RHS  =  RHS_indices_vector(:);
B_LHSC       =  B_LHS - 1;
B_RHSC       =  B_RHS - 1;

LHS_indices_vector     =  zeros(dim^2*n_node_elem,ngauss);
RHS_indices_vector     =  zeros(dim^2*n_node_elem,ngauss);
for igauss=1:ngauss
    switch dim 
       case 2 
            LHS_indices   =  repmat([1,3,5,6]',n_node_elem,1)+reshape(repmat(0:8:8*(n_node_elem-1),4,1),[],1);
            RHS_indices   =  repmat([1,2,2,1]',n_node_elem,1)+reshape(repmat(0:2:2*(n_node_elem-1),4,1),[],1);
       case 3
            LHS_indices   =  repmat([1,4,5,8,10,12,15,17,18]',n_node_elem,1) + reshape(repmat(0:27:27*(n_node_elem-1),9,1),[],1);
            RHS_indices   =  repmat([1,2,3,2,1,3,3,1,2]',n_node_elem,1)+reshape(repmat(0:3:3*(n_node_elem-1),9,1),[],1);
    end
    LHS_indices_vector(:,igauss)  =  LHS_indices + (dim^3*n_node_elem)*(igauss - 1);
    RHS_indices_vector(:,igauss)  =  RHS_indices + dim*n_node_elem*(igauss - 1);    
end
BC_LHS  =  LHS_indices_vector(:);
BC_RHS  =  RHS_indices_vector(:);
BC_LHSC =  BC_LHS - 1';
BC_RHSC =  BC_RHS - 1';

 


mat_info.material_model                  =  'Mooney_Rivlin';
mat_info.material_identifier             =  (1:N)';
mat_info.parameters.MRivlin.mu1          =  mu1*ones(N,1);
mat_info.parameters.MRivlin.mu2          =  mu2*ones(N,1);
mat_info.parameters.MRivlin.kappa        =  lambda*ones(N,1);
mat_info.derivatives.DU.DUDF             =  zeros(dim,dim,ngauss);
mat_info.derivatives.DU.DUDH             =  zeros(dim,dim,ngauss);
mat_info.derivatives.DU.DUDJ             =  zeros(ngauss,1);

mat_info.derivatives.D2U.D2UDFDF             =  zeros(dim*dim,dim*dim,ngauss);
mat_info.derivatives.D2U.D2UDFDH             =  zeros(dim*dim,dim*dim,ngauss);
mat_info.derivatives.D2U.D2UDFDJ             =  zeros(dim*dim,1,ngauss);
mat_info.derivatives.D2U.D2UDHDF             =  zeros(dim*dim,dim*dim,ngauss);
mat_info.derivatives.D2U.D2UDHDH             =  zeros(dim*dim,dim*dim,ngauss);
mat_info.derivatives.D2U.D2UDHDJ             =  zeros(dim*dim,1,ngauss);
mat_info.derivatives.D2U.D2UDJDF             =  zeros(1,dim*dim,ngauss);
mat_info.derivatives.D2U.D2UDJDH             =  zeros(1,dim*dim,ngauss);
mat_info.derivatives.D2U.D2UDJDJ             =  zeros(ngauss,1);

  

% %--------------------------------------------------------------------------
% %--------------------------------------------------------------------------
% % C version in terms of F
% %--------------------------------------------------------------------------
% %--------------------------------------------------------------------------
% tic
% %--------------------------------------------------------------------------
% %--------------------------------------------------------------------------
% % C version in terms of F
% %--------------------------------------------------------------------------
% %--------------------------------------------------------------------------
% for i=1:N 
% %--------------------------------------------------------------------------
% % Compute parent gradients and DetDXChi
% %--------------------------------------------------------------------------
% [DNX,DetDXChi]  =  ParentGradientsMexC(xelem,Xelem,DNchi);
% %--------------------------------------------------------------------------
% % Compute weights for quadrature integration
% %--------------------------------------------------------------------------
% IntWeight       =  WeightsIntegrationMexC(DetDXChi,Weight);
% %--------------------------------------------------------------------------
% % Compute kinematics
% %--------------------------------------------------------------------------
% [F,H,J]         =  KinematicsMexC(xelem,Xelem,DNX);
% %--------------------------------------------------------------------------
% % Compute first and second derivatives of the Mooney-Rivlin model
% %--------------------------------------------------------------------------
% [WF,WH,WJ,WFF,...
%  WFH,WFJ,WHH,...
%  WHJ,WJJ]       =  MooneyRivlinModelMexC(mu1,mu2,lambda,F,H,J);
% %--------------------------------------------------------------------------
% % Compute first Piola-Kirchhoff stress tensor
% %--------------------------------------------------------------------------
% %PC               =  FirstPiolaMexC(F,H,WF,WH,WJ);
% %--------------------------------------------------------------------------
% % Compute Bmatrices   
% %--------------------------------------------------------------------------
% [BF,BH,BJ,...
%  BSigmaH]       =  BmatricesMexC(DNX,BC_LHSC,BC_RHSC,F,H,H);
% % %--------------------------------------------------------------------------
% % % Stiffness Matrix 
% % %--------------------------------------------------------------------------
% % K               =  StiffnessMatrixUFormulation(dim,ngauss,n_node_elem,BF,BH,BJ,BSigmaH,WJ,WFF,WFH,WFJ,WHH,WHJ,WJJ,IntWeight);
% end
% toc   

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% C version in terms of C    
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
if dim==2
    voigt_dim = 3;
else 
    voigt_dim = 6;
end 

BC  =  rand(voigt_dim,dim*n_node_elem,ngauss);
BF  =  rand(dim*dim,dim*n_node_elem,ngauss);
Elasticity  =  rand(voigt_dim,voigt_dim,ngauss);
IntWeight=rand(ngauss,1);
tic 
for i=1:N
    K  =  StiffnessMatricesDBCMexC1(dim,ngauss,n_node_elem,BC,Elasticity,IntWeight);    
end
toc
 
WFF= rand(dim*dim,dim*dim,ngauss);
tic
for i=1:N
    K  =  checkBDBFbasedMexC(dim,ngauss,n_node_elem,BF,WFF,IntWeight);    
end
toc

DNX  =  rand(dim,n_node_elem,ngauss);
tic 
for i=1:N
    K  =  ConstitutiveMatrixFBasedMexC7(DNX,WFF,IntWeight);    
end
toc


tic 
Elasticity  =  rand(3,3,ngauss);
for i=1:N
    K  =  ResidualsStiffnessCVersion(xelem,Xelem,DNchi,mu1,mu2,lambda,BC_LHSC,BC_RHSC,n_node_elem,ngauss,dim,Weight);
end
toc 
 
for i=1:N
K  =  ResidualsStiffnessFinalFVersion(xelem,Xelem,DNchi,mu1,mu2,lambda,Weight)
end

BF                =  zeros(dim^2,dim*n_node_elem,ngauss);
[DNX,DetDXChi]  =  ParentGradientsMexC(xelem,Xelem,DNchi);
IntWeight       =  WeightsIntegrationMexC(DetDXChi,Weight);

tic
for ielem=1:N
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%  MatLab version 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Obtain gradients of kinematics and electrical variables
%--------------------------------------------------------------------------
Kxx = ResidualStiffnessMatlabVersion(ielem,dim,xelem,DNX,ngauss,mat_info,B_LHS,B_RHS,n_node_elem,Weight,DetDXChi); 
% 
% 
end
toc




