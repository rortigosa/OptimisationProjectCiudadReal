function N_vectorised              =  VectorisationShapeFunctions(N,n_dofs)

n_gauss_points                     =  size(N,2);
n_node_elem                        =  size(N,1);
N_vectorised                       =  zeros(n_dofs,n_dofs*n_node_elem,n_gauss_points);
for igauss=1:n_gauss_points
    final                          =  0;
    for inode=1:n_node_elem
        initial                    =  final + 1;           
        final                      =  initial + n_dofs - 1;
        N_vectorised(:,...
            initial:final,igauss)  =  N(inode,igauss)*eye(n_dofs);     
    end
end
