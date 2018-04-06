%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  This function computes the shape functions and derivatives of the shape
%  functions in the postprocessing nodes of the elements associated to 
%  the discretisations used in different formulations. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function str                                      =  ShapeFunctionPostprocessingNodes(str)
 
%--------------------------------------------------------------------------
% The quadrature rule coincides with the postprocessing nodes
%--------------------------------------------------------------------------
new_str.quadrature                                =  str.quadrature.volume.bilinear;
iso_coordinates                                   =  IsoparametricCoordinatesNodesElem(str.fem.shape,str.fem.degree.postprocessing,str.geometry.dim);
new_str.quadrature.Chi                            =  iso_coordinates;

switch str.data.formulation
    case 'u'
         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.x.N               =  N;
         str.fem.postprocessing.x.DN_chi          =  DN_chi;
    case 'up'
         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.x.N               =  N;
         str.fem.postprocessing.x.DN_chi          =  DN_chi;

         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.pressure,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.pressure.N        =  N;
         str.fem.postprocessing.pressure.DN_chi   =  DN_chi;
    case 'FHJ'
         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.x.N               =  N;
         str.fem.postprocessing.x.DN_chi          =  DN_chi;

         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.phi,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.phi.N             =  N;
         str.fem.postprocessing.phi.DN_chi        =  DN_chi;

         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.F,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.F.N               =  N;
         str.fem.postprocessing.F.DN_chi          =  DN_chi;

         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.H,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.H.N               =  N;
         str.fem.postprocessing.H.DN_chi          =  DN_chi;
         
         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.J,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.J.N               =  N;
         str.fem.postprocessing.J.DN_chi          =  DN_chi;         
    case {'CGC','CGCCascade'}
         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.x.N               =  N;
         str.fem.postprocessing.x.DN_chi          =  DN_chi;

         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.phi,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.phi.N             =  N;
         str.fem.postprocessing.phi.DN_chi        =  DN_chi;

         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.C,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.C.N               =  N;
         str.fem.postprocessing.C.DN_chi          =  DN_chi;

         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.G,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.G.N               =  N;
         str.fem.postprocessing.G.DN_chi          =  DN_chi;
         
         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.c,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.c.N               =  N;
         str.fem.postprocessing.c.DN_chi          =  DN_chi;         
    case {'electro_mechanics','electo_BEM_FEM','electro_mechanics_Helmholtz','electro_mechanics_Helmholtz_BEM_FEM'}
         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.x.N               =  N;
         str.fem.postprocessing.x.DN_chi          =  DN_chi;

         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.phi,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.phi.N             =  N;
         str.fem.postprocessing.phi.DN_chi        =  DN_chi;
    case {'electro_mechanics_incompressible','electro_mechanics_incompressible_BEM_FEM',...
          'electro_mechanics_Helmholtz_incompressible','electro_mechanics_Helmholtz_incompressible_BEM_FEM'}
         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.x.N               =  N;
         str.fem.postprocessing.x.DN_chi          =  DN_chi;

         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.phi,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.phi.N             =  N;
         str.fem.postprocessing.phi.DN_chi        =  DN_chi;

         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.pressure,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.pressure.N        =  N;
         str.fem.postprocessing.pressure.DN_chi   =  DN_chi;
    case {'electro_mechanics_mixed_incompressible','electro_mechanics_mixed_incompressible_BEM_FEM'}
         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.x,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.x.N               =  N;
         str.fem.postprocessing.x.DN_chi          =  DN_chi;

         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.phi,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.phi.N             =  N;
         str.fem.postprocessing.phi.DN_chi        =  DN_chi;

         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.pressure,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.pressure.N        =  N;
         str.fem.postprocessing.pressure.DN_chi   =  DN_chi;

         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.F,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.F.N               =  N;
         str.fem.postprocessing.F.DN_chi          =  DN_chi;

         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.H,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.H.N               =  N;
         str.fem.postprocessing.H.DN_chi          =  DN_chi;
         
         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.J,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.J.N               =  N;
         str.fem.postprocessing.J.DN_chi          =  DN_chi;
         
         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.D0,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.D0.N              =  N;
         str.fem.postprocessing.D0.DN_chi         =  DN_chi;

         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.d,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.d.N               =  N;
         str.fem.postprocessing.d.DN_chi          =  DN_chi;         
    case {'electro_BEM_FEM'}
         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.phi,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.phi.N             =  N;
         str.fem.postprocessing.phi.DN_chi        =  DN_chi;
    case {'electro'}
         [N,DN_chi]                               =  ShapeFunctionComputation(str.fem.shape,str.fem.degree.phi,str.geometry.dim,new_str.quadrature);
         str.fem.postprocessing.phi.N             =  N;
         str.fem.postprocessing.phi.DN_chi        =  DN_chi;
end


