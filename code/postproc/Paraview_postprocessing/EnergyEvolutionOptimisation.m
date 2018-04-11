function [Energy,EnergyLin,EnergyReg,TotalEnergy,...,
    TotalEnergyLin,TotalEnergyReg,...
    EnergySolid,EnergyLinSolid,EnergyRegSolid,...
    TotalEnergySolid,TotalEnergyLinSolid,...
    TotalEnergyRegSolid] =  EnergyEvolutionOptimisation(Geometry,...
                                                Mesh,FEM,MatInfo,Solution,...
                                                Quadrature,Optimisation)
                                            
switch MatInfo.model
    case {'MooneyRivlin','NeoHookean'}
    otherwise
        error('This function is only available for Mooney-Rivlin and Neo-Hookean models')     
end                    
%--------------------------------------------------------------------------
% Cut-off for densities
%--------------------------------------------------------------------------
rho                     =  Optimisation.density;
penalty                 =  Optimisation.penalty;
rhop                    =  rho.^penalty;
%--------------------------------------------------------------------------
% Extract from the structures    
%--------------------------------------------------------------------------
x                       =  Solution.x.Eulerian_x;
xold                    =  Solution.old_Post.x.Eulerian_x;  
X                       =  Solution.x.Lagrangian_X;
connectivity            =  Mesh.volume.x.connectivity;
DNX                     =  FEM.volume.bilinear.x.DN_X;
IntWeight               =  Quadrature.volume.bilinear.IntWeight;
ngauss                  =  size(IntWeight,1);
ElasticityOrigin        =  MatInfo.ElasticityLinear;
Klinear                 =  MatInfo.Klinear;
%--------------------------------------------------------------------------
% Detect unstable elements
%--------------------------------------------------------------------------
Energy                  =  zeros(Mesh.volume.n_elem,1);
EnergyLin               =  zeros(Mesh.volume.n_elem,1);
EnergyReg               =  zeros(Mesh.volume.n_elem,1);
EnergySolid             =  zeros(Mesh.volume.n_elem,1);
EnergyLinSolid          =  zeros(Mesh.volume.n_elem,1);
EnergyRegSolid          =  zeros(Mesh.volume.n_elem,1);
TotalEnergy             =  0;
TotalEnergyLin          =  0;
TotalEnergyReg          =  0;
TotalEnergySolid        =  0;
TotalEnergyLinSolid     =  0;
TotalEnergyRegSolid     =  0;
for ielem=1:Mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % Kinematics
    %----------------------------------------------------------------------
    x_elem              =  x(:,connectivity(:,ielem));
    xold_elem           =  xold(:,connectivity(:,ielem));
    X_elem              =  X(:,connectivity(:,ielem));
    [F,H,J]             =  KinematicsFunctionFinalMexC(x_elem,X_elem,DNX);
    [Fo,Ho,Jo]          =  KinematicsFunctionFinalMexC(xold_elem,X_elem,DNX);
    [DF,~,~]            =  KinematicsFunctionFinalMexC(x_elem-xold_elem,X_elem,DNX);
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    if ~Geometry.PlaneStress    
       [Piola0,...
        Elasticity0]  =  MooneyRivlinMexC(MatInfo.mu1,MatInfo.mu2,...
                                         MatInfo.lambda,Fo,Ho,Jo);    
    else
       [Piola0,...
        Elasticity0]  =  MooneyRivlinPlaneStress(MatInfo.mu1,MatInfo.mu2,...
                                         MatInfo.lambda,Fo,Ho,Jo);    
    end           
    %----------------------------------------------------------------------
    % Regularisation of the elasticity tensor 
    %----------------------------------------------------------------------
    Elasticity0Reg    =  RegularisationElasticity1MexC(Geometry.dim^2,ngauss,Elasticity0,ElasticityOrigin);           
    %----------------------------------------------------------------------
    % Linear energy
    %----------------------------------------------------------------------
    u                 =  x_elem - X_elem;    
    VoidEnergy        =  0.5*(1 - rhop(ielem))*(u(:)'*(Klinear*u(:)));
    %----------------------------------------------------------------------
    % Compute incrementally linearised energy
    %----------------------------------------------------------------------
    if ~Geometry.PlaneStress
       W0_elem        =  MooneyRivlinEnergyMexC(MatInfo.mu1,MatInfo.mu2,MatInfo.lambda,Fo,Ho,Jo,ones(ngauss,1));
       Energy_elem    =  MooneyRivlinEnergyMexC(MatInfo.mu1,MatInfo.mu2,MatInfo.lambda,F,H,J,ones(ngauss,1));
       Energy(ielem)  =  rhop(ielem)*(Energy_elem'*IntWeight) + VoidEnergy;
       EnergySolid(ielem)  =  (Energy_elem'*IntWeight);
    else
       [~,~,...
        thickness_stretch0]  =  MooneyRivlinPlaneStress(MatInfo.mu1,MatInfo.mu2,MatInfo.lambda,Fo,Ho,Jo); 
       W0_elem        =  MooneyRivlinEnergyMexC(MatInfo.mu1,MatInfo.mu2,MatInfo.lambda,Fo,Ho,Jo,thickness_stretch0);
       [~,~,...
        thickness_stretch]  =  MooneyRivlinPlaneStress(MatInfo.mu1,MatInfo.mu2,MatInfo.lambda,F,H,J); 
       Energy_elem    =  MooneyRivlinEnergyMexC(MatInfo.mu1,MatInfo.mu2,MatInfo.lambda,F,H,J,thickness_stretch);       
       Energy(ielem)       =  rhop(ielem)*(Energy_elem'*IntWeight) + VoidEnergy;
       EnergySolid(ielem)  =  (Energy_elem'*IntWeight);       
    end        
    H_u               =  MatrixVectorMultiplicationMexC(Geometry.dim^2,ngauss,Elasticity0,reshape(DF,Geometry.dim^2,[]));                         
    u_H_u             =  VectorVectorInnerMultiplication(ngauss,reshape(DF,Geometry.dim^2,[]),reshape(H_u,Geometry.dim^2,[]));
    Piola0_u          =  MatrixMatrixContraction(ngauss,Piola0,DF); 
    SolidEnergy       =  (W0_elem + Piola0_u + 0.5*u_H_u)'*IntWeight;
    EnergyLin(ielem)  =  rhop(ielem)*SolidEnergy + VoidEnergy;    
    EnergyLinSolid(ielem)  =  SolidEnergy;    
    %----------------------------------------------------------------------
    % Compute incrementally regularised energy
    %----------------------------------------------------------------------
    H_u               =  MatrixVectorMultiplicationMexC(Geometry.dim^2,...
                               ngauss,Elasticity0Reg,reshape(DF,Geometry.dim^2,[]));                         
    u_H_u             =  VectorVectorInnerMultiplication(ngauss,...
                                reshape(DF,Geometry.dim^2,[]),reshape(H_u,Geometry.dim^2,[]));
    Piola0_u          =  MatrixMatrixContraction(ngauss,Piola0,DF); 
    SolidEnergy       =  (W0_elem + Piola0_u + 0.5*u_H_u)'*IntWeight;
    EnergyReg(ielem)       =  SolidEnergy + VoidEnergy;         
    EnergyRegSolid(ielem)  =  SolidEnergy;    
    %----------------------------------------------------------------------
    % Integrate the energy over the domain 
    %----------------------------------------------------------------------
    TotalEnergy       =  TotalEnergy    + Energy(ielem);
    TotalEnergyLin    =  TotalEnergyLin + EnergyLin(ielem);
    TotalEnergyReg    =  TotalEnergyReg + EnergyReg(ielem);

    TotalEnergySolid       =  TotalEnergySolid    + EnergySolid(ielem);
    TotalEnergyLinSolid    =  TotalEnergyLinSolid + EnergyLinSolid(ielem);
    TotalEnergyRegSolid    =  TotalEnergyRegSolid + EnergyRegSolid(ielem);
end     

end






