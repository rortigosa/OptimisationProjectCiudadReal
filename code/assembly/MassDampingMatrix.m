

function Assembly =  MassDampingMatrix(Mesh,Geometry,Solution,...
                            Quadrature,FEM,MatInfo,Assembly,TimeIntegrator)    

                        
switch TimeIntegrator.type
    case {'ExplicitNewmarkBeta','CentralDifference'}
         Assembly   =  MassMatricesAssembly(Mesh,Geometry,Solution,...
                                         Quadrature,FEM,MatInfo,Assembly);
         Indexi     =  (1:Geometry.dim*Mesh.volume.x.n_nodes)';
         Data       =  zeros(Geometry.dim*Mesh.volume.x.n_nodes,1);
         for i=1:size(Assembly.MassMatrix,1)
             Data(i)  =  sum(Assembly.MassMatrix(i,:));             
         end
         Assembly.MassMatrix     =  sparse(Indexi,Indexi,Data);
         Assembly.DampingMatrix  =  TimeIntegrator.RayleighCoeff*Assembly.MassMatrix;         
end
                                     

                        



