%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Newton-Raphson postprocessing
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ArcLengthPostprocessing(str)

switch str.NR.convergence_plotting
    case 1
         figure(1)
         plot(log10(str.assembly.Residual_stored{1}(1:str.NR.iteration)),'b-o')
end
switch str.data.analysis
    case 'static'
        cd(str.dir.output_folder);
        filename                 =  ['Arc_Length_iteration_' num2str(str.AL.iteration)];
        save(filename,'-v7.3');
end
