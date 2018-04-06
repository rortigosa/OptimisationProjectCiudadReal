function  Assembly   =  InternalWorkAssemblyFormulation(formulation,...
                            nonlinearity,Geometry,Mesh,FEM,Quadrature,...
                            Assembly, MatInfo,Optimisation,Solution)



switch formulation
    case 'u'        
      switch nonlinearity        
         %-----------------------------------------------------------------
         % Linear elasticity
         %-----------------------------------------------------------------
         case 'linear'
            Assembly  =  InternalWorkUAssemblyLinearElasticityMexFiles(formulation,...
                             Geometry,Mesh,Assembly,Optimisation,MatInfo,Solution);
         %-----------------------------------------------------------------
         % Non-linear and linearised elasticity
         %-----------------------------------------------------------------
         case 'nonlinear'
            Assembly =  InternalWorkUAssemblyMexFilesv2(formulation,...
                                  Geometry,Mesh,FEM,Quadrature,Assembly,...
                                  MatInfo,Optimisation,Solution);                                        
         %-----------------------------------------------------------------
         % Convexified elasticity
         %-----------------------------------------------------------------
         case 'linearised_convexified'
            Assembly  =  InternalWorkUNonlinearConvexifiedAssemblyMexFiles(formulation,...
                            Geometry,Mesh,FEM,Quadrature,Assembly,...
                            MatInfo,Optimisation,Solution);                 
      end
    case 'up'
         %str    =  ParallelInternalWorkUPAssembly(str);
end
