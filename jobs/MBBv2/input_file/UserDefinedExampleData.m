
function ExampleData  =  UserDefinedExampleData

ExampleData.max_load_factor         =  1520;    %  Maximum load factor applied on the constant force
ExampleData.N_load_increments       =  3e2;  %  Number of load factors


ExampleData.loads                   =  [0.01;0.03;0.06;...
                                        0.1;0.3;0.6;...
                                        1;3;6]*1e-3;  % Plane stress
                                    
ExampleData.loads                  =  1*1e-3;
                                    
%ExampleData.loads                   =  [0.01;1;3]*1e-3;                                    

% ExampleData.loads                   =  [0.01;1;3]*1e1;                                    
%ExampleData.loads                   =  [0.05]*1e1;      % Plane strain Transverse isotropy                              