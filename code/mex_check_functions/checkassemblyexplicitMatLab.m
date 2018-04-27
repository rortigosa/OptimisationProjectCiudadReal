    

%/*-----------------------------------------------------------------*/
%/*Initialisation of the residual*/
%/*-----------------------------------------------------------------*/
TInternal  =  zeros(dim*n_nodes,1);
%/*-----------------------------------------------------------------*/
%/*The C function*/
%/*-----------------------------------------------------------------*/
u_elem    =  zeros(dim*n_node_elem,1);
dofs      =  zeros(dim*n_node_elem,1);
for ielem=1:n_elem
    %/*--------------------------------------------------------------*/
    %/*Get displacemen ts*/
    %/*--------------------------------------------------------------*/
    for inode=1:n_node_elem
        node  =  connectivity((ielem-1)*n_node_elem + inode);
        for idim=1:dim
            u_elem(idim + (inode-1)*dim)  =  x(idim + dim*(node-1)) - X(idim + dim*(node-1));
            dofs(idim+(inode-1)*dim)   =  idim + dim*(node-1);
        end
    end
    %/*--------------------------------------------------------------*/
    %/*Get residual*/
    %/*--------------------------------------------------------------*/
    hom_factor    =  rho_p(ielem) + (1 - rho_p(ielem))*void_factor;
    Rx   =  Klinear*u_elem;
%    TInternal(dofs) =  TInternal(dofs) + Rx;
%    TInternal(dofs) =  TInternal(dofs) + 1;
%    TInternal(dofs) =  hom_factor*Rx;
    TInternal(dofs) =  TInternal(dofs) + Rx;
end
