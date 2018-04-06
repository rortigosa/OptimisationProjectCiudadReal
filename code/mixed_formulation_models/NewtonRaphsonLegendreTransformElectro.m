%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Given E0 (and F, H, and J), we obtain D0, by using the Legendre transform
% between the internal and the Helmholtz's energies
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function  D0                            =  NewtonRaphsonLegendreTransformElectro(ielem,dim,ngauss,kinematics,D0,E0,vectorisation,material_information)
                                                                           
%--------------------------------------------------------------------------
% Initialisation stage. 
%--------------------------------------------------------------------------
tol                                     =  1e-10; 
indexi                                  =  vectorisation.parallel_Newton_Raphson_inversion.indexi;
indexj                                  =  vectorisation.parallel_Newton_Raphson_inversion.indexj;
%--------------------------------------------------------------------------
% Residual.
%--------------------------------------------------------------------------
d                                       =  MatrixVectorMultiplication(dim,ngauss,kinematics.F,D0);
material_information                    =  FirstDerivativeComputation(ielem,ngauss,kinematics.F,kinematics.H,kinematics.J,D0,d,material_information);                                             
R                                       =  material_information.derivatives.DU.DUDD0 - E0;
residual                                =  norm(R);
tol                                     =  max(tol,residual*1e-6);
%--------------------------------------------------------------------------
% Derivative of residual.    
%--------------------------------------------------------------------------
material_information                    =  HessianOperatorInternalEnergy(ielem,dim,ngauss,kinematics.F,kinematics.H,kinematics.J,D0,d,material_information);
material_information.derivatives        =  ReexpressionInternalEnergyFourFieldSet(dim,ngauss,D0,material_information.derivatives,kinematics.F,vectorisation);                                                     
DR                                      =  material_information.derivatives.D2Uhat.D2UDD0DD0;    
%--------------------------------------------------------------------------
% Newton Raphson.   
%--------------------------------------------------------------------------
iteration                               =  0;
while residual>tol 
      %--------------------------------------------------------------------
      % Update D0 (sparse methodology). 
      %--------------------------------------------------------------------
      data                              =  DR(:);
      K                                 =  sparse(indexi,indexj,data);
      DD                                =  -K\R(:); 
      D0                                =  D0 + reshape(DD,dim,[]);
      %--------------------------------------------------------------------
      % Residual. 
      %--------------------------------------------------------------------
      d                                 =  MatrixVectorMultiplication(dim,ngauss,kinematics.F,D0);
      material_information              =  FirstDerivativeComputation(ielem,ngauss,kinematics.F,kinematics.H,kinematics.J,D0,d,material_information);      
      R                                 =  material_information.derivatives.DU.DUDD0 - E0; 
      residual                          =  norm(R);
      %--------------------------------------------------------------------
      % Derivative of residual.
      %--------------------------------------------------------------------
      material_information              =  HessianOperatorInternalEnergy(ielem,dim,ngauss,kinematics.F,kinematics.H,kinematics.J,D0,d,material_information);
      material_information.derivatives  =  ReexpressionInternalEnergyFourFieldSet(dim,ngauss,D0,material_information.derivatives,kinematics.F,vectorisation);                                                     
      DR                                =  material_information.derivatives.D2Uhat.D2UDD0DD0;          
      iteration                         =  iteration + 1;
      if iteration>10
          break
      end          
end
end