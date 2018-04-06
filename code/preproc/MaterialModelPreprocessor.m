%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function redas the material model selected and its associated
%  material properties
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function str  =  MaterialModelPreprocessor(str,model,model_void)

%--------------------------------------------------------------------------
% Universal constants
%--------------------------------------------------------------------------
str     =  UniversalPhysicalConstants(str);
%--------------------------------------------------------------------------
% Material parameters of the model
%--------------------------------------------------------------------------
 str     =  MaterialParametersPreprocessor(str,model,model_void);
%--------------------------------------------------------------------------
% Initialise first and second derivatives of the constitutive model
%--------------------------------------------------------------------------
if strcmp(str.data.language,'MatLab')
   str  =  InitialisationDerivativesModel(str); 
end
%--------------------------------------------------------------------------
% Compute stiffness matrix of an element in the solid in the origin 
% (no deformations)
%--------------------------------------------------------------------------
str     =  ElementStiffnessSolidOrigin(str);





