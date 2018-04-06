function [nodes,connectivity]        =  SquaredStructuredMeshGenerator(degree,Lx,Ly,Nx,Ny)


Dx                                   =  Lx/Nx/(degree);
Dy                                   =  Ly/Ny/(degree);

X                                    =  (-Lx/2:Dx:Lx/2);
Y                                    =  (-Ly/2:Dy:Ly/2);

X_                                   =  repmat(X,(size(Y,2)),1);
X_                                   =  X_';
X_                                   =  X_(:);

Y_                                   =  repmat(Y,(size(X,2)),1);
Y_                                   =  Y_(:);
Z_                                   =  zeros(size(Y_,1),1);
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
         for iy=1:Ny
             for ix=1:Nx
                 inode               =  1;
                 for idegreey=1:degree + 1
                     for idegreex=1:degree + 1
                         connectivity(ielem,...
                             inode)  =  ix + (idegreex - 1) + (Nx*degree+1)*(idegreey - 1) + (ix-1)*(degree-1) + (iy-1)*((Nx*degree + 1)*degree);
                         inode       =  inode + 1;
                     end
                 end
                 ielem               =  ielem + 1;
             end
         end
end



