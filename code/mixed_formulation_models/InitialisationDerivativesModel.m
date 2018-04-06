function str  =  InitialisationDerivativesModel(str)

switch str.data.formulation
    case {'u','up','FHJ'}
       str    =  InitialisationDerivativesMechanics(str.geometry.dim,...
                           size(str.quadrature.volume.bilinear.Chi,1),str);
    case {'CGC','CGCCascade'}
       str    =  InitialisationDerivativesMechanicsC(str.geometry.dim,...
                           size(str.quadrature.volume.bilinear.Chi,1),str);
    case {'electro_mechanics','electro_mechanics_incompressible'}
       str    =  InitialisationDerivativesElectro(str.geometry.dim,...
                           size(str.quadrature.volume.bilinear.Chi,1),str);      
    case {'electro_mechanics_mixed_incompressible'}
       str    =  InitialisationDerivativesElectroMixed(str.geometry.dim,...
                           size(str.quadrature.volume.bilinear.Chi,1),str);      
    case {'electro_mechanics_Helmholtz',...
          'electro_mechanics_Helmholtz_incompressible'}
       str    =  InitialisationDerivativesElectroHelmholtz(str.geometry.dim,...
                           size(str.quadrature.volume.bilinear.Chi,1),str);      
    case 'electro'
       str    =  InitialisationDerivativesOnlyElectroBEMFEM(str.geometry.dim,...
                           size(str.quadrature.volume.bilinear.Chi,1),str);      
end
%--------------------------------------------------------------------------
% Initialisation of Piola
%--------------------------------------------------------------------------
str.mat_info.Piola   =  zeros(str.geometry.dim,str.geometry.dim,size(str.quadrature.volume.bilinear.Chi,1));
%--------------------------------------------------------------------------
% Derivatives in the void region
%--------------------------------------------------------------------------
str.mat_info_void.derivatives  =  str.mat_info.derivatives;

