%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Assembly of the residual and stiffness matrix of the system.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Reg_parameter    =  RegularisationQuantification(Geometry,Mesh,FEM,...
                                         Quadrature,MatInfo,Solution)    

%--------------------------------------------------------------------------
% Extract from the structures   
%--------------------------------------------------------------------------

xold                      =  Solution.old.x.Eulerian_x;
X                         =  Solution.x.Lagrangian_X;
connectivity              =  Mesh.volume.x.connectivity;
DNX                       =  FEM.volume.bilinear.x.DN_X;
IntWeight                 =  Quadrature.volume.bilinear.IntWeight;
ngauss                    =  size(IntWeight,1);
ElasticityOrigin          =  MatInfo.ElasticityLinear;
%--------------------------------------------------------------------------
% Detect unstable elements
%--------------------------------------------------------------------------
Reg_parameter             =  zeros(Mesh.volume.n_elem,1);
for ielem=1:Mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % Kinematics
    %----------------------------------------------------------------------
    xold_elem             =  xold(:,connectivity(:,ielem));
    X_elem                =  X(:,connectivity(:,ielem));
    [Fo,Ho,Jo]            =  KinematicsFunctionFinalMexC(xold_elem,X_elem,DNX);
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    [~,Elasticity0]       =  ConstitutiveModels(Geometry.PlaneStress,MatInfo,Fo,Ho,Jo);
    
%     if ~Geometry.PlaneStress    
%        [~,Elasticity0]    =  MooneyRivlinMexC(MatInfo.mu1,MatInfo.mu2,...
%                                          MatInfo.lambda,Fo,Ho,Jo);    
%     else
%        [~,Elasticity0]    =  MooneyRivlinPlaneStress(MatInfo.mu1,MatInfo.mu2,...
%                                          MatInfo.lambda,Fo,Ho,Jo);    
%     end        
    %----------------------------------------------------------------------
    % Regularisation of the elasticity tensor 
    %----------------------------------------------------------------------
    Elasticity0Reg       =  RegularisationElasticity1MexC(Geometry.dim^2,ngauss,Elasticity0,ElasticityOrigin);           
    %----------------------------------------------------------------------
    % Sparse assembly 
    %----------------------------------------------------------------------
    DiffElasticity        =  Elasticity0Reg - Elasticity0;
    Reg_parameter_elem    =  reshape(DiffElasticity(1,1,:),[],1);
    Reg_parameter(ielem)  =  sum(Reg_parameter_elem)/ngauss;
end     

end


