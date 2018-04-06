n_node_elem  =  27;
ngauss       =  27;
nelem        =  5000;

BF           =  zeros(9,3*n_node_elem,ngauss);
DN           =  randi(10,3,n_node_elem,ngauss);
HFF          =  randi(10,9,9,ngauss);
for igauss=1:ngauss
    for inode=1:n_node_elem
        BF(1:3,1+3*(inode-1),igauss)   =  DN(:,inode,igauss);       
        BF(4:6,2+3*(inode-1),igauss)   =  DN(:,inode,igauss);       
        BF(7:9,3+3*(inode-1),igauss)   =  DN(:,inode,igauss);       
    end
end

tic
for ielem=1:nelem
    for igauss=1:ngauss
        TO1   =  BF(:,:,igauss)'*HFF(:,:,igauss)*BF(:,:,igauss);
    end
end
toc


BF1           =  BF(:,:,1);
HFF1          =  HFF(:,:,1);
tic
for ielem=1:nelem
    for igauss=1:ngauss
        TO1   =  BF1'*HFF1*BF1;
    end
end
toc


% BF   =  reshape(BF,9,3*n_node_elem*ngauss);
% HFF  =  reshape(HFF,9,9*ngauss);
% tic
% for ielem=1:nelem
%     for igauss=1:ngauss
%         a    =  (1+3*n_node_elem*(igauss-1):3*n_node_elem*igauss);
%         b    =  (1+9*(igauss-1):9*igauss);
%         TO2  =  BF(:,a)'*HFF(:,b)*BF(:,a);
%     end
% end
% toc
% 
% 

% tic
% for ielem=1:nelem
%     for anode=1:n_node_elem
%         for bnode=1:n_node_elem
%             for igauss=1:ngauss
%                 HF1313  =  HFF(1:3,1:3,igauss);
%                 HF1346  =  HFF(1:3,4:6,igauss);
%                 HF1379  =  HFF(1:3,7:9,igauss);
%                 
%                 HF4613  =  HFF(1:3,1:3,igauss);
%                 HF4646  =  HFF(1:3,4:6,igauss);
%                 HF4679  =  HFF(1:3,7:9,igauss);
%                 
%                 HF7913  =  HFF(1:3,1:3,igauss);
%                 HF7946  =  HFF(1:3,4:6,igauss);
%                 HF7979  =  HFF(1:3,7:9,igauss);
%                 
%                 HFB     =  [[HF1313*DN(:,bnode,igauss)  HF1346*DN(:,bnode,igauss)  HF1379*DN(:,bnode,igauss)];...
%                             [HF4613*DN(:,bnode,igauss)  HF4646*DN(:,bnode,igauss)  HF4679*DN(:,bnode,igauss)];...
%                             [HF7913*DN(:,bnode,igauss)  HF7946*DN(:,bnode,igauss)  HF7979*DN(:,bnode,igauss)]];
%                         
%         
%                TO      =  [DN(:,anode,igauss)'*HFB(1:3,:);...
%                            DN(:,anode,igauss)'*HFB(4:6,:);...                
%                            DN(:,anode,igauss)'*HFB(7:9,:)];
%             end
%         end
%     end
% end
% toc

asdf=98