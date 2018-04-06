function [nodes_3D,...
          connectivity_3D]     =  StructuredExtrudedHexaCilinderMeshGenerator(degree,r,Nr,...
                                                                 Ntheta,Nz,thickness,Nshape)

[nodes,connectivity]           =  StructuredQuadCircleMeshGenerator(degree,r,Nr,Ntheta);
[nodes_3D,connectivity_3D]     =  ThreeDSolidShellReconstruction(nodes',connectivity',degree,Nz,thickness,Nshape);


