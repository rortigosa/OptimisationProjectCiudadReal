

function geometry    =  GeometryPreprocessor

geometry.type        =  'Structured_Quad_Rectangle_Inverted';

switch geometry.type
    case 'Structured_Triad_Rectangle'    
          geometry.Lx   =  1;
          geometry.Ly   =  1;
          geometry.Nx   =  10;
          geometry.Ny   =  10;
          geometry.dim  =  2;
    case {'Structured_Quad_Rectangle','Structured_Quad_Rectangle_Inverted'}
          %geometry.Lx   =  0.8;
          %geometry.Ly   =  0.2;
          %geometry.Nx   =  80;
          %geometry.Ny   =  20;
          geometry.Lx   =  2.40;
          geometry.Ly   =  0.40;
          geometry.Nx   =  60*1;
          geometry.Ny   =  10*1;
          %geometry.Nx   =  120*1;
          %geometry.Ny   =  30*1;
          geometry.dim  =  2;
    case 'Structured_Extruded_Hexa_Prism'
          geometry.Lx   =  1;
          geometry.Ly   =  1;
          geometry.Nx   =  17;
          geometry.Ny   =  17;
          geometry.Nz   =  17;
          thickness     =  1;
          geometry.thickness =  repmat(thickness/geometry.Nz,geometry.Nz,1);
          str.geometry.dim   =  3;
    case 'Structured_Tet_Prism'
          geometry.Lx   =  1;
          geometry.Ly   =  1;
          geometry.Lz   =  1;
          geometry.Nx   =  10;
          geometry.Ny   =  10;
          geometry.Nz   =  10;
          geometry.dim  =  3;
    case 'Structured_Hexa_Prism'
          geometry.Lx   =  1;
          geometry.Ly   =  1;
          geometry.Lz   =  1;
          geometry.Nx   =  10;
          geometry.Ny   =  10;
          geometry.Nz   =  10;
          geometry.dim  =  3;
    case 'Structured_Quad_Circle'
          geometry.r        =  1;
          geometry.Nr       =  1;
          geometry.Ntheta   =  1;
          geometry.dim      =  2;
    case 'Structured_Extruded_Hexa_Cilinder'
          geometry.r          =  1;
          geometry.Nr         =  10;
          geometry.Ntheta     =  10;
          geometry.Nz         =  10;
          thickness           =  1;
          geometry.thickness  =  repmat(thickness/geometry.Nz,geometry.Nz,1);
          geometry.dim        =  3;
end        

