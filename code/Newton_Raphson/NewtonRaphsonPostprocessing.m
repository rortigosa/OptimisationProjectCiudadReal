%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Newton-Raphson postprocessing
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function NewtonRaphsonPostprocessing(NR,Assembly)

switch NR.convergence_plotting
    case 1
         figure(1)
         plot(log10(Assembly.Residual_stored{1}(1:NR.iteration)),'b-o')
end
% switch Data.analysis
%     case 'static'
%         jobfolder                =  (([str.jobfolder '\results']));
%         cd(jobfolder);
%         filename                 =  ['AL_iteration_' num2str(str.AL.iteration)];
%         save(filename,'-v7.3');
% end
