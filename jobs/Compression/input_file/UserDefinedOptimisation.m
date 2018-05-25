
function Optimisation     =  UserDefinedOptimisation

%--------------------------------------------------------------------------
% Optimisation method
%--------------------------------------------------------------------------
Optimisation.method       =  'SIMP';
%Optimisation.method      =  'LevelSet';
%--------------------------------------------------------------------------
% Objective function to be minised
%--------------------------------------------------------------------------
Optimisation.ObjFunction  =  'Compliance';
%Optimisation.ObjFunction =  'StrainEnergy';
%Optimisation.ObjFunction =  'Stability';
%--------------------------------------------------------------------------
% Specific fields for SIMP 
%--------------------------------------------------------------------------
switch Optimisation.method
    case 'SIMP'
         Optimisation.penalty      =  3;   %  Penalty in the SIMP
         Optimisation.density      =  [];  %  Density in the SIMP
         Optimisation.void_factor  =  1e-5;
         
         Optimisation.Volfrac      =  0.4;
         Optimisation.rmin         =  2;
         
end

