%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Plots in the Compliance function
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function  PostProc  =  CompliancePlots(dir,Geometry,Mesh,FEM,MatInfo,Solution,xPhys,...
                          Quadrature,Optimisation,PostProc,iteration,ObjFunc,...
                          Data,NR,Assembly,Bc,UserDefinedFuncs,TimeIntegrator)
%--------------------------------------------------------------------------                
% PARAVIEW POSTPROCESSING
%--------------------------------------------------------------------------
% cd(dir.output_folder)
% ParaviewPostprocessor(Geometry,Mesh,FEM,MatInfo,Solution,Quadrature,...
%          Optimisation,PostProc,0,['evolution_' num2str(iteration) '.vtk']);
%--------------------------------------------------------------------------
% PARAVIEW POSTPROCESSING FOR THE REGULARISATION OF THE PROBLEM
%--------------------------------------------------------------------------
% cd(dir.output_folder)
% ParaviewRegularisationQuantification(Geometry,Mesh,FEM,MatInfo,Solution,...
%     Quadrature,Optimisation,1,['Regularisation_' num2str(iteration) '.vtk']);
%--------------------------------------------------------------------------
% PARAVIEW POSTPROCESSING OF TANGENT OPERATORS
%--------------------------------------------------------------------------
% cd(dir.output_folder)
% if iteration==1
%     Reg_parameter  =  RegularisationQuantification(Geometry,Mesh,FEM,...
%                                              Quadrature,MatInfo,Solution);
%     [~,PostProc.ielem]   =  max(Reg_parameter);
% end
% PlotTangentOperators(Geometry,Mesh,FEM,MatInfo,Solution,...
%                      PostProc.ielem,1,['Tensors_' num2str(iteration) '.vtk']);
                 
%--------------------------------------------------------------------------
% PARAVIEW POSTPROCESSING FOR ENERGY
%--------------------------------------------------------------------------                 
% ParaviewEnergy(Geometry,Mesh,FEM,MatInfo,Solution,...
%          Quadrature,Optimisation,1,['Energies_' num2str(iteration) '.vtk']);                 
%--------------------------------------------------------------------------
% STORE THE EVOLUTION OF THE THREE DIFFERENT ENERGIES
%--------------------------------------------------------------------------                 
[~,~,~,TotalEnergy,TotalEnergyLin,...
   TotalEnergyReg,~,~,~,...
   TotalEnergySolid,TotalEnergyLinSolid,...
   TotalEnergyRegSolid]             =  EnergyEvolutionOptimisation(Geometry,...
                                             Mesh,FEM,MatInfo,Solution,...
                                             Quadrature,Optimisation);
PostProc.TotalEnergy(iteration)     =  TotalEnergy;
PostProc.TotalEnergyLin(iteration)  =  TotalEnergyLin; 
PostProc.TotalEnergyReg(iteration)  =  TotalEnergyReg;
PostProc.TotalEnergySolid(iteration)     =  TotalEnergySolid;
PostProc.TotalEnergyLinSolid(iteration)  =  TotalEnergyLinSolid;
PostProc.TotalEnergyRegSolid(iteration)  =  TotalEnergyRegSolid;
subplot(3,2,6)
% plot((1:iteration),PostProc.TotalEnergySolid(1:iteration),'-o','MarkerSize',2,...
%                                                              'LineWidth',2)
% hold on                                                         
% plot((1:iteration),PostProc.TotalEnergyLinSolid(1:iteration),'-ro','MarkerSize',2,...
%                                                              'LineWidth',2)                                                         
% hold on                                                         
% plot((1:iteration),PostProc.TotalEnergyRegSolid(1:iteration),'-go','MarkerSize',2,...
%                                                              'LineWidth',2)                                                         
% hold on                                                         
% 
Diff_  =   (PostProc.TotalEnergySolid(1:iteration) - PostProc.TotalEnergyRegSolid(1:iteration))./PostProc.TotalEnergySolid(1:iteration);
plot((1:iteration),Diff_,'-go','MarkerSize',2,'LineWidth',2)
hold on
Diff_  =   (PostProc.TotalEnergySolid(1:iteration) - PostProc.TotalEnergyLinSolid(1:iteration))./PostProc.TotalEnergySolid(1:iteration);
plot((1:iteration),Diff_,'-ro','MarkerSize',2,'LineWidth',2)
                                                         
hold on 
set_latex_font(12)
legend('(W^{2D} - W^{2D}_{Reg})/W^{2D}','(W^{2D} - W^{2D}_{Lin})/W^{2D}')


grid on                                                          
%--------------------------------------------------------------------------
% PLOT DEFORMED CONFIGURATION
%--------------------------------------------------------------------------
subplot(3,2,1)
plot(Solution.x.Eulerian_x(1,:),Solution.x.Eulerian_x(2,:),'o','MarkerSize',2);
hold on
axis equal
%--------------------------------------------------------------------------
% PLOT DENSITIES
%--------------------------------------------------------------------------
subplot(3,2,2)
colormap(gray); imagesc(1-xPhys); caxis([0 1]); axis equal; axis off; drawnow;
%--------------------------------------------------------------------------
% PLOT UNSTABLE ELEMENTS
%--------------------------------------------------------------------------
Optimisation.density =  xPhys(:);
Optimisation    =  PlotUnstableElements(Data.formulation,Optimisation,Solution,...
                                Mesh,FEM,Quadrature,MatInfo,0,1,iteration);
subplot(3,2,3)
colormap(gray); imagesc(reshape(Optimisation.stability,size(xPhys,1),...
              size(xPhys,2))); caxis([0 1]); axis equal; axis off; drawnow;
%--------------------------------------------------------------------------
% PLOT OBJECTIVE FUNCTION
%--------------------------------------------------------------------------
subplot(3,2,5)
plot(ObjFunc(1:iteration),'-o','MarkerSize',2,'LineWidth',2);
PostProc.ObjFunc  =  ObjFunc;
grid on
%--------------------------------------------------------------------------
% CHECK STABILITY OF THE DESIGN
%--------------------------------------------------------------------------
if iteration>=20
    if ~mod(iteration,50)
        StabilityFinalTopology(Optimisation,Data,NR,Geometry,Mesh,FEM,...
              Quadrature,Assembly,MatInfo,Bc,Solution,UserDefinedFuncs,TimeIntegrator);
    end
end
