function [nodes,...
          connectivity]              =  StructuredHexaMeshGenerator(degree,Lx,Ly,...
                                                                 Nx,Ny)


Dx                                   =  Lx/Nx/(degree);
Dy                                   =  Ly/Ny/(degree);

X                                    =  (-Lx/2:Dx:Lx/2);
Y                                    =  (Ly/2:-Dy:-Ly/2);


Y_                                   =  repmat(Y,(size(X,2)),1);
Y_                                   =  Y_';
Y_                                   =  Y_(:);

X_                                   =  repmat(X,(size(Y,2)),1);
X_                                   =  X_(:);
Z_                                   =  zeros(size(X_,1),1);

switch degree
    case 0
         nodes                       =  zeros(Nx*Ny,3); 
    otherwise
         nodes =  [X_  Y_  Z_];
end

switch degree
    case 0
         connectivity                =  (1:Nx*Ny)';         
    otherwise
         connectivity                =  zeros(Nx*Ny,sum(1:degree+1));
         ielem                       =  1;
         for ix=1:Nx
             for iy=1:Ny
                 inode               =  1;
                 for idegreex=1:degree + 1
                     for idegreey=1:degree + 1
                         connectivity(ielem,...
                             inode)  =  iy + (idegreey - 1) + (Ny*degree+1)*(idegreex - 1) + (iy-1)*(degree-1) + (ix-1)*((Ny*degree + 1)*degree);
                         inode       =  inode + 1;
                     end
                 end
                 ielem               =  ielem + 1;
             end
         end
end

nodes                                =  nodes';
nodes(3,:)                           =  [];
connectivity                         =  connectivity';



