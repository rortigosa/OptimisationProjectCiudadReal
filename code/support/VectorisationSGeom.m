%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% In this function the vectorisation of the geometric term associated to
% second piola is computed:
%
%   Svect  =  [[S+S'  03x3];[03x3  S+S']];  in 2D   or
%   Svect  =  [[S+S'  03x3  03x3];[03x3  S+S'  03x3];[03x3  03x3  S+S']];  in 3D
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


function Svect         =  VectorisationSGeom(dim,ngauss,S,vect)

Svect                  =  zeros(dim^2,dim^2,ngauss); 
Sprov                  =  zeros(dim^2,dim^2);  

for igauss=1:ngauss
    Sprov(vect.LHS)    =  S(vect.RHS1) + S(vect.RHS2); 
    Svect(:,:,igauss)  =  Sprov;  
end

