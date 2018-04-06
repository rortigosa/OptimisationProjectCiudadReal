%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% This function computes the elemental residual vectors and stiffness
% matrices of each of the fomulations of this code
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str    =  InternalWorkResidualStiffness(ielement,str)

switch str.data.formulation
    case {'electro','electro_BEM_FEM'}
         str    =  InternalWorkResidualStiffnessElectro(ielement,str);
    case {'electro_incompressible','electro_incompressible_BEM_FEM'}
         str    =  InternalWorkResidualStiffnessElectroIncompressible(ielement,str);
    case {'electro_mixed_incompressible','electro_mixed_incompressible_BEM_FEM'}
         str    =  InternalWorkResidualStiffnessElectroMixedIncompressible(ielement,str);
end


