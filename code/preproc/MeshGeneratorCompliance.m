%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Mesh generators
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [nodes,...
    connectivity]        =  MeshGeneratorCompliance(str,degree,continuity,DN_chi_nodes)

switch str.geometry.type
    case 'Structured_Triad_Rectangle'    
         [nodes,...
          connectivity]  =  StructuredTriadRectangleMeshGenerator(degree,str.geometry.StructuredTriadRectangle.Lx,...
                                                                          str.geometry.StructuredTriadRectangle.Ly,...
                                                                          str.geometry.StructuredTriadRectangle.Nx,...
                                                                          str.geometry.StructuredTriadRectangle.Ny);                                                                      
    case 'Structured_Quad_Rectangle'    
         [nodes,...
          connectivity]  =  StructuredQuadRectangleMeshGenerator(degree,str.geometry.StructuredQuadRectangle.Lx,...
                                                                         str.geometry.StructuredQuadRectangle.Ly,...
                                                                         str.geometry.StructuredQuadRectangle.Nx,...
                                                                         str.geometry.StructuredQuadRectangle.Ny);
    case 'Structured_Extruded_Hexa_Prism'
         [nodes,...
          connectivity]  =  StructuredExtrudedHexaPrismMeshGenerator(degree,str.geometry.StructuredExtrudedHexaPrism.Lx,...
                                                                             str.geometry.StructuredExtrudedHexaPrism.Ly,...
                                                                             str.geometry.StructuredExtrudedHexaPrism.Nx,...
                                                                             str.geometry.StructuredExtrudedHexaPrism.Ny,...
                                                                             str.geometry.StructuredExtrudedHexaPrism.Nz,...
                                                                             str.geometry.StructuredExtrudedHexaPrism.thickness,...
                                                                             DN_chi_nodes);
    case 'Structured_Tet_Prism'
         [nodes,...
          connectivity]  =  StructuredTetPrismMeshGenerator(degree,str.geometry.StructuredTetPrism.Lx,...
                                                                    str.geometry.StructuredTetPrism.Ly,...
                                                                    str.geometry.StructuredTetPrism.Lz,...
                                                                    str.geometry.StructuredTetPrism.Nx,...
                                                                    str.geometry.StructuredTetPrism.Ny,...
                                                                    str.geometry.StructuredTetPrism.Nz);        
    case 'Structured_Hexa_Prism'
         [nodes,...
          connectivity]  =  StructuredHexaPrismMeshGenerator(degree,str.geometry.StructuredHexaPrism.Lx,...
                                                                     str.geometry.StructuredHexaPrism.Ly,...
                                                                     str.geometry.StructuredHexaPrism.Lz,...
                                                                     str.geometry.StructuredHexaPrism.Nx,...
                                                                     str.geometry.StructuredHexaPrism.Ny,...
                                                                     str.geometry.StructuredHexaPrism.Nz);        
    case 'Structured_Quad_Circle'
         [nodes,...
          connectivity]  =  StructuredQuadCircleMeshGenerator(degree,str.geometry.StructuredQuadCircle.r,...
                                                                      str.geometry.StructuredQuadCircle.Nr,...
                                                                      str.geometry.StructuredQuadCircle.Ntheta);        
    case 'Structured_Extruded_Hexa_Cilinder'
         [nodes,...
          connectivity]  =  StructuredExtrudedHexaCilinderMeshGenerator(degree,str.geometry.StructuredExtrudedHexaCilinder.r,...
                                                                      str.geometry.StructuredExtrudedHexaCilinder.Nr,...
                                                                      str.geometry.StructuredExtrudedHexaCilinder.Ntheta,...
                                                                      str.geometry.StructuredExtrudedHexaCilinder.thickness,...
                                                                      DN_chi_nodes);        
    otherwise
         [nodes,...
          connectivity]  =  MeshReadingFile;
end        
%--------------------------------------------------------------------------        
% Include discontinuous meshing if prescribed
%--------------------------------------------------------------------------        
switch continuity
    case 'continuous'         
    case 'discontinuous'
         [nodes,connectivity]   =  DiscontinuousMeshing(nodes,connectivity);
end

