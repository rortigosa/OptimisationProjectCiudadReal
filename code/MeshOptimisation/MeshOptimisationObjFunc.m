%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%function [ObjFunc,DiffObjFunc]       =  MeshOptimisationObjFunc(mesh)
%function ObjFunc       =  MeshOptimisationObjFunc(NNodes,mesh)

ObjFunc      =  0; 
DiffObjFunc  =  zeros(size(mesh.nodes,1),mesh.n_nodes,1);
Imatrix      =  eye(size(mesh.nodes,1));
%Nodes        =  mesh.nodes;
f            =  @(x) x^2;
diff_f       =  @(x) 2*x;
% f            =  @(x) x^4;
% diff_f       =  @(x) 4*x^3;
% f            =  @(x) abs(x);
% diff_f       =  @(x) sign(x);

Nodes        =  mesh.nodes;
Nodes(:,mesh.interior_nodes) = NNodes;
for ielem=1:mesh.n_elem
    x     =  Nodes(:,mesh.connectivity(:,ielem));
    %x     =  mesh.nodes(:,mesh.connectivity(:,ielem));
    %----------------------------------------------------------------------
    % Compute objective function
    %----------------------------------------------------------------------
    % ---------------- Node 1 -------------------%
    x21      =  x(:,2) - x(:,1);
    x31      =  x(:,3) - x(:,1);    
    normx21  =  norm(x21);
    normx31  =  norm(x31);
    u21      =  x21/normx21;
    u31      =  x31/normx31;
    cos1     =  u21'*u31;
    % ---------------- Node 2 -------------------%
    x42      =  x(:,4) - x(:,2);    
    normx42  =  norm(x42);
    u42      =  x42/normx42;
    cos2     =  -u21'*u42;
    % ---------------- Node 3 -------------------%
    x43      =  x(:,4) - x(:,3);
    normx43  =  norm(x43);
    u43      =  x43/normx43;
    cos3     =  -u31'*u43;
    % ---------------- Node 4 -------------------%    
    cos4     =  u43'*u42;
    % -------- Contribution to ObjFunc -----------%    
    ObjFunc  =  ObjFunc + f(cos1) + f(cos2) + f(cos3) + f(cos4);
    %----------------------------------------------------------------------
    % Compute derivative of the objective function
    %----------------------------------------------------------------------
    % ---------------- Node 1 -------------------%    
    nodes                    =  mesh.connectivity(:,ielem);
    diffu21_x2               =  1/normx21*(Imatrix - u21*u21');
    diffu21_x1               =  -diffu21_x2;
    diffu31_x3               =  1/normx31*(Imatrix - u31*u31');
    diffu31_x1               =  -diffu31_x3;

    diffu42_x4               =  1/normx42*(Imatrix - u42*u42');
    diffu42_x2               =  -diffu42_x4;    

    diffu43_x4               =  1/normx43*(Imatrix - u43*u43');
    diffu43_x3               =  -diffu43_x4;
 
    
    DiffObjFunc(:,nodes(1))  =  DiffObjFunc(:,nodes(1)) + (diff_f(cos1)*diffu21_x1*u31 + ...
                                                           diff_f(cos1)*diffu31_x1*u21 - ...
                                                           diff_f(cos2)*diffu21_x1*u42 - ...
                                                           diff_f(cos3)*diffu31_x1*u43);              
    DiffObjFunc(:,nodes(2))  =  DiffObjFunc(:,nodes(2)) + (diff_f(cos1)*diffu21_x2*u31 - ...
                                                           diff_f(cos2)*diffu42_x2*u21 - ...
                                                           diff_f(cos2)*diffu21_x2*u42 + ...
                                                           diff_f(cos4)*diffu42_x2*u43);    
    DiffObjFunc(:,nodes(3))  =  DiffObjFunc(:,nodes(3)) + (diff_f(cos1)*diffu31_x3*u21 - ...
                                                           diff_f(cos3)*diffu31_x3*u43 - ...
                                                           diff_f(cos3)*diffu43_x3*u31 + ...
                                                           diff_f(cos4)*diffu43_x3*u42);              
    DiffObjFunc(:,nodes(4))  =  DiffObjFunc(:,nodes(4)) + (-diff_f(cos2)*diffu42_x4*u21 - ...
                                                            diff_f(cos3)*diffu43_x4*u31 + ...
                                                            diff_f(cos3)*diffu43_x4*u42 + ...
                                                            diff_f(cos4)*diffu42_x4*u43);                  
end    
%--------------------------------------------------------------------------    
% Remove derivative with respect to boundary positions
%--------------------------------------------------------------------------    
DiffObjFunc(:,mesh.boundary_nodes)  =  [];
