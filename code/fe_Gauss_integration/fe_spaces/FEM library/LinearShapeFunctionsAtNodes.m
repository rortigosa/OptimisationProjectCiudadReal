%--------------------------------------------------------------------------
% Shape functions for nodes in 2D
%--------------------------------------------------------------------------
for iQ=1:4
    n_nodes_elem           =  2^2;
    Chi_nodal              =  zeros(n_nodes_elem,2);
    chi                    =  linspace(-1,1,iQ+1);
    eta                    =  linspace(-1,1,iQ+1);
    dummy                  =  1;
    for ieta=1:iQ+1
        for ichi=1:iQ+1
            Chi_nodal(dummy,...
                :)         =  [chi(ichi)   eta(ieta)];
            dummy          =  dummy + 1;
        end
    end
    new_str.quadrature.Chi =  Chi_nodal;
    str_x                  =  shape_function_displacement(1,2,new_str.quadrature);
    N                      =  str_x.f_e.N;
    DN_chi                 =  str_x.f_e.DN_chi;
    filename               =  ['Quad_NodeShapeFunctions_Q' num2str(iQ)];
    save(filename,'N','DN_chi');
end

