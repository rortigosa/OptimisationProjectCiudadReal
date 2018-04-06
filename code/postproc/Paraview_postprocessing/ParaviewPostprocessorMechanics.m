function  ParaviewPostprocessorMechanics(str,filename)

local_ordering                   =  threeDlocal_ordering_nodes(str.fem.degree.x);                                                            
dim                              =  str.geometry.dim;
n_elem                           =  str.mesh.volume.n_elem;
n_nodes                          =  (2^(dim)*1)*str.fem.degree.postprocessing^(3)*n_elem;
connectivity                     =  reshape((1:n_nodes)',2^3,[]);
mat_info                         =  str.material_information;
%--------------------------------------------------------------------------
%  Initialise postprocessing variables 
%--------------------------------------------------------------------------
X                                =  zeros(dim,n_nodes);
x                                =  zeros(dim,n_nodes);
F                                =  zeros(dim^2,n_nodes);
H                                =  zeros(dim^2,n_nodes);
J                                =  zeros(n_nodes,1);
Piola                            =  zeros(dim^2,n_nodes);
Cauchy                           =  zeros(dim^2,n_nodes);
p                                =  zeros(n_nodes,1);
%--------------------------------------------------------------------------
%  Loop over elements 
%--------------------------------------------------------------------------
fem                              =  str.fem.postprocessing;
final                            =  0;
for ielem=1:n_elem   
    ngauss                       =  str.mesh.volume.x.n_node_elem;
    %----------------------------------------------------------------------
    % X and phi of the postprocessing mesh mesh 
    %----------------------------------------------------------------------
    Xelem                        =  VectorFEMInterpolation(ngauss,fem.x.N,str.solution.x.Lagrangian_X(:,str.mesh.volume.x.connectivity(:,ielem)));
    xelem                        =  VectorFEMInterpolation(ngauss,fem.x.N,str.solution.x.Eulerian_x(:,str.mesh.volume.x.connectivity(:,ielem)));
    %----------------------------------------------------------------------
    % Kinematics 
    %----------------------------------------------------------------------
    kinematics                   =  KinematicsFunctionVolume(dim,...
                                        xelem,Xelem,fem.x.DN_chi);
    Felem                        =  Matrix2Vector(dim^2,ngauss,kinematics.F);                                    
    Helem                        =  Matrix2Vector(dim^2,ngauss,kinematics.H);                                    
    Jelem                        =  kinematics.J;
    %----------------------------------------------------------------------
    % Kinetics
    %----------------------------------------------------------------------
    mat_info                     =  GetDerivativesModelMechanics(ielem,dim,ngauss,kinematics.F,kinematics.H,kinematics.J,...
                                                         mat_info);
    switch str.data.formulation
        case 'u'
             Piola_elem          =  FirstPiolaKirchhoffStressTensorU(ngauss,dim,kinematics.F,kinematics.H,...
                                                               mat_info.derivatives.DU.DUDF,...
                                                               mat_info.derivatives.DU.DUDH,...
                                                               mat_info.derivatives.DU.DUDJ);
        case 'up'
             pressure            =  ScalarFEMInterpolation(fem.pressure.N,str.solution.pressure(str.mesh.volume.pressure.connectivity(:,ielem)));
             Piola_elem          =  FirstPiolaKirchhoffStressTensorUP(ngauss,dim,kinematics.F,kinematics.H,...
                                                               mat_info.derivatives.DU.DUDF,...
                                                               mat_info.derivatives.DU.DUDH,...
                                                               mat_info.derivatives.DU.DUDJ,pressure);
    end
    Kirchhoff_elem               =  MatrixMatrixMultiplication(dim,dim,ngauss,Piola_elem,permute(kinematics.F,[2 1 3]));                                                           
    Cauchy_elem                  =  MatrixScalarMultiplication(dim,dim,ngauss,Kirchhoff_elem,1./kinematics.J);
    pelem                        =  TraceGauss(Cauchy_elem,ngauss);
    Piola_elem                   =  Matrix2Vector(dim^2,ngauss,Piola_elem);
    Cauchy_elem                  =  Matrix2Vector(dim^2,ngauss,Cauchy_elem);
    %----------------------------------------------------------------------
    % First Piola-Kirchhoff stress tensor.   
    %----------------------------------------------------------------------
    for idegree=1:str.fem.degree.postprocessing^(dim)
        initial                  =  final + 1;
        final                    =  final + 2^3;
        
        XX                       =  TwoD2ThreeDExtension(Xelem);
        xx                       =  TwoD2ThreeDExtension(xelem);
        FF                       =  TwoD2ThreeDExtension(Felem);
        HH                       =  TwoD2ThreeDExtension(Helem);
        JJ                       =  TwoD2ThreeDExtension(Jelem);
        PP                       =  TwoD2ThreeDExtension(Piola_elem);
        CC                       =  TwoD2ThreeDExtension(Cauchy_elem);
        pp                       =  TwoD2ThreeDExtension(pelem);
        
        X(:,initial:final)       =  XX(:,local_ordering(:,idegree));
        x(:,initial:final)       =  xx(:,local_ordering(:,idegree));
        F(:,initial:final)       =  FF(:,local_ordering(:,idegree));
        H(:,initial:final)       =  HH(:,local_ordering(:,idegree));
        J(initial:final)         =  JJ(local_ordering(:,idegree));
        Piola(:,initial:final)   =  PP(:,local_ordering(:,idegree));
        Cauchy(:,initial:final)  =  CC(:,local_ordering(:,idegree));
        p(initial:final)         =  pp(local_ordering(:,idegree));
    end
end

switch dim
    case 2
         X                   =  [X;zeros(1,size(X,2))];
         x                   =  [x;zeros(1,size(X,2))];
         ux                  =  reshape(x(1,:) - X(1,:),[],1);
         uy                  =  reshape(x(2,:) - X(2,:),[],1);
         Fxx                 =  reshape(F(1,:),[],1);
         Fxy                 =  reshape(F(2,:),[],1);
         Fyx                 =  reshape(F(3,:),[],1);
         Fyy                 =  reshape(F(4,:),[],1);
         Hxx                 =  reshape(H(1,:),[],1);
         Hxy                 =  reshape(H(2,:),[],1);
         Hyx                 =  reshape(H(3,:),[],1);
         Hyy                 =  reshape(H(4,:),[],1);
         J                   =  reshape(J,[],1);
         Pxx                 =  reshape(Piola(1,:),[],1);
         Pxy                 =  reshape(Piola(2,:),[],1);
         Pyx                 =  reshape(Piola(3,:),[],1);
         Pyy                 =  reshape(Piola(4,:),[],1);
         sigmaxx             =  reshape(Cauchy(1,:),[],1);
         sigmaxy             =  reshape(Cauchy(2,:),[],1);
         sigmayx             =  reshape(Cauchy(3,:),[],1);
         sigmayy             =  reshape(Cauchy(4,:),[],1);
         pressure            =  reshape(p,[],1);
         VTKPlot(filename,'unstructured_grid',X',connectivity','scalars','ux',ux,...
                                                           'scalars','uy',uy,...
                                                           'scalars','Fxx',Fxx,...
                                                           'scalars','Fxy',Fxy,...
                                                           'scalars','Fyx',Fyx,...
                                                           'scalars','Fyy',Fyy,...
                                                           'scalars','Hxx',Hxx,...
                                                           'scalars','Hxy',Hxy,...
                                                           'scalars','Hyx',Hyx,...
                                                           'scalars','Hyy',Hyy,...
                                                           'scalars','pressure',J,...
                                                           'scalars','Pxx',Pxx,...
                                                           'scalars','Pxy',Pxy,...
                                                           'scalars','Pyx',Pyx,...
                                                           'scalars','Pyy',Pyy,...
                                                           'scalars','sigmaxx',sigmaxx,...
                                                           'scalars','sigmaxy',sigmaxy,...
                                                           'scalars','sigmayx',sigmayx,...
                                                           'scalars','sigmayy',sigmayy,...
                                                           'scalars','pressure',pressure) 
    case 3
         ux                  =  reshape(x(1,:) - X(1,:),[],1);
         uy                  =  reshape(x(2,:) - X(2,:),[],1);
         uz                  =  reshape(x(3,:) - X(3,:),[],1);
         Fxx                 =  reshape(F(1,:),[],1);
         Fxy                 =  reshape(F(2,:),[],1);
         Fxz                 =  reshape(F(3,:),[],1);
         Fyx                 =  reshape(F(4,:),[],1);
         Fyy                 =  reshape(F(5,:),[],1);
         Fyz                 =  reshape(F(6,:),[],1);
         Fzx                 =  reshape(F(7,:),[],1);
         Fzy                 =  reshape(F(8,:),[],1);
         Fzz                 =  reshape(F(9,:),[],1);
         Hxx                 =  reshape(H(1,:),[],1);
         Hxy                 =  reshape(H(2,:),[],1);
         Hxz                 =  reshape(H(3,:),[],1);
         Hyx                 =  reshape(H(4,:),[],1);
         Hyy                 =  reshape(H(5,:),[],1);
         Hyz                 =  reshape(H(6,:),[],1);
         Hzx                 =  reshape(H(7,:),[],1);
         Hzy                 =  reshape(H(8,:),[],1);
         Hzz                 =  reshape(H(9,:),[],1);
         J                   =  reshape(J,[],1);
         Pxx                 =  reshape(Piola(1,:),[],1);
         Pxy                 =  reshape(Piola(2,:),[],1);
         Pxz                 =  reshape(Piola(3,:),[],1);
         Pyx                 =  reshape(Piola(4,:),[],1);
         Pyy                 =  reshape(Piola(5,:),[],1);
         Pyz                 =  reshape(Piola(6,:),[],1);
         Pzx                 =  reshape(Piola(7,:),[],1);
         Pzy                 =  reshape(Piola(8,:),[],1);
         Pzz                 =  reshape(Piola(9,:),[],1);
         sigmaxx             =  reshape(Cauchy(1,:),[],1);
         sigmaxy             =  reshape(Cauchy(2,:),[],1);
         sigmaxz             =  reshape(Cauchy(3,:),[],1);
         sigmayx             =  reshape(Cauchy(4,:),[],1);
         sigmayy             =  reshape(Cauchy(5,:),[],1);
         sigmayz             =  reshape(Cauchy(6,:),[],1);
         sigmazx             =  reshape(Cauchy(7,:),[],1);
         sigmazy             =  reshape(Cauchy(8,:),[],1);
         sigmazz             =  reshape(Cauchy(9,:),[],1);
         pressure            =  reshape(p,[],1);
         VTKPlot(filename,'unstructured_grid',X',connectivity','scalars','ux',ux,...
                                                           'scalars','uy',uy,...
                                                           'scalars','uz',uz,...                                                           
                                                           'scalars','Fxx',Fxx,...
                                                           'scalars','Fxy',Fxy,...
                                                           'scalars','Fxz',Fxz,...
                                                           'scalars','Fyx',Fyx,...
                                                           'scalars','Fyy',Fyy,...
                                                           'scalars','Fyz',Fyz,...
                                                           'scalars','Fzx',Fzx,...
                                                           'scalars','Fzy',Fzy,...
                                                           'scalars','Fzz',Fzz,...
                                                           'scalars','Hxx',Hxx,...
                                                           'scalars','Hxy',Hxy,...
                                                           'scalars','Hxz',Hxz,...
                                                           'scalars','Hyx',Hyx,...
                                                           'scalars','Hyy',Hyy,...
                                                           'scalars','Hyz',Hyz,...
                                                           'scalars','Hzx',Hzx,...
                                                           'scalars','Hzy',Hzy,...
                                                           'scalars','Hzz',Hzz,...
                                                           'scalars','pressure',J,...
                                                           'scalars','Pxx',Pxx,...
                                                           'scalars','Pxy',Pxy,...
                                                           'scalars','Pxz',Pxz,...
                                                           'scalars','Pyx',Pyx,...
                                                           'scalars','Pyy',Pyy,...
                                                           'scalars','Pyz',Pyz,...
                                                           'scalars','Pzx',Pzx,...
                                                           'scalars','Pzy',Pzy,...
                                                           'scalars','Pzz',Pzz,...
                                                           'scalars','sigmaxx',sigmaxx,...
                                                           'scalars','sigmaxy',sigmaxy,...
                                                           'scalars','sigmaxz',sigmaxz,...
                                                           'scalars','sigmayx',sigmayx,...
                                                           'scalars','sigmayy',sigmayy,...
                                                           'scalars','sigmayz',sigmayz,...
                                                           'scalars','sigmazx',sigmazx,...
                                                           'scalars','sigmazy',sigmazy,...
                                                           'scalars','sigmazz',sigmazz,...
                                                           'scalars','pressure',pressure) 
end

  
function local_ordering      =  threeDlocal_ordering_nodes(degree)                                                            
ordering1                    =  zeros(8,1);
iinode                       =  1;
for iz=1:2
    for iy=1:2
        for ix=1:2
            ordering1(iinode)=  ix + (iy - 1)*(degree + 1) + (iz - 1)*(degree + 1)^2;
            iinode           =  iinode + 1;
        end
    end
end
ordering2                    =  zeros(degree^3,1);
iinode                       =  1;
for iz=1:degree
    for iy=1:degree
        for ix=1:degree
            ordering2(iinode)=  ix + (iy - 1)*(degree + 1) + (iz - 1)*(degree + 1)^2;
            iinode           =  iinode + 1;
        end
    end
end
local_ordering               =  zeros(8,str.fem.degree.phi);
for iielem=1:degree^3           
    local_ordering(:,iielem) =  ordering1 + (ordering2(iielem) - 1);
end
local_ordering               =  local_ordering([1 2 4 3 5 6 8 7],:);    
end


function entity              =  TwoD2ThreeDExtension(entity)
entity                       =  repmat(entity,1,2);
    
end

% function local_ordering      =  twoDlocal_ordering_nodes(degree)                                                            
% ordering1                    =  zeros(4,1);
% iinode                       =  1;
% for iy=1:2
%     for ix=1:2
%         ordering1(iinode)    =  ix + (iy - 1)*(degree + 1);
%         iinode               =  iinode + 1;
%     end
% end
% ordering2                    =  zeros(degree^2,1);
% iinode                       =  1;
% for iy=1:degree
%     for ix=1:degree
%         ordering2(iinode)    =  ix + (iy - 1)*(degree + 1);
%         iinode               =  iinode + 1;
%     end
% end
% local_ordering               =  zeros(4,str.fem.degree.phi);
% for iielem=1:degree^2          
%     local_ordering(:,iielem) =  ordering1 + (ordering2(iielem) - 1);
% end
% local_ordering               =  local_ordering([1 2 4 3],:);    
% end
% 

end