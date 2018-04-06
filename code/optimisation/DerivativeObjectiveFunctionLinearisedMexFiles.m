

function DIDrho      =  DerivativeObjectiveFunctionLinearisedMexFiles(str,ptest)    
%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
DIDrho               =  zeros(1,str.mesh.volume.n_elem);
%--------------------------------------------------------------------------
% Extract from the structures 
%--------------------------------------------------------------------------
penal                  =  str.mat_info.optimisation.penal;
rho                    =  str.mat_info.optimisation.rho;
void_factor            =  str.mat_info.optimisation.void_factor(rho); 
diff_rho_p             =  penal*rho.^(penal - 1);

x                        =  str.solution.x.Eulerian_x;
xn                       =  x - reshape(str.solution.incremental_solution,str.geometry.dim,[]);
X                        =  str.solution.x.Lagrangian_X;
connectivity             =  str.mesh.volume.x.connectivity;
mat_parameters           =  str.mat_info.parameters;
Klinear                  =  str.mat_info.Klinear; 
ptest                    =  reshape(ptest,str.geometry.dim,[]);
DNX                      =  str.fem.volume.bilinear.x.DN_X;
IntWeight                =  str.quadrature.volume.bilinear.IntWeight;
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
for ielem=1:str.mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % Kinematics
    %----------------------------------------------------------------------
    x_elem               =  x(:,connectivity(:,ielem));
    x_elem_n             =  xn(:,connectivity(:,ielem));
    X_elem               =  X(:,connectivity(:,ielem));
    p_elem               =  ptest(:,connectivity(:,ielem));
    [F,H,J]              =  KinematicsFunctionFinalMexC(x_elem_n,X_elem,DNX);
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    [Piola,Elasticity]   =  MooneyRivlinMexC(mat_parameters.Mooney_Rivlin.mu1,...
                              mat_parameters.Mooney_Rivlin.mu2,...
                              mat_parameters.Mooney_Rivlin.lambda,F,H,J);
    %----------------------------------------------------------------------
    % Stiffness matrix
    %----------------------------------------------------------------------
    Kxx                  =  TangentOperatorUFormulationMexC(DNX,Elasticity,IntWeight);
    %----------------------------------------------------------------------
    % Determine if linear elasticity or nonlinear elasticity shall be applied
    % on the current element
    %----------------------------------------------------------------------
    Du                   =  x_elem - x_elem_n;
    u                    =  x_elem - X_elem;
    %----------------------------------------------------------------------
    % Derivative: solid contribution
    %----------------------------------------------------------------------
    DIDrho_solid         =  SensitivityNonlinearMexC(Piola,p_elem,DNX,IntWeight);
    DIDrho_solid         =  DIDrho_solid + p_elem(:)'*(Kxx*Du(:));
    DIDrho_solid         =  -diff_rho_p(ielem)*DIDrho_solid;
    %----------------------------------------------------------------------
    % Derivative: void contribution 
    %----------------------------------------------------------------------
    linear_contribution  =  p_elem(:)'*(Klinear*u(:));
    DIDrho_void          =  void_factor(ielem)*diff_rho_p(ielem)*linear_contribution;
    %----------------------------------------------------------------------
    % Derivative: total contribution
    %----------------------------------------------------------------------
    DIDrho(:,ielem)      =  DIDrho_solid + DIDrho_void;    
end     
DIDrho                   =  DIDrho';


end
