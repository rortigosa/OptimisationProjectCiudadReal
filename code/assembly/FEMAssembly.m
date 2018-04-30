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
                    case {'nonlinear','arclength','linearised_arclength'}
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
        switch nonlinearity
            case 'nonlinear'
         Assembly  =  InternalWorkUExplicitAssembly(Data.formulation,...
                          Geometry,Mesh,FEM,Quadrature,Assembly,...
                          MatInfo,Optimisation,Solution);
            case 'linear'
         Assembly  =  InternalWorkUExplicitAssembly(Data.formulation,...
                          Geometry,Mesh,FEM,Quadrature,Assembly,...
                          MatInfo,Optimisation,Solution);                
        end
        
    case 'CentralDifference'        
         Assembly  =  InternalWorkUExplicitAssembly(Data.formulation,...
                          Geometry,Mesh,FEM,Quadrature,Assembly,...
                          MatInfo,Optimisation,Solution);
end

