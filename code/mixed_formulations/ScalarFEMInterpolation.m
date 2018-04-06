%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function performs the FEM interpolation of a scalar field at the
% Gauss points
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function scalar_field     =  ScalarFEMInterpolation(Nshape,scalar_field_elem)

n_gauss                   =  size(Nshape,2);
scalar_field              =  zeros(n_gauss,1);
for igauss=1:n_gauss
    %----------------------------------------------------------------------
    % Nodal information
    %----------------------------------------------------------------------
    scalar_field(igauss)  =  scalar_field_elem'*Nshape(:,igauss);
end

