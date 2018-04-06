function element_assembly         =  ElementResidualMatricesInitialisationElectroMixedIncompressible(geom,mesh)

ndof_x                            =  geom.dim*mesh.volume.x.n_node_elem;
ndof_phi                          =  mesh.volume.phi.n_node_elem;
ndof_p                            =  mesh.volume.pressure.n_node_elem;

ndof_F                            =  geom.dim^2*mesh.volume.F.n_node_elem;
ndof_H                            =  geom.dim^2*mesh.volume.H.n_node_elem;
ndof_J                            =  mesh.volume.J.n_node_elem;
ndof_D0                           =  geom.dim*mesh.volume.D0.n_node_elem;
ndof_d                            =  geom.dim*mesh.volume.d.n_node_elem;
%--------------------------------------------------------------------------
% Residual vectors per element
%--------------------------------------------------------------------------
element_assembly.Tx               =  zeros(ndof_x,1);
element_assembly.Tphi             =  zeros(ndof_phi,1);  
element_assembly.Tp               =  zeros(ndof_p,1);  

element_assembly.TF               =  zeros(ndof_F,1);
element_assembly.TH               =  zeros(ndof_H,1);
element_assembly.TJ               =  zeros(ndof_J,1);
element_assembly.TD0              =  zeros(ndof_D0,1);
element_assembly.Td               =  zeros(ndof_d,1);
   
element_assembly.TSigmaF          =  zeros(ndof_F,1);
element_assembly.TSigmaH          =  zeros(ndof_H,1);
element_assembly.TSigmaJ          =  zeros(ndof_J,1);
element_assembly.TSigmaD0         =  zeros(ndof_D0,1);
element_assembly.TSigmad          =  zeros(ndof_d,1);
%--------------------------------------------------------------------------
% Stiffness matrices per element
%--------------------------------------------------------------------------
element_assembly.Kxx              =  zeros(ndof_x,ndof_x);
element_assembly.Kxphi            =  zeros(ndof_x,ndof_phi);
element_assembly.Kxp              =  zeros(ndof_x,ndof_p);
element_assembly.KxF              =  zeros(ndof_x,ndof_F);
element_assembly.KxH              =  zeros(ndof_x,ndof_H);
element_assembly.KxJ              =  zeros(ndof_x,ndof_J);
element_assembly.KxD0             =  zeros(ndof_x,ndof_D0);
element_assembly.Kxd              =  zeros(ndof_x,ndof_d);
element_assembly.KxSigmaF         =  zeros(ndof_x,ndof_F);
element_assembly.KxSigmaH         =  zeros(ndof_x,ndof_H);
element_assembly.KxSigmaJ         =  zeros(ndof_x,ndof_J);
element_assembly.KxSigmad         =  zeros(ndof_x,ndof_d);

element_assembly.Kphix            =  zeros(ndof_phi,ndof_x);
element_assembly.Kphiphi          =  zeros(ndof_phi,ndof_phi);
element_assembly.Kphip            =  zeros(ndof_phi,ndof_p);
element_assembly.KphiF            =  zeros(ndof_phi,ndof_F);
element_assembly.KphiH            =  zeros(ndof_phi,ndof_H);
element_assembly.KphiJ            =  zeros(ndof_phi,ndof_J);
element_assembly.KphiD0           =  zeros(ndof_phi,ndof_D0);
element_assembly.Kphid            =  zeros(ndof_phi,ndof_d);
element_assembly.KphiSigmaF       =  zeros(ndof_phi,ndof_F);
element_assembly.KphiSigmaH       =  zeros(ndof_phi,ndof_H);
element_assembly.KphiSigmaJ       =  zeros(ndof_phi,ndof_J);
element_assembly.KphiSigmad       =  zeros(ndof_phi,ndof_d);

element_assembly.Kpx              =  zeros(ndof_p,ndof_x);
element_assembly.Kpphi            =  zeros(ndof_p,ndof_phi);
element_assembly.Kpp              =  zeros(ndof_p,ndof_p);
element_assembly.KpF              =  zeros(ndof_p,ndof_F);
element_assembly.KpH              =  zeros(ndof_p,ndof_H);
element_assembly.KpJ              =  zeros(ndof_p,ndof_J);
element_assembly.KpD0             =  zeros(ndof_p,ndof_D0);
element_assembly.Kpd              =  zeros(ndof_p,ndof_d);
element_assembly.KpSigmaF         =  zeros(ndof_p,ndof_F);
element_assembly.KpSigmaH         =  zeros(ndof_p,ndof_H);
element_assembly.KpSigmaJ         =  zeros(ndof_p,ndof_J);
element_assembly.KpSigmad         =  zeros(ndof_p,ndof_d);

