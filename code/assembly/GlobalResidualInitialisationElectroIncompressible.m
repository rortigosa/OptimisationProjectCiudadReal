function assembly  =  GlobalResidualInitialisationElectroIncompressible(geom,mesh,assembly)

assembly.Tx        =  zeros(geom.dim*mesh.volume.x.n_nodes,1);
assembly.Tphi      =  zeros(mesh.volume.phi.n_nodes,1);
assembly.Tp        =  zeros(mesh.volume.pressure.n_nodes,1);
