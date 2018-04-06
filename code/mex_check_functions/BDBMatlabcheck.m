function  K  =  BDBMatlabcheck(dim,ngauss,n_node_elem,BF,WFF,IntWeight)


K  =  zeros(dim*n_node_elem);
for igauss=1:ngauss    
%--------------------------------------------------------------------------
% Transpose of matrices
%--------------------------------------------------------------------------
BFT     =  BF(:,:,igauss)';
%--------------------------------------------------------------------------
% Stiffness matrices for Kxx
%--------------------------------------------------------------------------
KFF     =  BFT*(WFF(:,:,igauss)*BF(:,:,igauss));
% KFH     =  BFT*(WFF(:,:,igauss)*BF(:,:,igauss));
% KFJ     =  BFT*(WFF(:,:,igauss)*BF(:,:,igauss));
% KHH     =  BFT*(WFF(:,:,igauss)*BF(:,:,igauss));
% KHJ     =  BFT*(WFF(:,:,igauss)*BF(:,:,igauss));
% KJJ     =  BFT*(WFF(:,:,igauss)*BF(:,:,igauss));

% K_      =  KFF + KHH + KJJ + (KFH + KFH') + (KFJ + KFJ') + (KHJ + KHJ');
K_       =  KFF;
K        =  K + K_*IntWeight(igauss);

end    
