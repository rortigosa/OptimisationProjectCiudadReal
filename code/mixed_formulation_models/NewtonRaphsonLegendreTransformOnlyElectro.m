%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Given E0 (and F, H, and J), we obtain D0, by using the Legendre transform
% between the internal and the Helmholtz's energies
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function  D0         =  NewtonRaphsonLegendreTransformOnlyElectro(ielem,dim,ngauss,D0,E0,vectorisation,mat_info)
                                                                           
%--------------------------------------------------------------------------
% Initialisation stage. 
%--------------------------------------------------------------------------
tol                  =  1e-10; 
indexi               =  vectorisation.parallel_Newton_Raphson_inversion.indexi;
indexj               =  vectorisation.parallel_Newton_Raphson_inversion.indexj;
%--------------------------------------------------------------------------
% Residual.
%--------------------------------------------------------------------------
mat_info             =  FirstDerivativeComputationOnlyElectro(ielem,ngauss,D0,mat_info);                                             
R                    =  mat_info.derivatives.DU.DUDD0 - E0;
residual             =  norm(R);
tol                  =  max(tol,residual*1e-6);
%--------------------------------------------------------------------------
% Derivative of residual.    
%--------------------------------------------------------------------------
mat_info             =  HessianOperatorInternalEnergyOnlyElectro(ielem,dim,ngauss,D0,mat_info);
DR                   =  mat_info.derivatives.D2U.D2UDD0DD0;    
%--------------------------------------------------------------------------
% Newton Raphson.   
%--------------------------------------------------------------------------
iteration            =  0;
while residual>tol 
      %--------------------------------------------------------------------
      % Update D0 (sparse methodology). 
      %--------------------------------------------------------------------
      data           =  DR(:);
      K              =  sparse(indexi,indexj,data);
      DD             =  -K\R(:); 
      D0             =  D0 + reshape(DD,dim,[]);
      %--------------------------------------------------------------------
      % Residual. 
      %--------------------------------------------------------------------
      mat_info       =  FirstDerivativeComputationOnlyElectro(ielem,ngauss,D0,mat_info);      
      R              =  mat_info.derivatives.DU.DUDD0 - E0; 
      residual       =  norm(R);
      %--------------------------------------------------------------------
      % Derivative of residual.
      %--------------------------------------------------------------------
      mat_info       =  HessianOperatorInternalEnergyOnlyElectro(ielem,dim,ngauss,D0,mat_info);
      DR             =  mat_info.derivatives.D2U.D2UDD0DD0;          
      iteration      =  iteration + 1;
      if iteration>10
          break
      end          
end
end

