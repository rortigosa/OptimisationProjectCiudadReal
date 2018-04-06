
function DIDrho           =  DerivativeObjectiveFunctionMexFilesv2(str,ptest)    
%--------------------------------------------------------------------------
% Initialisation of global residuals and stiffness matrices
%--------------------------------------------------------------------------
DIDrho                    =  zeros(1,str.mesh.volume.n_elem);
%--------------------------------------------------------------------------
% Extract from the structures optimisation fields
%--------------------------------------------------------------------------
penal                     =  str.mat_info.optimisation.penal;
rho                       =  str.mat_info.optimisation.rho;
void_factor               =  str.mat_info.optimisation.void_factor(rho)*str.mat_info.optimisation.void_factor_scaling; 
rho_p                     =  rho.^penal;
diff_void_factor          =  str.mat_info.optimisation.diff_void_factor(rho);
diff_rho_p                =  penal*rho.^(penal - 1);
rho_linear                =  str.mat_info.optimisation.rho_linear(rho);                 
diff_rho_linear           =  str.mat_info.optimisation.diff_rho_linear(rho);
diff_viscosity            =  str.mat_info.optimisation.diff_viscosity(rho);
weakening_linear_model    =  str.mat_info.optimisation.weakening_linear_model;
%--------------------------------------------------------------------------
% Extract from the structures remaining fields
%--------------------------------------------------------------------------
x                         =  str.solution.x.Eulerian_x;
xold                      =  str.solution.old.x.Eulerian;
X                         =  str.solution.x.Lagrangian_X;
connectivity              =  str.mesh.volume.x.connectivity;
mat_parameters            =  str.mat_info.parameters;
Klinear                   =  str.mat_info.Klinear;
ptest                     =  reshape(ptest,str.geometry.dim,[]);
DNX                       =  str.fem.volume.bilinear.x.DN_X;
IntWeight                 =  str.quadrature.volume.bilinear.IntWeight;
Mass                      =  str.assembly.elem_mass;
%--------------------------------------------------------------------------
% Loop over elements for the assembly of resiuals and stiffness matrices
%--------------------------------------------------------------------------
for ielem=1:str.mesh.volume.n_elem 
    x_elem                =  x(:,connectivity(:,ielem));
    xstar_elem            =  xstar(:,connectivity(:,ielem));
    X_elem                =  X(:,connectivity(:,ielem));
    p_elem                =  ptest(:,connectivity(:,ielem));
    [F,H,J,... 
     Fstar,Hstar,Jstar,...
     Hstarstar]   =  KinematicsFunctionLinearisedMexC(x_elem,xstar_elem,X_elem,DNX);
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    Piola_st   =  MooneyRivlinLinearisedMexC(mat_parameters.Mooney_Rivlin.mu1,mat_parameters.Mooney_Rivlin.mu2,...
                                 mat_parameters.Mooney_Rivlin.lambda,F,Hstarstar,Jstar);
    Piola_inst =  MooneyRivlinMexC(mat_parameters.Mooney_Rivlin.mu1,mat_parameters.Mooney_Rivlin.mu2,...
                                 mat_parameters.Mooney_Rivlin.lambda,F,H,J);
    %----------------------------------------------------------------------
    % Determine if linear elasticity or nonlinear elasticity shall be applied
    % on the current element
    %----------------------------------------------------------------------
    u                     =  x_elem - X_elem;
    %----------------------------------------------------------------------
    % linear contribution in the derivative
    %----------------------------------------------------------------------
    linear_contribution   =  p_elem(:)'*(Klinear*u(:));
    %----------------------------------------------------------------------
    % Derivative: solid contribution
    %----------------------------------------------------------------------
    DIDrho_solid_nlinear_st    =  SensitivityNonlinearMexC(0.0*Piola_st,p_elem,DNX,IntWeight);     
    DIDrho_solid_nlinear_inst  =  SensitivityNonlinearMexC(Piola_inst,p_elem,DNX,IntWeight);     
    
%     DIDrho_solid_nlinear  =  -(diff_rho_p(ielem)*rho_linear(ielem) + ...
%                               rho_p(ielem)*diff_rho_linear(ielem))*(DIDrho_solid_nlinear_st);
    %DIDrho_solid_nlinear  =  SensitivityNonlinearMexC(Piola,p_elem,DNX,IntWeight);     
     
    DIDrho_solid_nlinear  =  -(diff_rho_p(ielem)*rho_linear(ielem) + ...
                              rho_p(ielem)*diff_rho_linear(ielem))*(rho(ielem)^(1)*DIDrho_solid_nlinear_inst + (1 - rho(ielem)^(1))*DIDrho_solid_nlinear_st) - ...
                              (rho_p(ielem)*rho_linear(ielem))*((1)*rho(ielem)^(1-1)*DIDrho_solid_nlinear_inst - (1)*rho(ielem)^(1-1)*DIDrho_solid_nlinear_st);
%     DIDrho_solid_nlinear  =  -(diff_rho_p(ielem)*rho_linear(ielem) + ...
%                               rho_p(ielem)*diff_rho_linear(ielem))*(DIDrho_solid_nlinear_inst + 0.1*(1 - rho(ielem)^(4))*DIDrho_solid_nlinear_st) - ...
%                               (rho_p(ielem)*rho_linear(ielem))*( - (4)*rho(ielem)^(4-1)*DIDrho_solid_nlinear_st);
%     DIDrho_solid_nlinear  =  -(diff_rho_p(ielem)*rho_linear(ielem) + ...
%                               rho_p(ielem)*diff_rho_linear(ielem))*(DIDrho_solid_nlinear_st);
    DIDrho_solid_linear   =  -(diff_rho_p(ielem)*(1 - rho_linear(ielem)) -...
                              rho_p(ielem)*diff_rho_linear(ielem))*linear_contribution;        
    DIDrho_solid          =  DIDrho_solid_nlinear + weakening_linear_model*DIDrho_solid_linear;
    %----------------------------------------------------------------------
    % Derivative: void contribution
    %----------------------------------------------------------------------
    DIDrho_void           =  (void_factor(ielem)*diff_rho_p(ielem) - (1 - rho_p(ielem))*diff_void_factor(ielem))*linear_contribution; 
    %----------------------------------------------------------------------
    % Derivative: viscosity contribution
    %----------------------------------------------------------------------
    DIDrho_viscosity      =  -diff_viscosity(ielem)*(p_elem(:)'*Mass*u(:));
    %----------------------------------------------------------------------
    % Derivative: total contribution
    %----------------------------------------------------------------------  
    DIDrho_e              =  DIDrho_solid + DIDrho_void + DIDrho_viscosity;    
    DIDrho(:,ielem)       =  DIDrho_e;    
end     
DIDrho                    =  DIDrho';


end
