function [str]                               =  incremental_arc_length(str)

format long
str.arc_length.total_arc_length_iterations   =  str.data.total_arc_length_iterations;
str.arc_length.desired_n_iterations          =  str.data.desired_n_iterations;
str.arc_length.Dlambda                       =  0;

%--------------------------------------------------------------------------
% First iteration. 
%--------------------------------------------------------------------------
arc_length_iteration                         =  1;
save results.mat
[str]                                        =  initial_radius(str);
load results.mat
load('radius.mat','radius')
load('lambda.mat','lambda')
load('Fint.mat','Fint0')
str.arc_length.radius                        =  radius;
str.arc_length.lambda                        =  lambda;
str.arc_length.Fint0                         =  Fint0;
str.arc_length.arc_length_increment          =  1;
[str]                                        =  arclength_predictor(str);    
[str]                                        =  arclength_corrector(str);
[str]                                        =  plot_arclength_variation(str);    
save results.mat        
fprintf('\nThe radius used in the arc length step is %f',str.arc_length.radius);
fprintf('\nThe current number of arc length iterations used is %f',arc_length_iteration)
fprintf('\n---------------------------------------------------------')
fprintf('\n---------------------------------------------------------\n')

%--------------------------------------------------------------------------
% Reminder iterations.
%--------------------------------------------------------------------------
while arc_length_iteration<str.arc_length.total_arc_length_iterations
    arc_length_iteration                     =  arc_length_iteration + 1;
    str.arc_length.arc_length_increment      =  arc_length_iteration;
    [str]                                    =  automatic_radius_control(str);
    [str]                                    =  arclength_predictor(str);    
    [str]                                    =  arclength_corrector(str);
    switch str.arc_length.tolerance_warning
        case 'exceeded'
          while strcmp(str.arc_length.tolerance_warning,'exceeded')
             radius                          =  str.arc_length.radius;
             save ('results1','radius');
             clear             
             load results.mat
             load ('results1','radius')
             str.arc_length.radius           =  radius;
             str.arc_length.radius           =  str.arc_length.radius/2;
             [str]                           =  arclength_predictor(str);    
             [str]                           =  arclength_corrector(str);
             fprintf('\nThe radius used in the arc length step is %f',str.arc_length.radius);             
          end
          arc_length_iteration               =  arc_length_iteration - 1;
        case 'satisfied'
          fprintf('\nThe radius used in the arc length step is %f',str.arc_length.radius);
          fprintf('\nThe current number of arc length iterations used is %f',arc_length_iteration)
          [str]                              =  plot_arclength_variation(str);    
          str.time = arc_length_iteration;
          plot_potential(str)              
          if arc_length_iteration>2
          clf(2000)          
          end
          plot_phi(str)
          fprintf('\n---------------------------------------------------------')
          fprintf('\n---------------------------------------------------------\n')
          str.arc_length.lambda
          save results.mat                             
    end
          fprintf('\nThe radius used in the arc length step is %f',str.arc_length.radius);
          fprintf('\nThe current number of arc length iterations used is %f',arc_length_iteration)
          [str]                              =  plot_arclength_variation(str);    
          str.time = arc_length_iteration;
          plot_potential(str)              
          if arc_length_iteration>2
             clf(2000)          
          end
          plot_phi(str)
          fprintf('\n---------------------------------------------------------')
          fprintf('\n---------------------------------------------------------\n')
          str.arc_length.lambda    
          save results.mat                             
end

