
function ExampleData  =  UserDefinedExampleData


ExampleData.max_load_factor         =  270;    %  Maximum load factor applied on the constant force
ExampleData.N_load_increments       =  3e2;  %  Number of load factors
ExampleData.loads                  =  [0.03;0.1;0.3;0.6;1;2.6;...
                                       5;10;20;30]*1e-3;  %This is for volume fraction 0.4


ExampleData.loads                 =  10e-3;                                   
% ExampleData.loads                  =  [0.03;0.3;]*1e-3;
% ExampleData.loads                  =  [1.2;5]*1e-3;
% ExampleData.loads                  =  5e-3;
%   ExampleData.loads                  =  [10;30]*1e-3;
% ExampleData.loads                  =  [30]*1e-3;
%ExampleData.loads                  =  [2;30]*1e-4;

