%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function performs the FEM interpolation of a vector field at the
% Gauss points
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function vector_field       =  VectorFEMInterpolation(ngauss,Nshape,vector_field_elem)

dim                         =  size(vector_field_elem,1);
vector_field                =  zeros(dim,ngauss);
for igauss=1:ngauss
    %----------------------------------------------------------------------
    % Nodal information
    %----------------------------------------------------------------------
    vector_field(:,igauss)  =  vector_field_elem*Nshape(:,igauss);
end

