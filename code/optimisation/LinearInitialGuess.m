
function xPhys0        =  LinearInitialGuess(str,Volfrac,rmin)

str.data.nonlinearity  =  'linear';
%--------------------------------------------------------------------------
% Material information.
%--------------------------------------------------------------------------
str                    =  MaterialModelPreprocessor(str,'Mooney_Rivlin','Mooney_Rivlin');
%--------------------------------------------------------------------------
% Initialisation
%--------------------------------------------------------------------------
str                    =  InitialisationFormulation(str);
%--------------------------------------------------------------------------
% Solver
%--------------------------------------------------------------------------
xPhys0                 =  compliance(str.geometry.StructuredQuadRectangle.Nx,...
                                     str.geometry.StructuredQuadRectangle.Ny,...
                                     Volfrac,rmin,str,'~');
