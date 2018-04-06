function assembly          =  GlobalResidualInitialisationFormulation(geom,mesh,assembly,formulation)

switch formulation
    case {'u','FHJ','CGC','CGCCascade'}
         assembly.Tx       =  zeros(geom.dim*mesh.volume.x.n_nodes,1);
    case 'up'
         assembly.Tx       =  zeros(geom.dim*mesh.volume.x.n_nodes,1);
         assembly.Tp       =  zeros(mesh.volume.pressure.n_nodes,1);        
    case {'electro_mechanics','electro_mechanics_Helmholtz'}
         assembly.Tx       =  zeros(geom.dim*mesh.volume.x.n_nodes,1);
         assembly.Tphi     =  zeros(mesh.volume.phi.n_nodes,1);        
    case {'electro_mechanics_incompressible','electro_mechanics_mixed_incompressible','electro_Helmholtz_incompressible'}
         assembly.Tx       =  zeros(geom.dim*mesh.volume.x.n_nodes,1);
         assembly.Tphi     =  zeros(mesh.volume.phi.n_nodes,1);
         assembly.Tp       =  zeros(mesh.volume.pressure.n_nodes,1);        
    case {'electro_mechanics_BEM_FEM','electro_mechanics_Helmholtz_BEM_FEM'}
         assembly.Tx       =  zeros(geom.dim*mesh.volume.x.n_nodes,1);
         assembly.Tphi     =  zeros(mesh.volume.phi.n_nodes,1);
         assembly.Tq       =  zeros(mesh.surface.q.n_nodes,1);
    case {'electro_mechanics_incompressible_BEM_FEM',...
          'electro_mechanics_mixed_incompressible_BEM_FEM',...
          'electro_mechanics_Helmholtz_incompressible_BEM_FEM'}
         assembly.Tx       =  zeros(geom.dim*mesh.volume.x.n_nodes,1);
         assembly.Tphi     =  zeros(mesh.volume.phi.n_nodes,1);
         assembly.Tp       =  zeros(mesh.volume.pressure.n_nodes,1);        
         assembly.Tq       =  zeros(mesh.surface.q.n_nodes,1);
    case {'electro_BEM_FEM'}
         assembly.Tphi     =  zeros(mesh.volume.phi.n_nodes,1);
         assembly.Tq       =  zeros(mesh.surface.q.n_nodes,1);
    case 'electro'
         assembly.Tphi     =  zeros(mesh.volume.phi.n_nodes,1);
end
