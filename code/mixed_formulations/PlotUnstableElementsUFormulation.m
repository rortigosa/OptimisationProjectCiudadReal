%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Plot unstable elements based on the Sylvester criterion for the Hessian
% operator
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function [stability,n_elem,n_elem_low_density,...
n_elem_intermediate_density,n_elem_high_density,...
n_elem_ultra_high_density]  =  PlotUnstableElementsUFormulation(Optimisation,...
                             Solution,Mesh,FEM,Quadrature,MatInfo,plotting)    

%--------------------------------------------------------------------------
% Extract from the structures 
%--------------------------------------------------------------------------
rho                          =  Optimisation.density;

x                            =  Solution.x.Eulerian_x;
X                            =  Solution.x.Lagrangian_X;
connectivity                 =  Mesh.volume.x.connectivity;
DNX                          =  FEM.volume.bilinear.x.DN_X;
ngauss                       =  length(Quadrature.volume.bilinear.W_v);

stability                    =  ones(Mesh.volume.n_elem,1);
n_elem                       =  0;
n_elem_low_density           =  0;
n_elem_intermediate_density  =  0;
n_elem_high_density          =  0;
n_elem_ultra_high_density    =  0;
dim                          =  size(Solution.x.Eulerian_x,1);
for ielem=1:Mesh.volume.n_elem  
    %----------------------------------------------------------------------
    % kinematics 
    %----------------------------------------------------------------------
    x_elem                  =  x(:,connectivity(:,ielem));
    X_elem                  =  X(:,connectivity(:,ielem));
    [F,H,J]                 =  KinematicsFunctionFinalMexC(x_elem,X_elem,DNX);
    %----------------------------------------------------------------------
    % Compute Piola and the Elasticity tensor for the nonlinear model
    %----------------------------------------------------------------------
    [~,Elasticity]          =  MooneyRivlinMexC(MatInfo.mu1,MatInfo.mu2,...
                                                MatInfo.lambda,F,H,J);    
    %Elasticity_total       =  (rho_p(ielem)*Elasticity + (1 - rho_p(ielem))*void_factor(ielem)*Elasticity_linear)/rho_p(ielem);                                            
    %Kxx                    =  TangentOperatorUFormulationMexC(DNX,Elasticity_total,IntWeight);    
    %----------------------------------------------------------------------
    % Stability of the Elasticity tensor 
    %----------------------------------------------------------------------
    stability(ielem)        =  SylvesterCriterionElasticity(dim,ngauss,Elasticity);  
    %stability(ielem)       =  EigenvalueCriterionStability(ngauss,Elasticity);       
    %stability(ielem)       =  StiffnessCriterionStability(Kxx);
    
    if stability(ielem)==0
       n_elem                  =  n_elem + 1;
       if rho(ielem)<=0.1
          n_elem_low_density   =  n_elem_low_density + 1;
       elseif rho(ielem)>0.1 && rho(ielem)<0.9
          n_elem_intermediate_density   =  n_elem_intermediate_density + 1;
       elseif rho(ielem)>=0.9
          n_elem_high_density  =  n_elem_high_density + 1;
       end
       if rho(ielem)>0.98
           n_elem_ultra_high_density = n_elem_ultra_high_density + 1;
       end
    end
    %----------------------------------------------------------------------
    % Plot unstable elements 
    %----------------------------------------------------------------------    
    if plotting
    subplot(2,2,2)
    if stability(ielem)
        %patch(X_elem(1,[1 2 4 3]),X_elem(2,[1 2 4 3]),'blue','EdgeColor','none')
        patch(x_elem(1,[1 2 4 3]),x_elem(2,[1 2 4 3]),'blue','EdgeColor','none')
    else
        %patch(X_elem(1,[1 2 4 3]),X_elem(2,[1 2 4 3]),'red', 'EdgeColor','none')
        patch(x_elem(1,[1 2 4 3]),x_elem(2,[1 2 4 3]),'red', 'EdgeColor','none')
    end    
    axis equal
    end
end     




end





