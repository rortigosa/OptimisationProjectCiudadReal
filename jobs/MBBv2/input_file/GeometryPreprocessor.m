

function geometry             =  GeometryPreprocessor

geometry.type                 =  'Structured_Quad_Rectangle_Inverted';
geometry.PlaneStress          =  1;  % 1 is Plane stress, 0 is not
geometry.thickness            =  0.01;
geometry.thickness            =  0.01;
if ~geometry.PlaneStress
   geometry.thickness         =  1;
end

switch geometry.type
    case 'Structured_Triad_Rectangle'    
          geometry.Lx         =  1;
          geometry.Ly         =  1;
          geometry.Nx         =  10;
          geometry.Ny         =  10;
          geometry.dim        =  2;
    case {'Structured_Quad_Rectangle','Structured_Quad_Rectangle_Inverted'}
          geometry.Lx         =  1.20;
          geometry.Ly         =  0.40;
          geometry.Nx         =  120*1;
          geometry.Ny         =  40*1;
          %geometry.Nx        =  120*1;
          %geometry.Ny        =  30*1;
          geometry.dim        =  2;
    case 'Structured_Extruded_Hexa_Prism'
          geometry.Lx         =  1;
          geometry.Ly         =  1;
          geometry.Nx         =  17;
          geometry.Ny         =  17;
          geometry.Nz         =  17;
          thickness           =  1;
          geometry.thickness  =  repmat(thickness/geometry.Nz,geometry.Nz,1);
          geometry.dim        =  3;
    case 'Structured_Tet_Prism'
          geometry.Lx         =  1;
          geometry.Ly         =  1;
          geometry.Lz         =  1;
          geometry.Nx         =  10;
          geometry.Ny         =  10;
          geometry.Nz         =  10;
          geometry.dim        =  3;
    case 'Structured_Hexa_Prism'
          geometry.Lx         =  1;
          geometry.Ly         =  1;
          geometry.Lz         =  1;
          geometry.Nx         =  10;
          geometry.Ny         =  10;
          geometry.Nz         =  10;
          geometry.dim        =  3;
    case 'Structured_Quad_Circle'
          geometry.r          =  1;
          geometry.Nr         =  1;
          geometry.Ntheta     =  1;
          geometry.dim        =  2;
    case 'Structured_Extruded_Hexa_Cilinder'
          geometry.r          =  1;
          geometry.Nr         =  10;
          geometry.Ntheta     =  10;
          geometry.Nz         =  10;
          thickness           =  1;
          geometry.thickness  =  repmat(thickness/geometry.Nz,geometry.Nz,1);
          geometry.dim        =  3;
end        

if geometry.dim==3
   geometry.PlaneStress       =  0;
end