%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Initialise the kinematics structure.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Kinematics  =  InitialisedKinematics(Quad,dim) 
  
ngauss               =  size(Quad.volume.bilinear.Chi,1);
Kinematics.F         =  zeros(dim,dim,ngauss);
Kinematics.H         =  zeros(dim,dim,ngauss);
Kinematics.J         =  zeros(ngauss,1);