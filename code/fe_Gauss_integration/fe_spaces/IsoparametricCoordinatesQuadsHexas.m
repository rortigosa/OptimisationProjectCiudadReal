
function [iso_coordinates,...
    oneD_isocoordinates]       =  IsoparametricCoordinatesQuadsHexas(degree,dimension)

N_nod_elem                     =  (degree+1)^(dimension);
%--------------------------------------------------------------------------
%  Initialisation of the positions in the isoparametric element
%--------------------------------------------------------------------------
xpos                           =   zeros(degree+1,1);
ypos                           =   zeros(degree+1,1);
zpos                           =   zeros(degree+1,1);
%--------------------------------------------------------------------------
% 1D positions in the isoparametric element
%--------------------------------------------------------------------------
for i=1:length(xpos)
    if degree>0
        xpos(i)                =  -1 + 2/degree*(i-1);
        ypos(i)                =  -1 + 2/degree*(i-1);
        zpos(i)                =  -1 + 2/degree*(i-1);
    else
        xpos(i)                =  0;
        ypos(i)                =  0;
        zpos(i)                =  0;
    end
end
iso_coordinates                =  zeros(N_nod_elem,dimension);
oneD_isocoordinates            =  xpos;
%--------------------------------------------------------------------------
% Positions in the isoparametric element for 1D, 2D and 3D
%--------------------------------------------------------------------------
switch dimension
    %----------------------------------------------------------------------
    % 1D case
    %----------------------------------------------------------------------
    case 1
         for i=1:degree + 1
             iso_coordinates(i,...
                 :)            =  xpos(i);
         end
    %----------------------------------------------------------------------
    % 2D case
    %----------------------------------------------------------------------
    case 2
         for j=1:degree + 1
             for i=1:degree + 1
                 iso_coordinates(i+(degree+1)*...
                     (j-1),...
                     :)        =  [xpos(i) ypos(j)];
             end
         end
    %----------------------------------------------------------------------
    % 3D case 
    %----------------------------------------------------------------------
    case 3
         for k=1:degree + 1
             for j=1:degree + 1
                 for i=1:degree + 1                 
                     iso_coordinates(i+(degree+1)*(j-1)+...
                        (degree+1)^2*(k-1),...
                        :)     =  [xpos(i) ypos(j) zpos(k)];
                 end
             end
         end
end

