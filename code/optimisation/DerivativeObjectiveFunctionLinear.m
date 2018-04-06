

function DIDrho      =  DerivativeObjectiveFunctionLinear(str,ptest)    
%--------------------------------------------------------------------------
% Dimension of the problem 
%--------------------------------------------------------------------------
fprintf('Begining of static assembly\n')
%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
DIDrho               =  zeros(1,str.mesh.volume.n_elem);
%--------------------------------------------------------------------------
% Initialisation of solution
%--------------------------------------------------------------------------
str                  =  InitialisedFields(str); 
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
parfor ielem=1:str.mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % Residuals and stiffness matrices 
    %----------------------------------------------------------------------
    DIDrho_e         =  ParallelDerivativeULinear(ielem,str.quadrature,str.solution,...
                                            str.geometry,str.mesh,str.fem,...
                                            str.mat_info,str.mat_info_void,...
                                            reshape(ptest,str.geometry.dim,[]),str.vectorisation);    
    DIDrho(:,ielem)  =  DIDrho_e;    
end     

fprintf('End of static assembly\n')

end
