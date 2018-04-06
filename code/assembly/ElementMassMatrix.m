
function Mass_xx      =  ElementMassMatrix(geom,mesh,fem,quadrature)

%--------------------------------------------------------------------------
%  Mx0x0 
%--------------------------------------------------------------------------
dim                        =  geom.dim;
Mass_xx                    =  zeros(dim*mesh.volume.x.n_node_elem,...
                                    dim*mesh.volume.x.n_node_elem);
for anode=1:mesh.volume.x.n_node_elem
    for bnode=1:mesh.volume.x.n_node_elem
        adofs          =  dim*(anode-1)+1:dim*anode;
        bdofs          =  dim*(bnode-1)+1:dim*bnode;
        for igauss=1:size(quadrature.volume.bilinear.Chi,1)
            Mass_xx(adofs,...
                bdofs) =  Mass_xx(adofs,bdofs)  +  (fem.volume.bilinear.x.N(anode,igauss)*...
                         fem.volume.bilinear.x.N(bnode,igauss))*eye(dim)*fem.volume.bilinear.x.DX_chi_Jacobian(igauss);
        end
    end
end 

