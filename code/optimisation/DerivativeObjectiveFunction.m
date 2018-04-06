

function DIDrho      =  DerivativeObjectiveFunction(str,ptest)    

%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
DIDrho               =  zeros(1,str.mesh.volume.n_elem);
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
for ielem=1:str.mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % Residuals and stiffness matrices 
    %----------------------------------------------------------------------
    DIDrho_e         =  ParallelDerivativeUV2(ielem,str.quadrature,str.solution,...
                                            str.geometry,str.mesh,str.fem,...
                                            str.mat_info,str.mat_info_void,...
                                            reshape(ptest,str.geometry.dim,[]),...
                                            str.vectorisation);    
    DIDrho(:,ielem)  =  DIDrho_e;    
end     

end
