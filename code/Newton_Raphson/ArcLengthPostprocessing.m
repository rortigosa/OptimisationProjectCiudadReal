%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Newton-Raphson postprocessing
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ArcLengthPostprocessing(dir,Optimisation,Geometry,Data,TimeIntegrator,...
                    FEM,Quadrature,NR,MatInfo,Bc,Solution,Mesh,Assembly,...
                    UserDefinedFuncs,PostProc,AL)

cd(dir.output_folder);
filename                 =  ['Arc_Length_iteration_' num2str(AL.iteration)];
save(filename,'-v7.3');
