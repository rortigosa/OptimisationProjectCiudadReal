
function ExampleData  =  UserDefinedExampleData

ExampleData.max_load_factor         =  1;    %  Maximum load factor applied on the constant force
ExampleData.N_load_increments       =  1;  %  Number of load factors


ExampleData.loads                   =  [0.01;0.03;0.06;...
                                        0.1;0.3;0.6;...
                                        1;3;6]*1e-3;  % Plane stress
                                    
%ExampleData.loads                  =  3*1e-3;
ExampleData.loads                  =  1*1;
%ExampleData.loads = 0.05*1.973684210526316e+02;
%ExampleData.loads  =  6e-3;
                                    
%ExampleData.loads                   =  [0.01;1;3]*1e-3;                                    

% ExampleData.loads                   =  [0.01;1;3]*1e1;                                    
%ExampleData.loads                   =  [0.05]*1e1;      % Plane strain Transverse isotropy                              