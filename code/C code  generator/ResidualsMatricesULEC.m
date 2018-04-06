%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% Residuals and Stiffness matrices
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function asmb          =  ResidualsMatricesULEC(asmb,DU,D2U,vect_kin,kinematics,IntWeight,dim,n_node_elem,ngauss,u)

BFx                    =  zeros(dim^2,dim*n_node_elem);
H                      =  zeros(dim,dim);
QF                     =  zeros(dim^2);
QSigmaH                =  zeros(dim^2);
BFxT                   =  zeros(dim*n_node_elem,dim^2);
BHx                    =  zeros(dim^2,dim*n_node_elem);
BHxT                   =  zeros(dim*n_node_elem,dim^2);
BJx                    =  zeros(dim^2,dim*n_node_elem);
BJxT                   =  zeros(dim*n_node_elem,dim^2);
KFF                    =  zeros(dim^2);
KFH                    =  zeros(dim^2);
KFJ                    =  zeros(dim^2,1);
KHH                    =  zeros(dim^2);
KHJ                    =  zeros(dim^2,1);
KJJ                    =  0;
geometric              =  zeros(dim*n_node_elem);
Kxx                    =  zeros(dim*n_node_elem);

for igauss=1:ngauss
    BFx                =  vect_kin.BF(:,:,igauss);
    H                  =  kinematics.H(:,:,igauss);
    QF                 =  vect_kin.QF(:,:,igauss);
    QSigmaH            =  vect_kin.QSigmaH(:,:,igauss);    
    %----------------------------------------------------------------------
    % Transpose of matrices
    %----------------------------------------------------------------------
    BFxT               =  BFx';
    BHx                =  QF*BFx;
    BHxT               =  BHx';
    BJx                =  reshape(H',[],1)'*BFx;
    BJxT               =  BJx';
    %----------------------------------------------------------------------
    % Stiffness matrices for Kxx
    %----------------------------------------------------------------------
    KFF               =  BFxT*(D2U.D2UDFDF(:,:,igauss)*BFx);
    KFH               =  BFxT*(D2U.D2UDFDH(:,:,igauss)*BHx);
    KFJ               =  BFxT*(D2U.D2UDFDJ(:,:,igauss)*BJx);
    KHH               =  BHxT*(D2U.D2UDHDH(:,:,igauss)*BHx);
    KHJ               =  BHxT*(D2U.D2UDHDJ(:,:,igauss)*BJx);
    KJJ               =  BJxT*(D2U.D2UDJDJ(igauss)*BJx);
    geometric         =  (BFxT*QSigmaH*BFx) + DU.DUDJ(igauss)*(BFxT*BHx);
    Kxx               =  KFF + KHH + KJJ + (KFH + KFH') + (KFJ + KFJ') + (KHJ + KHJ') + geometric;
    %----------------------------------------------------------------------
    % Residual and stiffness matrices for non-linear elasticity regions
    %----------------------------------------------------------------------
    asmb.Tx           =  asmb.Tx  +  (Kxx*u(:))*IntWeight(igauss);
    asmb.Kxx          =  asmb.Kxx  +  Kxx*IntWeight(igauss);
end
