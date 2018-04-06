function [M_elem]                                       =  mass_matrix(xelem,Xelem,phielem,str)

%--------------------------------------------------------------------------
% Dimension of the problem 
%--------------------------------------------------------------------------
switch str.data.dim
    case {2,3}
         dim                                            =  str.data.dim;                     
         n_node_elem                                    =  str.n_node_elem;         
         Nshape                                         =  str.f_e.N;
    case {12,13}
         dim                                            =  str.mec_u_dof;        
         n_node_elem                                    =  str.n_node_mechanical_element;         
         Nshape                                         =  str.f_e.temp_N_mech_stored;
end
%-------------------------------------------------------------------------- 
% Identity matrix.
%--------------------------------------------------------------------------            
I                                                       =  eye(dim);                               
%----------------------------------------------------------------------
% Gradients in the problem. 
%----------------------------------------------------------------------
[str]                                                   =  gradients(xelem,Xelem,phielem,str); 

M_elem                                                  =  zeros(dim*n_node_elem);
for alpha=1:n_node_elem    
    for beta=1:n_node_elem    
        M                                               =  zeros(dim,dim);   
        for igauss=1:size(str.quadrature.Chi,1)    
            DX_chi                                      =  str.grad.DX_chi(:,:,igauss);        
            W                                           =  str.quadrature.W_v(igauss);
            %------------------------------------------------------------------- 
            % Jacobean for integration in the Gauss integral  
            %-------------------------------------------------------------------     
            J_t                                         =  DX_chi'; 
            J_t                                         =  abs(det(J_t));       
            %----------------------------------------------------------------------
            % Mass matrix    
            %---------------------------------------------------------------------- 
            M                                           =  M + (str.data.Rho*Nshape(alpha,igauss)*Nshape(beta,igauss))*I*W*J_t;                                                                                                                                                   
        end            
        M_elem(dim*alpha-(dim-1):dim*alpha,...
            dim*beta-(dim-1):dim*beta)                  =  M  + M_elem(dim*alpha-(dim-1):dim*alpha,dim*beta-(dim-1):dim*beta);
    end     
end   



