%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assembly of all the contributions of the problem
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Assembly      =  FEMAssembly(Data,nonlinearity,Geometry,Mesh,...
                                 FEM,Quadrature,Assembly,MatInfo,...
                                 Optimisation,Solution,TimeIntegrator,...
                                 StabilisationFactor)    

                             
switch TimeIntegrator.type
    %----------------------------------------------------------------------
    % Static case
    %----------------------------------------------------------------------
    case 'Static'
        switch Data.formulation
            case 'u'
                switch nonlinearity
                    %------------------------------------------------------
                    % Linear elasticity
                    %------------------------------------------------------
                    case 'linear'
                        Assembly  =  InternalWorkUAssemblyLinearElasticityMexFiles(Data.formulation,...
                                         Geometry,Mesh,Assembly,Optimisation,MatInfo,Solution);
                        %--------------------------------------------------
                        % Non-linear and linearised elasticity
                        %--------------------------------------------------
                    case 'nonlinear'
                        Assembly =  InternalWorkUAssemblyMexFilesv2(Data.formulation,...
                                        Geometry,Mesh,FEM,Quadrature,Assembly,...
                                        MatInfo,Optimisation,Solution);
                        %--------------------------------------------------
                        % Convexified elasticity
                        %--------------------------------------------------
                    case 'linearised_convexified'
                        Assembly  =  InternalWorkUNonlinearConvexifiedAssemblyV2MexFiles(Data.formulation,...
                                       Geometry,Mesh,FEM,Quadrature,Assembly,...
                                       MatInfo,Optimisation,Solution,...
                                       StabilisationFactor);
                end
            case 'up'
                %str    =  ParallelInternalWorkUPAssembly(str);
        end
    case 'ExplicitNewmarkBeta'        
         Assembly  =  InternalWorkUExplicitAssembly(Data.formulation,...
                          Geometry,Mesh,FEM,Quadrature,Assembly,...
                          MatInfo,Optimisation,Solution);
        
    case 'CentralDifference'        
         Assembly  =  InternalWorkUExplicitAssembly(Data.formulation,...
                          Geometry,Mesh,FEM,Quadrature,Assembly,...
                          MatInfo,Optimisation,Solution);
end

% %--------------------------------------------------------------------------
% % Assembly of residuals and stiffness matrices for:  
% % a) Internal work contribution
% %--------------------------------------------------------------------------
% Assembly       =  InternalWorkAssemblyFormulation(Data.formulation,...
%                             nonlinearity,Geometry,Mesh,FEM,Quadrature,...
%                             Assembly, MatInfo,Optimisation,Solution);
%--------------------------------------------------------------------------
% Assembly of all the contributions of the stiffness matrices and 
% residual vectors including inertial and viscous terms 
%--------------------------------------------------------------------------
% Assembly       =  StiffnessMatrixTotalAssembly(Data,Solution,Assembly,TimeIntegrator);
% Assembly       =  ParallelResidualsTotalAssembly(Data.analysis,Assembly,Solution,TimeIntegrator);                     
% %--------------------------------------------------------------------------
% % Add contact contribution 
% %--------------------------------------------------------------------------
% if str.contact.lagrange_multiplier
%     str.assembly.total_force    =  [str.assembly.total_force;str.assembly.Tcontact_multiplier]; 
% end