element_assembly.KFx              =  zeros(ndof_F,ndof_x);
element_assembly.KFphi            =  zeros(ndof_F,ndof_phi);
element_assembly.KFp              =  zeros(ndof_F,ndof_p);
element_assembly.KFF              =  zeros(ndof_F,ndof_F);
element_assembly.KFH              =  zeros(ndof_F,ndof_H);
element_assembly.KFJ              =  zeros(ndof_F,ndof_J);
element_assembly.KFD0             =  zeros(ndof_F,ndof_D0);
element_assembly.KFd              =  zeros(ndof_F,ndof_d);
element_assembly.KFSigmaF         =  zeros(ndof_F,ndof_F);
element_assembly.KFSigmaH         =  zeros(ndof_F,ndof_H);
element_assembly.KFSigmaJ         =  zeros(ndof_F,ndof_J);
element_assembly.KFSigmad         =  zeros(ndof_F,ndof_d);

element_assembly.KHx              =  zeros(ndof_H,ndof_x);
element_assembly.KHphi            =  zeros(ndof_H,ndof_phi);
element_assembly.KHp              =  zeros(ndof_H,ndof_p);
element_assembly.KHF              =  zeros(ndof_H,ndof_F);
element_assembly.KHH              =  zeros(ndof_H,ndof_H);
element_assembly.KHJ              =  zeros(ndof_H,ndof_J);
element_assembly.KHD0             =  zeros(ndof_H,ndof_D0);
element_assembly.KHd              =  zeros(ndof_H,ndof_d);
element_assembly.KHSigmaF         =  zeros(ndof_H,ndof_F);
element_assembly.KHSigmaH         =  zeros(ndof_H,ndof_H);
element_assembly.KHSigmaJ         =  zeros(ndof_H,ndof_J);
element_assembly.KHSigmad         =  zeros(ndof_H,ndof_d);

element_assembly.KJx              =  zeros(ndof_J,ndof_x);
element_assembly.KJphi            =  zeros(ndof_J,ndof_phi);
element_assembly.KJp              =  zeros(ndof_J,ndof_p);
element_assembly.KJF              =  zeros(ndof_J,ndof_F);
element_assembly.KJH              =  zeros(ndof_J,ndof_H);
element_assembly.KJJ              =  zeros(ndof_J,ndof_J);
element_assembly.KJD0             =  zeros(ndof_J,ndof_D0);
element_assembly.KJd              =  zeros(ndof_J,ndof_d);
element_assembly.KJSigmaF         =  zeros(ndof_J,ndof_F);
element_assembly.KJSigmaH         =  zeros(ndof_J,ndof_H);
element_assembly.KJSigmaJ         =  zeros(ndof_J,ndof_J);
element_assembly.KJSigmad         =  zeros(ndof_J,ndof_d);

element_assembly.KD0x              =  zeros(ndof_D0,ndof_x);
element_assembly.KD0phi            =  zeros(ndof_D0,ndof_phi);
element_assembly.KD0p              =  zeros(ndof_D0,ndof_p);
element_assembly.KD0F              =  zeros(ndof_D0,ndof_F);
element_assembly.KD0H              =  zeros(ndof_D0,ndof_H);
element_assembly.KD0J              =  zeros(ndof_D0,ndof_J);
element_assembly.KD0D0             =  zeros(ndof_D0,ndof_D0);
element_assembly.KD0d              =  zeros(ndof_D0,ndof_d);
element_assembly.KD0SigmaF         =  zeros(ndof_D0,ndof_F);
element_assembly.KD0SigmaH         =  zeros(ndof_D0,ndof_H);
element_assembly.KD0SigmaJ         =  zeros(ndof_D0,ndof_J);
element_assembly.KD0Sigmad         =  zeros(ndof_D0,ndof_d);

element_assembly.Kdx              =  zeros(ndof_d,ndof_x);
element_assembly.Kdphi            =  zeros(ndof_d,ndof_phi);
element_assembly.Kdp              =  zeros(ndof_d,ndof_p);
element_assembly.KdF              =  zeros(ndof_d,ndof_F);
element_assembly.KdH              =  zeros(ndof_d,ndof_H);
element_assembly.KdJ              =  zeros(ndof_d,ndof_J);
element_assembly.KdD0             =  zeros(ndof_d,ndof_D0);
element_assembly.Kdd              =  zeros(ndof_d,ndof_d);
element_assembly.KdSigmaF         =  zeros(ndof_d,ndof_F);
element_assembly.KdSigmaH         =  zeros(ndof_d,ndof_H);
element_assembly.KdSigmaJ         =  zeros(ndof_d,ndof_J);
element_assembly.KdSigmad         =  zeros(ndof_d,ndof_d);

