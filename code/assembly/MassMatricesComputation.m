%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Compute elemental mass matrix
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Mass   =  MassMatricesComputation(dim,Mesh,Quadrature,FEM,MatInfo)
                              
%--------------------------------------------------------------------------
% Mass matrix Mx0x0 
%--------------------------------------------------------------------------
density                     =  MatInfo.density;
Mass                        =  zeros(dim*Mesh.volume.x.n_node_elem);
for igauss=1:size(Quadrature.volume.bilinear.Chi,1)
    %----------------------------------------------------------------------
    % Isoparametric information
    %----------------------------------------------------------------------
    NShape                  =  FEM.volume.bilinear.x.N(:,igauss);
    for anode=1:size(Mesh.volume.x.connectivity,1)
        for bnode=1:size(Mesh.volume.x.connectivity,1)
            dofa             =  dim*(anode - 1) +1:dim*anode;
            dofb             =  dim*(bnode - 1) +1:dim*bnode;
            Mass(dofa,dofb)  =  Mass(dofa,dofb) + density*NShape(anode)*NShape(bnode)*eye(dim)*Quadrature.volume.bilinear.IntWeight(igauss);
        end
    end
end


