

function SaveMatLab(iteration,dir,Optimisation,Geometry,Data,TimeIntegrator,...
                    FEM,Quadrature,NR,MatInfo,Bc,Solution,Mesh,Assembly,...
                    UserDefinedFuncs,PostProc)

cd(fullfile(dir.output_folder))

if isfield(Solution,'old')
   Solution      =  rmfield(Solution,'old');
end
if isfield(Solution,'old_old')
   Solution      =  rmfield(Solution,'old_old');
end
if isfield(Solution,'old_Post')
   Solution      =  rmfield(Solution,'old_Post');
end


save(['Results_Optimisation_Iteration_' num2str(iteration) '.mat'],'Optimisation',...
                   'Geometry','Data','TimeIntegrator','FEM','Quadrature',...
                   'NR','MatInfo','Bc','Solution','Mesh','Assembly',...
                   'UserDefinedFuncs','PostProc');


