function Dpenalty        =  EigenvaluePenaltyBasedDerivative(Optimisation,Solution,Mesh,MatInfo,Quadrature,FEM)    

%--------------------------------------------------------------------------
% Extract from the structures  
%--------------------------------------------------------------------------
%rho                    =  Optimisation.density;
%rho_p                  =  rho.^Optimisation.penalty;
%drho_p                 =  Optimisation.penalty*rho.^(Optimisation.penalty-1);

x                       =  Solution.x.Eulerian_x;
X                       =  Solution.x.Lagrangian_X;
connectivity            =  Mesh.volume.x.connectivity;
DNX                     =  FEM.volume.bilinear.x.DN_X;
IntWeight               =  Quadrature.volume.bilinear.IntWeight;
Dpenalty                =  zeros(Mesh.volume.n_elem,1);

for ielem=1:Mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % kinematics
    %----------------------------------------------------------------------
    x_elem               =  x(:,connectivity(:,ielem));
    X_elem               =  X(:,connectivity(:,ielem));
    [F,H,J]              =  KinematicsFunctionFinalMexC(x_elem,X_elem,DNX);
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    [~,Elasticity]       =  MooneyRivlinMexC(MatInfo.mu1,MatInfo.mu2,...
                                          MatInfo.lambda,F,H,J);    
    %----------------------------------------------------------------------
    % Penalty term
    %----------------------------------------------------------------------
    %[~,Dpenalty(ielem)]  =   EigenvaluePenaltyBasedTerm(rho_p(ielem),drho_p(ielem),Elasticity,IntWeight);
    [~,Dpenalty(ielem)]   =   EigenvaluePenaltyBasedTerm(1,0,Elasticity,IntWeight);
 end     


end

