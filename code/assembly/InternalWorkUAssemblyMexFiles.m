%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assembly of the residual and stiffness matrix of the system.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function str              =  InternalWorkUAssemblyMexFiles(str)    
%--------------------------------------------------------------------------
% Dimension of the problem 
%--------------------------------------------------------------------------
fprintf('Begining of static assembly\n')
%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
str.assembly              =  GlobalResidualInitialisationFormulation(str.geometry,str.mesh,str.assembly,str.data.formulation);
%--------------------------------------------------------------------------
% Dofs per element and initialisation of indexi, indexj and data
%--------------------------------------------------------------------------
[Kindexi,Kindexj,Kdata,...
 Tindexi,Tindexj,Tdata]   =  SparseStiffnessPreallocation(str.geometry,str.mesh,str.data.formulation);
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
tic     
%--------------------------------------------------------------------------
% Extract from the structures
%--------------------------------------------------------------------------
density          =  str.mat_info.optimisation.rho.^str.mat_info.optimisation.penal;
DN_chi           =  str.fem.volume.bilinear.x.DN_chi;
x                =  str.solution.x.Eulerian_x;
X                =  str.solution.x.Lagrangian_X;
connectivity     =  str.mesh.volume.x.connectivity;
mat_parameters   =  str.mat_info.parameters; 
Klinear          =  str.mat_info_void.Klinear;
Weight           =  str.quadrature.volume.bilinear.W_v;
for ielem=1:str.mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % Residuals and stiffness matrices 
    %----------------------------------------------------------------------
    [Rx,Kxx]      =  ResidualStiffnessUFormulationMexFiles(x(:,connectivity(:,ielem)),...
                                 X(:,connectivity(:,ielem)),DN_chi,Weight,...
                                 mat_parameters,density(ielem),Klinear);    
    %----------------------------------------------------------------------
    % Sparse assembly
    %----------------------------------------------------------------------
    [INDEXI,INDEXJ,DATA]  =  StiffnessSparseAssemblyInternalWorkUMexFiles(ielem,...
                                str.geometry.dim,str.mesh,Kxx);         
    Kindexi(:,ielem)      =  INDEXI;
    Kindexj(:,ielem)      =  INDEXJ;
    Kdata(:,ielem)        =  DATA;
    %----------------------------------------------------------------------
    % Assembly of residuals  
    %----------------------------------------------------------------------
    [INDEXI,INDEXJ,DATA]  =  ParallelInternalVectorsAssemblyUMexFiles(ielem,str.geometry.dim,str.mesh,Rx);
    Tindexi(:,ielem)      =  INDEXI;
    Tindexj(:,ielem)      =  INDEXJ; 
    Tdata(:,ielem)        =  DATA;    
end     
toc 
%--------------------------------------------------------------------------
% Sparse assembly of the stiffness matrix.           
%--------------------------------------------------------------------------
if str.contact.lagrange_multiplier
   total_dofs             =  str.solution.n_dofs + size(str.solution.contact_multiplier,1);
else 
   total_dofs             =  str.solution.n_dofs;
end
str.assembly.K_total      =  sparse(Kindexi,Kindexj,Kdata,total_dofs,total_dofs);
%--------------------------------------------------------------------------
% Sparse assembly of the residual.             
%--------------------------------------------------------------------------
str.assembly.Tinternal    =  sparse(Tindexi,Tindexj,Tdata,total_dofs,1);

fprintf('End of static assembly\n')

end





