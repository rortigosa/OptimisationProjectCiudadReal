%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function plots unstable elements based on the Sylvester criterion
%  for the Hessian operator of the constitutive model considered
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Optimisation                  =  PlotUnstableElements(formulation,Optimisation,Solution,...
                                       Mesh,FEM,Quadrature,MatInfo,...
                                       plot_mesh,plot_n_elements,Iteration)    

switch formulation
    case 'u' 
         [Optimisation.stability,Optimisation.n_unstable_elements(Iteration),...
          Optimisation.n_unstable_elements_low_density(Iteration),...
          Optimisation.n_unstable_elements_intermediate_density(Iteration),...
          Optimisation.n_unstable_elements_high_density(Iteration),...
          Optimisation.n_unstable_elements_ultra_high_density(Iteration)]   =  PlotUnstableElementsUFormulation(Optimisation,...
                                                                                    Solution,Mesh,FEM,Quadrature,MatInfo,plot_mesh);


end

if plot_n_elements
subplot(3,2,4)
plot((1:Iteration),Optimisation.n_unstable_elements,'-o',...
    (1:Iteration),Optimisation.n_unstable_elements_low_density,'-o',...
    (1:Iteration),Optimisation.n_unstable_elements_intermediate_density,'-o',...
    (1:Iteration),Optimisation.n_unstable_elements_high_density,'-o')
legend('n unst elem','n unst LD elem','n unst ID elem','n unst HD elem')
xlabel(['number of elements = ' num2str(Mesh.volume.n_elem)])
fprintf('Number of unstable elements with rho>0.98 = %d\n',Optimisation.n_unstable_elements_ultra_high_density(Iteration))
set_latex_font(10)
end