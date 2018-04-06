%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Types of quadrature rules: volume and surface
% Within, we can find: 
%
%  volume---->  bilinear, mass
%  surface--->  bilinear, mass, contact
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Quadrature                        =  GetQuadratureRules(Quadrature,dim) 

switch dim
    case 2
         %-----------------------------------------------------------------
         % Quadrature rule in the volume
         %-----------------------------------------------------------------
         load(['Quad_QuadRule_' num2str(Quadrature.degree)]);
         Quadrature.volume.bilinear.Chi   =  Chi;
         Quadrature.volume.bilinear.W_v   =  W_v;
    case 3
         %-----------------------------------------------------------------
         % Quadrature rule in the volume
         %-----------------------------------------------------------------
         load(['Hexa_QuadRule_' num2str(Quadrature.degree)]);
         Quadrature.volume.bilinear.Chi   =  Chi;
         Quadrature.volume.bilinear.W_v   =  W_v;
end
