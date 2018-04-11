%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% 
%  Constitutive models implemented
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [Piola,Elasticity,...
              thickness_stretch]  =  ConstitutiveModels(PlaneStress,MatInfo,F,H,J)

thickness_stretch =  [];

switch MatInfo.model
    %----------------------------------------------------------------------     
    % Compressible Mooney-Rivlin model
    %----------------------------------------------------------------------     
    case {'MooneyRivlin','NeoHookean'}
         if ~PlaneStress
            [Piola,...
               Elasticity]        =  MooneyRivlinMexC(MatInfo.mu1,...
                                         MatInfo.mu2,MatInfo.lambda,F,H,J);
         else
            [Piola,Elasticity,...
              thickness_stretch]  =  MooneyRivlinPlaneStress(MatInfo.mu1,...
                                         MatInfo.mu2,MatInfo.lambda,F,H,J);
         end
    %----------------------------------------------------------------------     
    % Compressible Arruda-Boyce model
    %----------------------------------------------------------------------     
    case 'ArrudaBoyce'
         if ~PlaneStress
            [Piola,...
               Elasticity]        =  ArrudaBoyceMexC(MatInfo.mu,MatInfo.m,...
                                                     MatInfo.lambda,F,H,J);
         else
            [Piola,Elasticity,...
              thickness_stretch]  =  ArrudaBoycePlaneStress(MatInfo.mu,...
                                           MatInfo.m,MatInfo.lambda,F,H,J);
         end
    %----------------------------------------------------------------------     
    % Compressible Mooney-Rivlin with transverse isotropy acting only in tension
    %----------------------------------------------------------------------     
    case 'MooneyRivlinTITension'
         if ~PlaneStress
            [Piola,...
               Elasticity]        =  MooneyRivlinTransverseIsotropyTensionMexC(MatInfo.mu1,...
                                              MatInfo.mu2,MatInfo.muani,MatInfo.lambda,...
                                              repmat(MatInfo.N0,1,size(F,3)),F,H,J);
         else
             %[Piola,Elasticity,...
             %    thickness_stretch]    =  MooneyRivlinTransverseIsotropyTensionMexC(MatInfo.mu1,MatInfo.mu2,...
             %                             MatInfo.lambda,F,H,J);
             error('The transversely isotropic Mooney-Rivlin model has not been implemented in plane stress yet')
         end       
        
end
