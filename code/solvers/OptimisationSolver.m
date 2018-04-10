function OptimisationSolver(ExampleData,Optimisation,Data,TimeIntegrator,FEM,Quadrature,...
                            NR,UserDefinedFuncs,MatInfo,PostProc,results_folder)

%--------------------------------------------------------------------------
% Quadrature rules and shape functions
%--------------------------------------------------------------------------
Geometry       =  UserDefinedFuncs.Geometry();  
Quadrature     =  GetQuadratureRules(Quadrature,Geometry.dim);
FEM            =  FEMShapeFunctions(FEM,Quadrature,Geometry.dim,Data.formulation);
%--------------------------------------------------------------------------
% Meshing
%--------------------------------------------------------------------------
Mesh           =  MeshGenerationFormulation(FEM,Geometry,Data.formulation);
%--------------------------------------------------------------------------
% Initialisation of the formulation
%--------------------------------------------------------------------------
[Solution,NR,Assembly,FEM,...
 Quadrature,MatInfo]  =  InitialisationFormulation(Data,Geometry,FEM,Mesh,NR,Quadrature,MatInfo);
%--------------------------------------------------------------------------
% Start lood opver loads, models, etc.
%--------------------------------------------------------------------------
for load_increment=1:length(ExampleData.loads)   
    %----------------------------------------------------------------------
    % Initialise the density
    %----------------------------------------------------------------------
    if Geometry.dim==2
        xPhys  =  repmat(Optimisation.Volfrac,Geometry.Ny,Geometry.Nx);
    elseif Geometry.dim==3
        xPhys  =  repmat(Optimisation.Volfrac,Geometry.Ny,Geometry.Nx,Geometry.Nz);
    end
    %----------------------------------------------------------------------
    % Boundary conditions
    %----------------------------------------------------------------------
    %factor    =  (load_increment/ExampleData.N_load_increments)*ExampleData.max_load_factor;
    factor     =  (ExampleData.loads(load_increment)/ExampleData.N_load_increments)*ExampleData.max_load_factor;    
    Bc         =  BoundaryConditionsManager(Geometry.dim,Data.formulation,factor,Mesh,Solution,UserDefinedFuncs);    
    %----------------------------------------------------------------------
    % Results folder
    %----------------------------------------------------------------------
    cd(results_folder);
    output_folder           =  ['Volume_fraction_' num2str(Optimisation.Volfrac) '_' MatInfo.model '_model_load_factor_' num2str(factor)];
    dir.output_folder   =  [results_folder output_folder];
    mkdir(dir.output_folder);
    %----------------------------------------------------------------------
    % Solver
    %----------------------------------------------------------------------
    if Geometry.dim==2
       [xPhys,Solution]      =  Compliance2D(Geometry.Nx,Geometry.Ny,...
                                        Optimisation.Volfrac,Optimisation.rmin,...
                                        dir,xPhys,load_increment,Optimisation,...
                                        Geometry,Data,TimeIntegrator,FEM,Quadrature,NR,...
                                        MatInfo,Bc,Solution,Mesh,Assembly,...
                                        UserDefinedFuncs,PostProc);
    elseif Geometry.dim==3
       [xPhys,Solution]      =  Compliance3D(Geometry.Nx,Geometry.Ny,Geometry.Nz,...
                                        Optimisation.Volfrac,Optimisation.rmin,...
                                        dir,xPhys,load_increment,Optimisation,...
                                        Geometry,Data,TimeIntegrator,FEM,Quadrature,NR,...
                                        MatInfo,Bc,Solution,Mesh,Assembly,...
                                        UserDefinedFuncs,PostProc);
    end
    %----------------------------------------------------------------------
    % Saving to spec    ific folder
    %----------------------------------------------------------------------
    cd(fullfile(dir.output_folder))
    save('Results_Optimisation_.mat')
end