element_assembly.KSigmaFx         =  zeros(ndof_F,ndof_x);
element_assembly.KSigmaFphi       =  zeros(ndof_F,ndof_phi);
element_assembly.KSigmaFp         =  zeros(ndof_F,ndof_p);
element_assembly.KSigmaFF         =  zeros(ndof_F,ndof_F);
element_assembly.KSigmaFH         =  zeros(ndof_F,ndof_H);
element_assembly.KSigmaFJ         =  zeros(ndof_F,ndof_J);
element_assembly.KSigmaFD0        =  zeros(ndof_F,ndof_D0);
element_assembly.KSigmaFd         =  zeros(ndof_F,ndof_d);
element_assembly.KSigmaFSigmaF    =  zeros(ndof_F,ndof_F);
element_assembly.KSigmaFSigmaH    =  zeros(ndof_F,ndof_H);
element_assembly.KSigmaFSigmaJ    =  zeros(ndof_F,ndof_J);
element_assembly.KSigmaFSigmad    =  zeros(ndof_F,ndof_d);

element_assembly.KSigmaHx         =  zeros(ndof_H,ndof_x);
element_assembly.KSigmaHphi       =  zeros(ndof_H,ndof_phi);
element_assembly.KSigmaHp         =  zeros(ndof_H,ndof_p);
element_assembly.KSigmaHF         =  zeros(ndof_H,ndof_F);
element_assembly.KSigmaHH         =  zeros(ndof_H,ndof_H);
element_assembly.KSigmaHJ         =  zeros(ndof_H,ndof_J);
element_assembly.KSigmaHD0        =  zeros(ndof_H,ndof_D0);
element_assembly.KSigmaHd         =  zeros(ndof_H,ndof_d);
element_assembly.KSigmaHSigmaF    =  zeros(ndof_H,ndof_F);
element_assembly.KSigmaHSigmaH    =  zeros(ndof_H,ndof_H);
element_assembly.KSigmaHSigmaJ    =  zeros(ndof_H,ndof_J);
element_assembly.KSigmaHSigmad    =  zeros(ndof_H,ndof_d);

element_assembly.KSigmaJx         =  zeros(ndof_J,ndof_x);
element_assembly.KSigmaJphi       =  zeros(ndof_J,ndof_phi);
element_assembly.KSigmaJp         =  zeros(ndof_J,ndof_p);
element_assembly.KSigmaJF         =  zeros(ndof_J,ndof_F);
element_assembly.KSigmaJH         =  zeros(ndof_J,ndof_H);
element_assembly.KSigmaJJ         =  zeros(ndof_J,ndof_J);
element_assembly.KSigmaJD0        =  zeros(ndof_J,ndof_D0);
element_assembly.KSigmaJd         =  zeros(ndof_J,ndof_d);
element_assembly.KSigmaJSigmaF    =  zeros(ndof_J,ndof_F);
element_assembly.KSigmaJSigmaH    =  zeros(ndof_J,ndof_H);
element_assembly.KSigmaJSigmaJ    =  zeros(ndof_J,ndof_J);
element_assembly.KSigmaJSigmad    =  zeros(ndof_J,ndof_d);

element_assembly.KSigmadx         =  zeros(ndof_d,ndof_x);
element_assembly.KSigmadphi       =  zeros(ndof_d,ndof_phi);
element_assembly.KSigmadp         =  zeros(ndof_d,ndof_p);
element_assembly.KSigmadF         =  zeros(ndof_d,ndof_F);
element_assembly.KSigmadH         =  zeros(ndof_d,ndof_H);
element_assembly.KSigmadJ         =  zeros(ndof_d,ndof_J);
element_assembly.KSigmadD0        =  zeros(ndof_d,ndof_D0);
element_assembly.KSigmadd         =  zeros(ndof_d,ndof_d);
element_assembly.KSigmadSigmaF    =  zeros(ndof_d,ndof_F);
element_assembly.KSigmadSigmaH    =  zeros(ndof_d,ndof_H);
element_assembly.KSigmadSigmaJ    =  zeros(ndof_d,ndof_J);
element_assembly.KSigmadSigmad    =  zeros(ndof_d,ndof_d);
