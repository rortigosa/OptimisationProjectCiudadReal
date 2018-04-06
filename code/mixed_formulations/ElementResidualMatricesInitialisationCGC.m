function element_assembly         =  ElementResidualMatricesInitialisationCGC(geom,mesh)

ndof_x                            =  geom.dim*mesh.volume.x.n_node_elem;

ndof_C                            =  geom.dim^2*mesh.volume.C.n_node_elem;
ndof_G                            =  geom.dim^2*mesh.volume.G.n_node_elem;
ndof_c                            =  mesh.volume.c.n_node_elem;
%--------------------------------------------------------------------------
% Residual vectors per element
%--------------------------------------------------------------------------
element_assembly.Tx               =  zeros(ndof_x,1);

element_assembly.TC               =  zeros(ndof_C,1);
element_assembly.TG               =  zeros(ndof_G,1);
element_assembly.Tc               =  zeros(ndof_c,1);
   
element_assembly.TSigmaC          =  zeros(ndof_C,1);
element_assembly.TSigmaG          =  zeros(ndof_G,1);
element_assembly.TSigmac          =  zeros(ndof_c,1);
%--------------------------------------------------------------------------
% Stiffness matrices per element
%--------------------------------------------------------------------------
element_assembly.Kxx              =  zeros(ndof_x,ndof_x);
element_assembly.KxC              =  zeros(ndof_x,ndof_c);
element_assembly.KxG              =  zeros(ndof_x,ndof_G);
element_assembly.Kxc              =  zeros(ndof_x,ndof_c);
element_assembly.KxSigmaC         =  zeros(ndof_x,ndof_C);
element_assembly.KxSigmaG         =  zeros(ndof_x,ndof_G);
element_assembly.KxSigmac         =  zeros(ndof_x,ndof_c);

element_assembly.KCx              =  zeros(ndof_C,ndof_x);
element_assembly.KCC              =  zeros(ndof_C,ndof_C);
element_assembly.KCG              =  zeros(ndof_C,ndof_G);
element_assembly.KCc              =  zeros(ndof_C,ndof_c);
element_assembly.KCSigmaC         =  zeros(ndof_C,ndof_C);
element_assembly.KCSigmaG         =  zeros(ndof_C,ndof_G);
element_assembly.KCSigmac         =  zeros(ndof_C,ndof_c);

element_assembly.KGx              =  zeros(ndof_G,ndof_x);
element_assembly.KGC              =  zeros(ndof_G,ndof_C);
element_assembly.KGG              =  zeros(ndof_G,ndof_G);
element_assembly.KGc              =  zeros(ndof_G,ndof_c);
element_assembly.KGSigmaC         =  zeros(ndof_G,ndof_C);
element_assembly.KGSigmaG         =  zeros(ndof_G,ndof_G);
element_assembly.KGSigmac         =  zeros(ndof_G,ndof_c);

element_assembly.Kcx              =  zeros(ndof_c,ndof_x);
element_assembly.KcC              =  zeros(ndof_c,ndof_C);
element_assembly.KcG              =  zeros(ndof_c,ndof_G);
element_assembly.Kcc              =  zeros(ndof_c,ndof_c);
element_assembly.KcSigmaC         =  zeros(ndof_c,ndof_C);
element_assembly.KcSigmaG         =  zeros(ndof_c,ndof_G);
element_assembly.KcSigmac         =  zeros(ndof_c,ndof_c);

element_assembly.KSigmaCx         =  zeros(ndof_C,ndof_x);
element_assembly.KSigmaCC         =  zeros(ndof_C,ndof_C);
element_assembly.KSigmaCG         =  zeros(ndof_C,ndof_G);
element_assembly.KSigmaCc         =  zeros(ndof_C,ndof_c);
element_assembly.KSigmaCSigmaC    =  zeros(ndof_C,ndof_C);
element_assembly.KSigmaCSigmaG    =  zeros(ndof_C,ndof_G);
element_assembly.KSigmaCSigmac    =  zeros(ndof_C,ndof_c);

element_assembly.KSigmaGx         =  zeros(ndof_G,ndof_x);
element_assembly.KSigmaGC         =  zeros(ndof_G,ndof_C);
element_assembly.KSigmaGG         =  zeros(ndof_G,ndof_G);
element_assembly.KSigmaGc         =  zeros(ndof_G,ndof_c);
element_assembly.KSigmaGSigmaC    =  zeros(ndof_G,ndof_C);
element_assembly.KSigmaGSigmaG    =  zeros(ndof_G,ndof_G);
element_assembly.KSigmaGSigmac    =  zeros(ndof_G,ndof_c);

element_assembly.KSigmacx         =  zeros(ndof_c,ndof_x);
element_assembly.KSigmacC         =  zeros(ndof_c,ndof_C);
element_assembly.KSigmacG         =  zeros(ndof_c,ndof_G);
element_assembly.KSigmacc         =  zeros(ndof_c,ndof_c);
element_assembly.KSigmacSigmaC    =  zeros(ndof_c,ndof_C);
element_assembly.KSigmacSigmaG    =  zeros(ndof_c,ndof_G);
element_assembly.KSigmacSigmac    =  zeros(ndof_c,ndof_c);
