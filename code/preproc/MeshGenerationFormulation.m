%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% 
% Create the FEM mesh for different 
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Mesh  =  MeshGenerationFormulation(FEM,Geometry,formulation)

switch formulation
    case 'u'
         Mesh      =  MeshU(FEM,Geometry);
    case 'up'
         %str      =  MeshUP(str);
end
