function  ParaviewPostprocessorElectro(str,filename)

%switch str.geometry.dim
%    case 2
%        local_ordering      =  twoDlocal_ordering_nodes(str.fem.degree.phi);                                                            
%    case 3
%        local_ordering      =  threeDlocal_ordering_nodes(str.fem.degree.phi);                                                            
% end        
local_ordering               =  threeDlocal_ordering_nodes(str.fem.degree.phi);                                                            
dim                          =  str.geometry.dim; 
n_elem                       =  str.mesh.volume.n_elem;
%n_nodes                     =  (2^(str.geometry.dim)*1)*str.fem.degree.postprocessing^(str.geometry.dim)*n_elem;
%connectivity                =  reshape((1:n_nodes)',2^str.geometry.dim,[]);
n_nodes                      =  (str.fem.degree.postprocessing^dim)*8*n_elem;  % 8 nodes
connectivity                 =  reshape((1:n_nodes)',2^3,[]);
%--------------------------------------------------------------------------
%  Initialise postprocessing variables 
%--------------------------------------------------------------------------
X                            =  zeros(str.geometry.dim,n_nodes);
phi                          =  zeros(n_nodes,1);
E                            =  zeros(str.geometry.dim,n_nodes);
D                            =  zeros(str.geometry.dim,n_nodes);
%--------------------------------------------------------------------------
%  Loop over elements 
%--------------------------------------------------------------------------
fem                          =  str.fem.postprocessing;
final                        =  0;
for ielem=1:n_elem   
    ngauss                   =  str.mesh.volume.phi.n_node_elem;
    %----------------------------------------------------------------------
    % X and phi of the postprocessing mesh mesh 
    %----------------------------------------------------------------------
    Xelem                    =  zeros(str.geometry.dim,size(str.fem.volume.nodes.phi.N,2));
    phielem                  =  zeros(size(str.fem.volume.nodes.phi.N,2),1);
    for inode=1:size(str.fem.volume.nodes.phi.N,2)
        Xelem(:,inode)       =  str.solution.x.Lagrangian_X(:,str.mesh.volume.x.connectivity(:,ielem))*fem.phi.N(:,inode);        
        phielem(inode)       =  str.solution.phi(str.mesh.volume.phi.connectivity(:,ielem))'*fem.phi.N(:,inode);        
    end
    %----------------------------------------------------------------------
    % E
    %----------------------------------------------------------------------
    kinematics               =  KinematicsFunctionVolume(str.geometry.dim,...
                                        Xelem,Xelem,fem.phi.DN_chi);
    Eelem                    =  ElectricFieldComputation(str.geometry.dim,...
                                        str.solution.phi(str.mesh.volume.phi.connectivity(:,ielem)),...
                                        fem.phi.DN_chi,kinematics.DX_chi);
    %----------------------------------------------------------------------
    % First and second derivatives of the model  at every node of the
    % postprocdessing mesh
    %----------------------------------------------------------------------
    %Delem                    =  NewtonRaphsonLegendreTransformOnlyElectro(ielem,str.geometry.dim,ngauss,...
    %                                                       zeros(str.geometry.dim,ngauss),Eelem,str.vectorisation,...
    %                                                       str.material_information);  
    %----------------------------------------------------------------------
    % First Piola-Kirchhoff stress tensor.   
    %----------------------------------------------------------------------
    %for idegree=1:str.fem.degree.postprocessing^(str.geometry.dim)
    for idegree=1:str.fem.degree.postprocessing^(str.geometry.dim)
        initial              =  final + 1;
        %final               =  final + 2^str.geometry.dim;
        final                =  final + 2^3;

        XX                   =  repmat(Xelem,1,2);
        phiphi               =  repmat(phielem,2,1);
        EE                   =  repmat(Eelem,1,2);
%        DD                   =  repmat(Delem,1,2);
        X(:,initial:final)   =  XX(:,local_ordering(:,idegree));
        phi(initial:final)   =  phiphi(local_ordering(:,idegree));
        E(:,initial:final)   =  EE(:,local_ordering(:,idegree));
%        D(:,initial:final)   =  DD(:,local_ordering(:,idegree));
    end
end

phi                          =  reshape(phi,[],1);
switch str.geometry.dim
    case 2
         X                   =  [X;zeros(1,size(X,2))];
         Dx                  =  reshape(D(1,:),[],1);
         Dy                  =  reshape(D(2,:),[],1);         
         Ex                  =  reshape(E(1,:),[],1);
         Ey                  =  reshape(E(2,:),[],1);
         VTKPlot(filename,'unstructured_grid',X',connectivity','scalars','phi',phi,...
                                                           'scalars','Ex',Ex,...
                                                           'scalars','Ey',Ey,...
                                                           'scalars','Dx',Dx,...
                                                           'scalars','Dy',Dy) 
    case 3
         Dx                  =  reshape(D(1,:),[],1);
         Dy                  =  reshape(D(2,:),[],1);
         Dz                  =  reshape(D(3,:),[],1);
         Ex                  =  reshape(E(1,:),[],1);
         Ey                  =  reshape(E(2,:),[],1);
         Ez                  =  reshape(E(3,:),[],1);
         VTKPlot(filename,'unstructured_grid',X',connectivity','scalars','phi',phi,...
                                                           'scalars','Ex',Ex,...
                                                           'scalars','Ey',Ey,...
                                                           'scalars','Ez',Ez,...                                                           
                                                           'scalars','Dx',Dx,...
                                                           'scalars','Dy',Dy,...
                                                           'scalars','Dz',Dz) 
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


function local_ordering      =  twoDlocal_ordering_nodes(degree)                                                            
ordering1                    =  zeros(4,1);
iinode                       =  1;
for iy=1:2
    for ix=1:2
        ordering1(iinode)    =  ix + (iy - 1)*(degree + 1);
        iinode               =  iinode + 1;
    end
end
ordering2                    =  zeros(degree^2,1);
iinode                       =  1;
for iy=1:degree
    for ix=1:degree
        ordering2(iinode)    =  ix + (iy - 1)*(degree + 1);
        iinode               =  iinode + 1;
    end
end
local_ordering               =  zeros(4,str.fem.degree.phi);
for iielem=1:degree^2          
    local_ordering(:,iielem) =  ordering1 + (ordering2(iielem) - 1);
end
local_ordering               =  local_ordering([1 2 4 3],:);    
end


end