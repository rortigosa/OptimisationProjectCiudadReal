%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eliminate redundant nodes from a list of nodes
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [str]                                     =  redundant_nodes_elimination(str,X,connectivities)
 
 
flag                                               =  1;
n_nodes                                            =  size(X,2);
mapping                                            =  (1:n_nodes)';
mapping                                            =  [mapping mapping];
redundance_indicator                               =  [];
for icontinuum_node=2:n_nodes
    for jcontinuum_node=1:icontinuum_node-1
        difference                                 =  zeros(2,size(X,1));
        repeated_list                              =  ones(2,1);
        coordinates                                =  X(:,[icontinuum_node jcontinuum_node])';
        for inode=1:size(X,1)
            difference(:,inode)                    =  abs(diff([coordinates(:,inode);NaN]))<1e-4;
            repeated_list                          =  repeated_list & difference(:,inode);
        end
        criterion                                  =  double(repeated_list')*double(repeated_list);
        if criterion>0 
           mapping(icontinuum_node,2)              =  mapping(jcontinuum_node,2);
%           changing_nodes                          =  (icontinuum_node+1:n_nodes)';
%           mapping(changing_nodes,2)               =  mapping(changing_nodes,2) - 1;
           redundance_indicator(flag)              =  icontinuum_node;
           flag                                    =  flag + 1; 
        end
    end  
end 
   
old_mapping=mapping;
entity                                             =  mapping(:,2);
[Ordered_entity,Index]                             =  sortrows(entity);
total_component                                    =  0;
if Ordered_entity(1,1)>1
   Ordered_entity                                  =  Ordered_entity - (Ordered_entity(1,1)- 1);
end
for icomp=2:size(entity,1)
    total_component                                =  total_component + 1;
    if Ordered_entity(icomp,1)>max(Ordered_entity(1:icomp-1))+1
       Ordered_entity(icomp:size(Ordered_entity,1),...
           1)                                      =  Ordered_entity(icomp:size(Ordered_entity,1),1) -  (Ordered_entity(icomp,1)- (max(Ordered_entity(1:icomp-1))+1));
    end
end
x                                                  =  Ordered_entity;
y                                                  =  mapping(:,2);
[xprime,Index]                                     =  sortrows(y);
[xprimeprime,Indexx]                               =  sortrows(Index);
new_variable                                       =  x(Indexx);
mapping(:,2)                                       =  new_variable;


str.nodes(redundance_indicator,:)                  =  [];
str.solid.BEAM_SHELL.continuum.nodes               =  str.nodes;
str.solid.BEAM_SHELL.continuum.Lagrangian_X        =  str.nodes';
str.Lagrangian_X                                   =  str.nodes';
str.n_nodes                                        =  size(str.nodes,1);
str.solid.BEAM_SHELL.continuum.Eulerian_x          =  str.nodes';
str.Eulerian_x                                     =  str.nodes';

%--------------------------------------------------------------------------
%  Connectivities.
%--------------------------------------------------------------------------
connectivity_pattern                               =  mapping(:,2);
str.connectivity                                   =  connectivity_pattern(str.connectivity);
str.solid.BEAM_SHELL.continuum.connectivity_list   =  str.connectivity;
switch str.data.dim
    case 23
        str.solid.BEAM_SHELL.continuum.connectivity = str.solid.BEAM_SHELL.continuum.connectivity';
end
for imechanical_element=1:size(str.solid.BEAM_SHELL.discrete.mesh.connectivities,1)
    str.solid.BEAM_SHELL.continuum.connectivity{1,...
       imechanical_element}                        =  connectivity_pattern(str.solid.BEAM_SHELL.continuum.connectivity{1,imechanical_element});
end
str.n_elem                                         =  size(str.connectivity,1);

for idiscrete_element=1:size(str.solid.BEAM_SHELL.discrete.mesh.connectivities,1)
    for inode=1:size(str.solid.BEAM_SHELL.discrete.mesh.connectivities,2)
        str.solid.BEAM_SHELL.continuum.continuum_connectivities_at_discrete_node{inode,...
            idiscrete_element}                     =  connectivity_pattern(str.solid.BEAM_SHELL.continuum.continuum_connectivities_at_discrete_node{inode,...
                                                      idiscrete_element});
    end
end
asdf=98        
% %-----------------------------------------------------------------------
% % Round coordinates properly in order to be able to create the remeshing
% % and eliminate the redundant nodes.
% %-----------------------------------------------------------------------
% [str]                           =  mesh_parameters_analysis(str);
% L                               =  min(str.mesh_information.infimum_length);
% 
% L                               =  L/(str.data.degree*10);
% round_parameter                 =  round(log10(L))-1;
% round_parameter                 =  abs(round_parameter);
% rounded_X                       =  0*X;
% for idim=1:size(X,1)
%     rounded_X(idim,:)           =  round(X(idim,:)*10^round_parameter);
% end
% %-------------------------------------
% % Ordering process.  
% %-------------------------------------
% rounded_X                       =  rounded_X';
% 
% %---------------------------------
% % Sort the rows of the rounded coordinates.   
% %---------------------------------
% old_ordered_coor                =  [rounded_X     X'];
% [ordered_coor,index]            =  sortrows(rounded_X);   
% 
% %---------------------------------
% % Eliminate redundant nodes.
% %---------------------------------
% difference                      =  zeros(size(ordered_coor,1),size(X,1));
% repeated_list                   =  ones(size(ordered_coor,1),1);
% for inode=1:size(X,1)
%     difference(:,inode)         =  abs(diff([ordered_coor(:,inode);NaN]))<1e-4; 
%     repeated_list               =  repeated_list & difference(:,inode);
% end 
%   
% %---------------------------------
% % Get new numbering of the non redundant nodes.
% %---------------------------------
% flag1                           =  1;
% flag2                           =  0;
% node_number                     =  zeros(size(repeated_list,1),1);
% for iindex=1:size(repeated_list,1)
%     if flag2 
%        flag1                    =  flag1 + 1;
%        flag2                    =  0;
%     end    
%     if repeated_list(iindex,1)==0 
%        flag2                    =  1;
%     end       
%     node_number(iindex,1)       =  flag1;
% end 
%    
%  
% %--------------------------------- 
% % Get the coordinates of the nodes for the new number
% %--------------------------------- 
% [i,mapped_node_number]          =  sort(index);
% clear i
% old_ordered_coor                =  [old_ordered_coor  node_number(mapped_node_number,1)];
% nodes                           =  sortrows(old_ordered_coor,1:size(X,1));
% 
% [numbering,newindex]            =  unique(nodes(:,1:size(X,1)),'rows');
% 
% nodes(:,1:size(X,1))            =  [];
% 
% new_node_number                 =  node_number(index);
% 
% %--------------------------------------------------------------------------
% % Connectivities
% %--------------------------------------------------------------------------
% connectivities                  =  new_node_number(connectivities);
