function element_assembly         =  ElementResidualMatricesInitialisationFHJ(geom,mesh)

ndof_x                            =  geom.dim*mesh.volume.x.n_node_elem;

ndof_F                            =  geom.dim^2*mesh.volume.F.n_node_elem;
ndof_H                            =  geom.dim^2*mesh.volume.H.n_node_elem;
ndof_J                            =  mesh.volume.J.n_node_elem;
%--------------------------------------------------------------------------
% Residual vectors per element
%--------------------------------------------------------------------------
element_assembly.Tx               =  zeros(ndof_x,1);

element_assembly.TF               =  zeros(ndof_F,1);
element_assembly.TH               =  zeros(ndof_H,1);
element_assembly.TJ               =  zeros(ndof_J,1);
   
element_assembly.TSigmaF          =  zeros(ndof_F,1);
element_assembly.TSigmaH          =  zeros(ndof_H,1);
element_assembly.TSigmaJ          =  zeros(ndof_J,1);
%--------------------------------------------------------------------------
% Stiffness matrices per element
%--------------------------------------------------------------------------
element_assembly.Kxx              =  zeros(ndof_x,ndof_x);
element_assembly.KxF              =  zeros(ndof_x,ndof_F);
element_assembly.KxH              =  zeros(ndof_x,ndof_H);
element_assembly.KxJ              =  zeros(ndof_x,ndof_J);
element_assembly.KxSigmaF         =  zeros(ndof_x,ndof_F);
element_assembly.KxSigmaH         =  zeros(ndof_x,ndof_H);
element_assembly.KxSigmaJ         =  zeros(ndof_x,ndof_J);

element_assembly.KFx              =  zeros(ndof_F,ndof_x);
element_assembly.KFF              =  zeros(ndof_F,ndof_F);
element_assembly.KFH              =  zeros(ndof_F,ndof_H);
element_assembly.KFJ              =  zeros(ndof_F,ndof_J);
element_assembly.KFSigmaF         =  zeros(ndof_F,ndof_F);
element_assembly.KFSigmaH         =  zeros(ndof_F,ndof_H);
element_assembly.KFSigmaJ         =  zeros(ndof_F,ndof_J);

element_assembly.KHx              =  zeros(ndof_H,ndof_x);
element_assembly.KHF              =  zeros(ndof_H,ndof_F);
element_assembly.KHH              =  zeros(ndof_H,ndof_H);
element_assembly.KHJ              =  zeros(ndof_H,ndof_J);
element_assembly.KHSigmaF         =  zeros(ndof_H,ndof_F);
element_assembly.KHSigmaH         =  zeros(ndof_H,ndof_H);
element_assembly.KHSigmaJ         =  zeros(ndof_H,ndof_J);

element_assembly.KJx              =  zeros(ndof_J,ndof_x);
element_assembly.KJF              =  zeros(ndof_J,ndof_F);
element_assembly.KJH              =  zeros(ndof_J,ndof_H);
element_assembly.KJJ              =  zeros(ndof_J,ndof_J);
element_assembly.KJSigmaF         =  zeros(ndof_J,ndof_F);
element_assembly.KJSigmaH         =  zeros(ndof_J,ndof_H);
element_assembly.KJSigmaJ         =  zeros(ndof_J,ndof_J);

element_assembly.KSigmaFx         =  zeros(ndof_F,ndof_x);
element_assembly.KSigmaFF         =  zeros(ndof_F,ndof_F);
element_assembly.KSigmaFH         =  zeros(ndof_F,ndof_H);
element_assembly.KSigmaFJ         =  zeros(ndof_F,ndof_J);
element_assembly.KSigmaFSigmaF    =  zeros(ndof_F,ndof_F);
element_assembly.KSigmaFSigmaH    =  zeros(ndof_F,ndof_H);
element_assembly.KSigmaFSigmaJ    =  zeros(ndof_F,ndof_J);

element_assembly.KSigmaHx         =  zeros(ndof_H,ndof_x);
element_assembly.KSigmaHF         =  zeros(ndof_H,ndof_F);
element_assembly.KSigmaHH         =  zeros(ndof_H,ndof_H);
element_assembly.KSigmaHJ         =  zeros(ndof_H,ndof_J);
element_assembly.KSigmaHSigmaF    =  zeros(ndof_H,ndof_F);
element_assembly.KSigmaHSigmaH    =  zeros(ndof_H,ndof_H);
element_assembly.KSigmaHSigmaJ    =  zeros(ndof_H,ndof_J);

element_assembly.KSigmaJx         =  zeros(ndof_J,ndof_x);
element_assembly.KSigmaJF         =  zeros(ndof_J,ndof_F);
element_assembly.KSigmaJH         =  zeros(ndof_J,ndof_H);
element_assembly.KSigmaJJ         =  zeros(ndof_J,ndof_J);
element_assembly.KSigmaJSigmaF    =  zeros(ndof_J,ndof_F);
element_assembly.KSigmaJSigmaH    =  zeros(ndof_J,ndof_H);
element_assembly.KSigmaJSigmaJ    =  zeros(ndof_J,ndof_J);

