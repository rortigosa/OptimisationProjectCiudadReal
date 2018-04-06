function [nodes,...
          connectivity]              =  StructuredHexaMeshGenerator(degree,Lx,Ly,Lz,...
                                                                 Nx,Ny,Nz)


Dx                                   =  Lx/Nx/(degree);
Dy                                   =  Ly/Ny/(degree);
Dz                                   =  Lz/Nz/(degree);

X                                    =  (-Lx/2:Dx:Lx/2);
Y                                    =  (Ly/2:-Dy:-Ly/2);
Z                                    =  (-Lz/2:Dz:Lz/2);

Y_                                   =  repmat(Y,(size(X,2)*size(Z,2)),1);
Y_                                   =  Y_';
Y_                                   =  Y_(:);

X_                                   =  repmat(X,(size(Y,2)),1);
X_                                   =  X_(:);
X_                                   =  repmat(X_,size(Z,2),1);

Z_                                   =  repmat(Z,(size(X,2)*size(Y,2)),1);
Z_                                   =  Z_(:);

switch degree
    case 0
         nodes                       =  zeros(Nx*Ny,3); 
    otherwise
         nodes =  [X_  Y_  Z_];
end

switch degree
    case 0
         connectivity                =  (1:Nx*Ny*Nz)';         
    otherwise
         connectivity                =  zeros(8,Nx*Ny*Nz);
         ielem                       =  1;
         for iz=1:Nz
             for ix=1:Nx
                 for iy=1:Ny                     
                     connectivity(1,ielem)  =  iy + 0 + (ix-1)*(Ny+1) + (iz-1)*(Ny+1)*(Nx+1);
                     connectivity(2,ielem)  =  iy + 1 + (ix-1)*(Ny+1) + (iz-1)*(Ny+1)*(Nx+1);
                     connectivity(3,ielem)  =  iy + 0 + (ix-0)*(Ny+1) + (iz-1)*(Ny+1)*(Nx+1);
                     connectivity(4,ielem)  =  iy + 1 + (ix-0)*(Ny+1) + (iz-1)*(Ny+1)*(Nx+1);

                     connectivity(5,ielem)  =  iy + 0 + (ix-1)*(Ny+1) + (iz-0)*(Ny+1)*(Nx+1);
                     connectivity(6,ielem)  =  iy + 1 + (ix-1)*(Ny+1) + (iz-0)*(Ny+1)*(Nx+1);
                     connectivity(7,ielem)  =  iy + 0 + (ix-0)*(Ny+1) + (iz-0)*(Ny+1)*(Nx+1);
                     connectivity(8,ielem)  =  iy + 1 + (ix-0)*(Ny+1) + (iz-0)*(Ny+1)*(Nx+1);
                     
                     ielem               =  ielem + 1;                     
                 end
             end
         end
end

nodes                                =  nodes';



