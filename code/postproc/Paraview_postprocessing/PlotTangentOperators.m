function PlotTangentOperators(Geometry,Mesh,FEM,MatInfo,Solution,...
                                            ielem,igauss,filename)    

%--------------------------------------------------------------------------
% Extract from the structures   
%--------------------------------------------------------------------------
xold                      =  Solution.old.x.Eulerian_x;
X                         =  Solution.x.Lagrangian_X;
connectivity              =  Mesh.volume.x.connectivity;
DNX                       =  FEM.volume.bilinear.x.DN_X;
ngauss                    =  1;
%--------------------------------------------------------------------------
% Kinematics
%--------------------------------------------------------------------------
xold_elem             =  xold(:,connectivity(:,ielem));
X_elem                =  X(:,connectivity(:,ielem));
[Fo,Ho,Jo]            =  KinematicsFunctionFinalMexC(xold_elem,X_elem,DNX);
FI                    =  eye(Geometry.dim);
HI                    =  eye(Geometry.dim);
JI                    =  1;
%--------------------------------------------------------------------------
% Compute Piola and the Elasticity tensor for the nonlinear model
%--------------------------------------------------------------------------
if ~Geometry.PlaneStress
    Fo                 =  zeros(3,3);
    Fo(1:2,1:2,:)      =  Fo;
    Fo(3,3,:)          =  1;
    Ho                 =  zeros(3,3);
    Ho(1:2,1:2,:)      =  Ho;
    Ho(3,3,:)          =  Jo;
    Jo                 =  J;
    [~,Elasticity3D]       =  MooneyRivlinMexC(MatInfo.mu1,MatInfo.mu2,...
                              MatInfo.lambda,Fo(:,:,igauss),Ho(:,:,igauss),Jo(igauss));        
    [~,...
    ElasticityOrigin3D]    =  MooneyRivlinMexC(MatInfo.mu1,MatInfo.mu2,...
                               MatInfo.lambda,FI,HI,JI);        
else
    [~,~,Elasticity3D]     =  MooneyRivlinPlaneStressMatLab(Geometry.dim,ngauss,MatInfo.mu1,...
                               MatInfo.mu2,MatInfo.lambda,Fo(igauss),Ho(:,:,1),Jo(:,:,1));        
    [~,~,...
     ElasticityOrigin3D]   =  MooneyRivlinPlaneStressMatLab(Geometry.dim,ngauss,MatInfo.mu1,...
                               MatInfo.mu2,MatInfo.lambda,FI,HI,JI);        
end
%--------------------------------------------------------------------------
% Regularisation of the elasticity tensor
%--------------------------------------------------------------------------
Elasticity3DReg        =  RegularisationElasticity1MexC(9,1,Elasticity3D,ElasticityOrigin3D(:,:,igauss));           


Nalpha =  200;
Nbeta  =  100;
alpha  =  linspace(0,2*pi,Nalpha);
beta   =  linspace(0,pi,Nbeta);
%--------------------------------------------------------------------------
% Mesh for spherical parametrisation of the elasticity modulus
%--------------------------------------------------------------------------
inode  =  0;
ShearModulus      =  zeros(3,Nalpha*Nbeta);
ShearModulusReg   =  zeros(3,Nalpha*Nbeta);
BulkModulus       =  zeros(3,Nalpha*Nbeta);
BulkModulusReg    =  zeros(3,Nalpha*Nbeta);

ShearModulus_     =  zeros(Nalpha*Nbeta,1);
ShearModulusReg_  =  zeros(Nalpha*Nbeta,1);
BulkModulus_      =  zeros(Nalpha*Nbeta,1);
BulkModulusReg_   =  zeros(Nalpha*Nbeta,1);


