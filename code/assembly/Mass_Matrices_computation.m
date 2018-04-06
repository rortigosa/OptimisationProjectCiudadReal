%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This functions computes the stiffness matrix resulting from linearising
% the term D^2(Pi_int)[deltav,u].
% This matrix accounts for both constitutive and geometric stiffness
% matrices.
% [Kuu]11  [Kuu]12
% [Kuu]21  [Kuu]22
% Where
% [Kuu]E1E2 =  Kuu_E1E2     Kutheta_E1E2
%              KthetauE1E2  KthetathetaE1E2
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function element_assembly   =  Mass_Matrices_computation(ielem,solution,mesh,quadrature,fem,constant_Mass_Matrices,material_information)
                              
%--------------------------------------------------------------------------
% Jacobian.
%--------------------------------------------------------------------------
kinematics                  =  kinematics_function_volume(mesh.dim,...
                                                          solution.x.Eulerian_x(:,mesh.volume.x.connectivity(:,ielem)),...
                                                          solution.x.Lagrangian_X(:,mesh.volume.x.connectivity(:,ielem)),...
                                                          fem.x.DN_chi);
%--------------------------------------------------------------------------
% Mass matrix Mx0x0 
%--------------------------------------------------------------------------
density                     =  material_information.material_parameters.density;
Mass_xx                     =  zeros(3*mesh.volume.x.n_node_elem);
for igauss=1:size(quadrature.Chi,1)
    %----------------------------------------------------------------------
    % Isoparametric information
    %----------------------------------------------------------------------
    Integration_weight      =  kinematics.DX_chi_Jacobian(igauss)*quadrature.W_v(igauss);
    %----------------------------------------------------------------------
    % Mass matrix
    %----------------------------------------------------------------------
    Mass_xx                 =  Mass_xx  +  density*constant_Mass_Matrices.constant_Mxx(:,:,igauss)*Integration_weight;
end
element_assembly.Mxx        =  Mass_xx;
