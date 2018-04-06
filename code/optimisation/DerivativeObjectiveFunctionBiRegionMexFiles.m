

function DIDrho      =  DerivativeObjectiveFunctionBiRegionMexFiles(str,ptest)    
%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
DIDrho               =  zeros(1,str.mesh.volume.n_elem);
%--------------------------------------------------------------------------
% Extract from the structures
%--------------------------------------------------------------------------
void_factor          =  str.mat_info.optimisation.void_factor(str.mat_info.optimisation.rho)*str.mat_info.optimisation.void_factor_scaling; 
penal                =  str.mat_info.optimisation.penal;
density              =  penal*(str.mat_info.optimisation.rho.^(penal-1));
x_stb                =  str.solution_pre_instability.x.Eulerian_x; % Solution up to the critical load
x                    =  str.solution.x.Eulerian_x; % Solution in the final (unstable configuration)
X                    =  str.solution.x.Lagrangian_X;
connectivity         =  str.mesh.volume.x.connectivity;
mat_parameters       =  str.mat_info.parameters;
Klinear              =  str.mat_info.Klinear;
ptest                =  reshape(ptest,str.geometry.dim,[]);
DNX                  =  str.fem.volume.bilinear.x.DN_X;
IntWeight            =  str.quadrature.volume.bilinear.IntWeight;
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
for ielem=1:str.mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % Residuals and stiffness matrices 
    %----------------------------------------------------------------------
    x_elem      =  x(:,connectivity(:,ielem));
    xst_elem    =  x_stb(:,connectivity(:,ielem));
    X_elem      =  X(:,connectivity(:,ielem));
    p_elem      =  ptest(:,connectivity(:,ielem));
    [F_st,H_st,...
    J_st]     =  KinematicsFunctionFinalMexC(xst_elem,X_elem,DNX);
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    Piola_st      =  MooneyRivlinMexC(mat_parameters.Mooney_Rivlin.mu1,...
                       mat_parameters.Mooney_Rivlin.mu2,...
                       mat_parameters.Mooney_Rivlin.lambda,F_st,H_st,J_st);
    %----------------------------------------------------------------------
    % Determine if linear elasticity or nonlinear elasticity shall be applied
    % on the current element
    %----------------------------------------------------------------------
    u_st          =  xst_elem - X_elem;
    u             =  x_elem - xst_elem;
    %----------------------------------------------------------------------
    % Derivative
    %----------------------------------------------------------------------
    Kvoid_linear  =  void_factor(ielem)*Klinear;
%    Kvoid_linear  =  1e-6*Klinear;
    DIDrho_st     =  SensitivityNonlinearMexC(Piola_st,p_elem,DNX,IntWeight);             % Pre-buckling contribution
    DIDrho_st     =  (-density(ielem)*DIDrho_st + density(ielem)*(p_elem(:)'*(Kvoid_linear*u_st(:))));  % Pre-buckling contribution
    DIDrho_inst   =  mat_parameters.stiffness_scaling_factor*density(ielem)*(p_elem(:)'*( - Klinear)*u(:)); % Post-buckling contribution
    DIDrho_e      =  DIDrho_st + DIDrho_inst;
    DIDrho(:,ielem)  =  DIDrho_e;    
end     

DIDrho               =  DIDrho';


end