for ialpha=1:Nalpha
    for ibeta=1:Nbeta        
        inode  =  inode + 1;
        %------------------------------------------------------------------
        % Vector N
        %------------------------------------------------------------------
        beta_                     =  beta(ibeta);
        alpha_                    =  alpha(ialpha);
        N                         =  [sin(beta_)*cos(alpha_);  sin(beta_)*sin(alpha_);  cos(beta_)];
        NN                        =  N*N';
        NNNN                      =  NN(:)*NN(:)';
        I_matrix                  =  eye(3);
        I_NN                      =  I_matrix(:)*NN(:)';        
        %------------------------------------------------------------------
        % Shear and bulk modulus
        %------------------------------------------------------------------
        ShearModulus_(inode)      =  (reshape(Elasticity3D(:,:,igauss),1,[])*NNNN(:));
        ShearModulusReg_(inode)   =  (reshape(Elasticity3DReg(:,:,igauss),1,[])*NNNN(:));
        BulkModulus_(inode)       =  1/3*(reshape(Elasticity3D(:,:,igauss),1,[])*I_NN(:));
        BulkModulusReg_(inode)    =  1/3*(reshape(Elasticity3DReg(:,:,igauss),1,[])*I_NN(:));
        
        ShearModulus(:,inode)     =  ShearModulus_(inode)*N;
        ShearModulusReg(:,inode)  =  ShearModulusReg_(inode)*N;
        BulkModulus(:,inode)      =  BulkModulus_(inode)*N;
        BulkModulusReg(:,inode)   =  BulkModulusReg_(inode)*N;        
    end
end
DimShearModulus     =  abs(max(max(ShearModulus)));
DimShearModulusReg  =  abs(max(max(ShearModulusReg)));
DistShear           =  (DimShearModulus + DimShearModulusReg)*1.2;

DimBulkModulus      =  abs(max(max(BulkModulus)));
DimBulkModulusReg   =  abs(max(max(BulkModulusReg)));
DistBulk            =  (DimBulkModulus + DimBulkModulusReg)*1.2;

ShearModulusReg     =  ShearModulusReg + DistShear*repmat([1;0;0;],1,size(ShearModulusReg,2));
BulkModulusReg      =  BulkModulusReg  + DistBulk*repmat([1;0;0;],1,size(BulkModulusReg,2));

ShearModulus     =  [ShearModulus     ShearModulus];
ShearModulusReg  =  [ShearModulusReg  ShearModulusReg];
BulkModulus      =  [BulkModulus      BulkModulus];
BulkModulusReg   =  [BulkModulusReg   BulkModulusReg];
%--------------------------------------------------------------------------
% Mesh
%--------------------------------------------------------------------------
connectivity  =  zeros(8,(Nalpha-1)*(Nbeta-1));
ielem   =  0;
for ialpha=1:Nalpha-1    
    for ibeta=1:Nbeta-1
        ielem  =  ielem + 1;
           connectivity(1,ielem)  =  ibeta + 0 + Nbeta*(ialpha-1);
           connectivity(2,ielem)  =  ibeta + 1 + Nbeta*(ialpha-1);
           connectivity(3,ielem)  =  ibeta + 1 + Nbeta*ialpha;
           connectivity(4,ielem)  =  ibeta + 0 + Nbeta*ialpha;                        
           
           connectivity(5,ielem)  =  connectivity(1,ielem) + (Nalpha*Nbeta);
           connectivity(6,ielem)  =  connectivity(2,ielem) + (Nalpha*Nbeta);
           connectivity(7,ielem)  =  connectivity(3,ielem) + (Nalpha*Nbeta);
           connectivity(8,ielem)  =  connectivity(4,ielem) + (Nalpha*Nbeta);     
    end
end
connectivity  =  [connectivity  connectivity+2*(Nalpha*Nbeta)];
%--------------------------------------------------------------------------
% Paraview
%--------------------------------------------------------------------------
VTKPlot(['ShearModulus_' filename],'unstructured_grid',[ShearModulus ShearModulusReg]',connectivity','scalars','ShearModulus',[ShearModulus_;ShearModulus_;ShearModulusReg_;ShearModulusReg_]);         
VTKPlot(['BulkModulus_' filename],'unstructured_grid',[BulkModulus BulkModulusReg]',connectivity','scalars','BulkModulus',[BulkModulus_;BulkModulus_;BulkModulusReg_;BulkModulusReg_]);         

end


