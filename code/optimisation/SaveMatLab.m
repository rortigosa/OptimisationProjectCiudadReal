

function SaveMatLab(iteration,dir,Optimisation,Geometry,Data,TimeIntegrator,...
                    FEM,Quadrature,NR,MatInfo,Bc,Solution,Mesh,Assembly,...
                    UserDefinedFuncs,PostProc)

cd(fullfile(dir.output_folder))

Solution      =  rmfield(Solution,'old');
Solution      =  rmfield(Solution,'old_old');
Solution      =  rmfield(Solution,'old_Post');


save(['Results_Optimisation_Iteration_' num2str(iteration) '.mat'],'Optimisation',...
                   'Geometry','Data','TimeIntegrator','FEM','Quadrature',...
                   'NR','MatInfo','Bc','Solution','Mesh','Assembly',...
                   'UserDefinedFuncs','PostProc');


