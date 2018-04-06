%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% 
% In this function, FEM interpolation of the following fields is carried
% out: (F,H,J,D0,d), (SigmaF,SigmaH,SigmaJ,Sigmad) and pressure
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [C,Cvectorised,G,...
     Gvectorised,c,...
    SigmaC,SigmaCvectorised,...
    SigmaG,SigmaGvectorised,...
    Sigmac]           =  CGCFEMFieldsInterpolation(ielem,dim,ngauss,fem,solution,mesh_C,mesh_G,mesh_c)

%--------------------------------------------------------------------------
% Interpolation of F field
%--------------------------------------------------------------------------
Celem_vectorised        =  solution.C(:,mesh_C.connectivity(:,ielem));
Cvectorised             =  VectorFEMInterpolation(ngauss,fem.volume.bilinear.C.N,Celem_vectorised);
C                       =  permute((reshape(Cvectorised,dim,dim,[])),[2 1 3]);
%--------------------------------------------------------------------------
% Interpolation of H field
%--------------------------------------------------------------------------
Gelem_vectorised        =  solution.G(:,mesh_G.connectivity(:,ielem));
Gvectorised             =  VectorFEMInterpolation(ngauss,fem.volume.bilinear.G.N,Gelem_vectorised);
G                       =  permute((reshape(Gvectorised,dim,dim,[])),[2 1 3]);
%--------------------------------------------------------------------------
% Interpolation of J field
%--------------------------------------------------------------------------
c                       =  ScalarFEMInterpolation(fem.volume.bilinear.c.N,...
                                                 solution.c(mesh_c.connectivity(:,ielem)));                                         
%--------------------------------------------------------------------------
% Interpolation of SigmaC field
%--------------------------------------------------------------------------                                             
SigmaCelem_vectorised   =  solution.SigmaC(:,mesh_C.connectivity(:,ielem));
SigmaCvectorised        =  VectorFEMInterpolation(ngauss,fem.volume.bilinear.C.N,SigmaCelem_vectorised);
SigmaC                  =  permute((reshape(SigmaCvectorised,dim,dim,[])),[2 1 3]);
%--------------------------------------------------------------------------
% Interpolation of SigmaG field
%--------------------------------------------------------------------------                                             
SigmaGelem_vectorised   =  solution.SigmaG(:,mesh_G.connectivity(:,ielem));
SigmaGvectorised        =  VectorFEMInterpolation(ngauss,fem.volume.bilinear.G.N,SigmaGelem_vectorised);
SigmaG                  =  permute((reshape(SigmaGvectorised,dim,dim,[])),[2 1 3]);
%--------------------------------------------------------------------------
% Interpolation of SigmaJ field
%--------------------------------------------------------------------------                                             
Sigmac                  =  ScalarFEMInterpolation(fem.volume.bilinear.c.N,...
                                                 solution.Sigmac(mesh_c.connectivity(:,ielem)));                                         
