%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  Initial acceleration
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function Solution        =  InitialAcceleration(Solution,Geometry,Data,Mesh,...
                                                UserDefinedFuncs,Bc,Assembly)

Bc                       =  NeumannBcs(Geometry.dim,Data.formulation,Mesh,UserDefinedFuncs,Bc);
%--------------------------------------------------------------------------
% Initial residual for static or dynamic cases
%--------------------------------------------------------------------------
Texternal                =  Bc.Neumann.force_vector;
a                        =  Assembly.MassMatrix(Bc.Dirichlet.freedof,Bc.Dirichlet.freedof)\(Texternal(Bc.Dirichlet.freedof) - ...
                               Assembly.DampingMatrix(Bc.Dirichlet.freedof,Bc.Dirichlet.freedof)*Solution.x.velocity(Bc.Dirichlet.freedof));

                           
Solution.x.acceleration(Bc.Dirichlet.freedof)  =  a;                           