% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  This function computes the shape functions and derivatives of the shape
%  functions in the nodes of the elements associated to the discretisations
%  used in different formulations. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
function str                             =  ShapeFunctionNodes(str)

switch str.data.formulation
    case 'u'
          str                            =  ShapeFunctionsNodesU(str);
    case 'up'
          str                            =  ShapeFunctionsNodesUP(str);
    case 'FHJ'
          str                            =  ShapeFunctionsNodesFHJ(str);
    case {'CGC','CGCCascade'}
          str                            =  ShapeFunctionsNodesCGC(str);
    case {'electro_mechanics','electro_mechanics_BEM_FEM','electro_mechanics_Helmholtz',...
          'electro_mechanics_Helmholtz_BEM_FEM','electro_BEM_FEM','electro'}
          str                            =  ShapeFunctionsNodesElectro(str);
    case {'electro_mechanics_incompressible','electro_mechanics_incompressible_BEM_FEM',...
          'electro_mechanics_Helmholtz_incompressible','electro_mechanics_Helmholtz_incompressible_BEM_FEM'}
          str                            =  ShapeFunctionsNodesElectroIncompressible(str);        
    case {'electro_mechanics_mixed_incompressible','electro_mechanics_mixed_incompressible_BEM_FEM'}
          str                            =  ShapeFunctionsNodesElectroMixedIncompressible(str);                
end
%--------------------------------------------------------------------------
% Shape functions for q0 in BEM/FEM problems.
%--------------------------------------------------------------------------
switch str.data.formulation
    case {'electro_BEM_FEM'}
iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.q,str.geometry.dim);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.q,str.geometry.dim,new_str.quadrature);
str.fem.volume.nodes.q.N                 =  N;
str.fem.volume.nodes.q.DN_chi            =  DN_chi;

iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.q,str.geometry.dim-1);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.q,str.geometry.dim-1,new_str.quadrature);
str.fem.surface.nodes.q.N                =  N;
str.fem.surface.nodes.q.DN_chi           =  DN_chi;

iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.q,str.geometry.dim-1);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,str.geometry.dim-1,new_str.quadrature);
str.fem.surface.nodes.phi.N_q            =  N;
str.fem.surface.nodes.phi.DN_q_chi       =  DN_chi;
    case {'electro_mechanics_BEM_FEM','electro_mechanics_incompressible_BEM_FEM','electro_mechanics_mixed_incompressible_BEM_FEM',...
          'electro_mechanics_Helmholtz_BEM_FEM','electro_mechanics_Helmholtz_incompressible_BEM_FEM'}
iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.q,str.geometry.dim);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.q,str.geometry.dim,new_str.quadrature);
str.fem.volume.nodes.q.N                 =  N;
str.fem.volume.nodes.q.DN_chi            =  DN_chi;

iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.q,str.geometry.dim-1);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.q,str.geometry.dim-1,new_str.quadrature);
str.fem.surface.nodes.q.N                =  N;
str.fem.surface.nodes.q.DN_chi           =  DN_chi;

iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.q,str.geometry.dim-1);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,str.geometry.dim-1,new_str.quadrature);
str.fem.surface.nodes.x.N_q              =  N;
str.fem.surface.nodes.x.DN_q_chi         =  DN_chi;

iso_coordinates                          =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.q,str.geometry.dim-1);
new_str.quadrature.Chi                   =  iso_coordinates;
[N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.phi,str.geometry.dim-1,new_str.quadrature);
str.fem.surface.nodes.phi.N_q            =  N;
str.fem.surface.nodes.phi.DN_q_chi       =  DN_chi;

end