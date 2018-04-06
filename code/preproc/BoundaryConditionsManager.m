function Bc              =  BoundaryConditionsManager(dim,formulation,...
                                               load_factor,Mesh,Solution,...
                                               UserDefinedFuncs)
%--------------------------------------------------------------------------
% Dirichlet boundary conditions
%--------------------------------------------------------------------------
Bc                       =  DirichletBcs(dim,formulation,Mesh,Solution,...
                                         UserDefinedFuncs);
%--------------------------------------------------------------------------
% Neumann boundary conditions
%--------------------------------------------------------------------------
Bc.Neumann.load_factor   =  load_factor;
Bc                       =  NeumannBcs(dim,formulation,Mesh,...
                                       UserDefinedFuncs,Bc);

