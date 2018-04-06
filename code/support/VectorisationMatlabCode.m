function Vectorisation             =  VectorisationMatlabCode(dim,Quad,Mesh)

%--------------------------------------------------------------------------
% Vectorisation that transforms a 3x1 vector (in 3D) in a 3x9 matrix
% following a row-wise vectorisation
%--------------------------------------------------------------------------
switch dim
    case 2
         rowwise_LHS_indices        =  [1 3 6 8]';
         rowwise_RHS_indices        =  [1 2 1 2]';
    case 3
         rowwise_LHS_indices        =  [1 4 7 11 14 17 21 24 27]';
         rowwise_RHS_indices        =  [1 2 3 1 2 3 1 2 3]';
end
Vectorisation.vector2matrix_rowwise.LHS_indices  =  rowwise_LHS_indices;
Vectorisation.vector2matrix_rowwise.RHS_indices  =  rowwise_RHS_indices;
%--------------------------------------------------------------------------
% Vectorisation that transforms a 3x1 vector (in 3D) in a 3x9 matrix
% following a row-wise vectorisation for all the Gauss points.
%--------------------------------------------------------------------------
n_gauss                =  size(Quad.volume.bilinear.Chi,1);
LHS_indices_vector     =  zeros(dim^2,n_gauss);
RHS_indices_vector     =  zeros(dim^2,n_gauss);
for igauss=1:n_gauss
    switch dim
        case 2
             rowwise_LHS_indices        =  [1 3 6 8]';
             rowwise_RHS_indices        =  [1 2 1 2]';
        case 3
             rowwise_LHS_indices        =  [1 4 7 11 14 17 21 24 27]';
             rowwise_RHS_indices        =  [1 2 3 1 2 3 1 2 3]';
    end
    LHS_indices_vector(:,igauss)  =  rowwise_LHS_indices + (dim^3)*(igauss - 1);
    RHS_indices_vector(:,igauss)  =  rowwise_RHS_indices + dim*(igauss - 1);    
end
Vectorisation.vector2matrix_rowwise_Gauss_points.LHS_indices  =  LHS_indices_vector(:);
Vectorisation.vector2matrix_rowwise_Gauss_points.RHS_indices  =  RHS_indices_vector(:);
%--------------------------------------------------------------------------
% Vectorisation that transforms a 3x1 vector (in 3D) in a 3x9 matrix
% following a column-wise vectorisation
%--------------------------------------------------------------------------
switch dim
    case 2
         rowwise_LHS_indices        =  [1 4 5 8]';
         rowwise_RHS_indices        =  [1 1 2 2]';
    case 3
         rowwise_LHS_indices        =  [1 5 9 10 14 18 19 23 27]';
         rowwise_RHS_indices        =  [1 1 1 2 2 2 3 3 3]';
end
Vectorisation.vector2matrix_colwise.LHS_indices  =  rowwise_LHS_indices;
Vectorisation.vector2matrix_colwise.RHS_indices  =  rowwise_RHS_indices;
%--------------------------------------------------------------------------
% Vectorisation that transforms a 3x1 vector (in 3D) in a 3x9 matrix
% following a column-wise vectorisation for all the Gauss points
%--------------------------------------------------------------------------
n_gauss                =  size(Quad.volume.bilinear.Chi,1);
LHS_indices_vector     =  zeros(dim^2,n_gauss);
RHS_indices_vector     =  zeros(dim^2,n_gauss);
for igauss=1:n_gauss
    switch dim
        case 2
             colwise_LHS_indices        =  [1 3 6 8]';
             colwise_RHS_indices        =  [1 2 1 2]';
        case 3
             colwise_LHS_indices        =  [1 4 7 11 14 17 21 24 27]';
             colwise_RHS_indices        =  [1 2 3 1 2 3 1 2 3]';
    end
    LHS_indices_vector(:,igauss)  =  colwise_LHS_indices + (dim^3)*(igauss - 1);
    RHS_indices_vector(:,igauss)  =  colwise_RHS_indices + dim*(igauss - 1);    
end
Vectorisation.vector2matrix_colwise_Gauss_points.LHS_indices  =  LHS_indices_vector(:);
Vectorisation.vector2matrix_colwise_Gauss_points.RHS_indices  =  RHS_indices_vector(:);
%--------------------------------------------------------------------------
% These indices are needed for the sparse assembly required in the
% Newton-Raphson per Gauss points in order to get D0 from E0 (and  F, H, J)
% via exploiting the relationship between the internal and Helmholtz's
% energies
%--------------------------------------------------------------------------
n_gauss            =  size(Quad.volume.bilinear.Chi,1);
switch dim
    case 2
         indexi    =  reshape(repmat([1 2 1 2]',1,n_gauss) + repmat((0:2:2*(n_gauss-1)),4,1),[],1);
         indexj    =  reshape(repmat(1:2*n_gauss,2,1),[],1);
    case 3
         indexi    =  reshape(repmat([1 2 3 1 2 3 1 2 3]',1,n_gauss) + repmat((0:3:3*(n_gauss-1)),9,1),[],1);
         indexj    =  reshape(repmat(1:3*n_gauss,3,1),[],1);
end
Vectorisation.parallel_Newton_Raphson_inversion.indexi  =  indexi;
Vectorisation.parallel_Newton_Raphson_inversion.indexj  =  indexj;

%--------------------------------------------------------------------------
% This is the vectorisation required for the construction of the B matrices
% for C for all the Gauss points.
%--------------------------------------------------------------------------
n_gauss                =  size(Quad.volume.bilinear.Chi,1);
n_node_elem            =  Mesh.volume.x.n_node_elem;
LHS_indices_vector     =  zeros(dim^2*n_node_elem,n_gauss);
RHS_indices_vector     =  zeros(dim^2*n_node_elem,n_gauss);
for igauss=1:n_gauss
    switch dim 
       case 2 
            LHS_indices   =  repmat([1,3,5,6]',n_node_elem,1)+reshape(repmat(0:8:8*(n_node_elem-1),4,1),[],1);
            RHS_indices   =  repmat([1,2,2,1]',n_node_elem,1)+reshape(repmat(0:2:2*(n_node_elem-1),4,1),[],1);
       case 3
            LHS_indices   =  repmat([1,4,5,8,10,12,15,17,18]',n_node_elem,1) + reshape(repmat(0:27:27*(n_node_elem-1),9,1),[],1);
            RHS_indices   =  repmat([1,2,3,2,1,3,3,1,2]',n_node_elem,1)+reshape(repmat(0:3:3*(n_node_elem-1),9,1),[],1);
    end
    LHS_indices_vector(:,igauss)  =  LHS_indices + (dim^3*n_node_elem)*(igauss - 1);
    RHS_indices_vector(:,igauss)  =  RHS_indices + dim*n_node_elem*(igauss - 1);    
end
Vectorisation.BC_matrix.LHS_indices  =  LHS_indices_vector(:);
Vectorisation.BC_matrix.RHS_indices  =  RHS_indices_vector(:);


%--------------------------------------------------------------------------
% This is the vectorisation required for the construction of the B matrices
% for the deformation gradient tensor for all the Gauss points.
%--------------------------------------------------------------------------
n_gauss                =  size(Quad.volume.bilinear.Chi,1);
n_node_elem            =  Mesh.volume.x.n_node_elem;
LHS_indices_vector     =  zeros(dim^2*n_node_elem,n_gauss);
RHS_indices_vector     =  zeros(dim^2*n_node_elem,n_gauss);
for igauss=1:n_gauss
    switch dim 
       case 2 
            LHS_indices   =  repmat([1,2,7,8]',n_node_elem,1)+reshape(repmat(0:8:8*(n_node_elem-1),4,1),[],1);
            RHS_indices   =  repmat([1,2,1,2]',n_node_elem,1)+reshape(repmat(0:2:2*(n_node_elem-1),4,1),[],1);
       case 3
            LHS_indices   =  repmat([1,2,3,13,14,15,25,26,27]',n_node_elem,1) + reshape(repmat(0:27:27*(n_node_elem-1),9,1),[],1);
            RHS_indices   =  repmat([1,2,3,1,2,3,1,2,3]',n_node_elem,1)+reshape(repmat(0:3:3*(n_node_elem-1),9,1),[],1);
    end
    LHS_indices_vector(:,igauss)  =  LHS_indices + (dim^3*n_node_elem)*(igauss - 1);
    RHS_indices_vector(:,igauss)  =  RHS_indices + dim*n_node_elem*(igauss - 1);    
end
Vectorisation.Bx_matrix.LHS_indices  =  LHS_indices_vector(:);
Vectorisation.Bx_matrix.RHS_indices  =  RHS_indices_vector(:);

%--------------------------------------------------------------------------
% This is the vectorisation required for the construction of the shape 
% functions of F
%--------------------------------------------------------------------------
switch str.data.formulation
    case {'electro_mixed_incompressible','electro_mixed_incompressible_BEM_FEM'}
n_node_elem_F          =  Mesh.volume.F.n_node_elem;
switch dim
    case 2
         LHS_indices   =  reshape(repmat((1:2:2*n_node_elem_F - 1)',1,2) + repmat([0   2*n_node_elem_F + 1],n_node_elem_F,1),[],1);
         RHS_indices   =  repmat((1:n_node_elem_F)',dim,1);
    case 3
         LHS_indices   =  reshape(repmat((1:3:3*n_node_elem_F - 2)',1,3) + repmat([0   3*n_node_elem_F + 1     2*3*n_node_elem_F + 2],n_node_elem_F,1),[],1);
         RHS_indices   =  repmat((1:n_node_elem_F)',dim,1);        
end
Vectorisation.NF.LHS_indices  =  LHS_indices;
Vectorisation.NF.RHS_indices  =  RHS_indices;
%--------------------------------------------------------------------------
% This is the vectorisation required for the construction of the shape 
% functions of H
%--------------------------------------------------------------------------
n_node_elem_H          =  Mesh.volume.H.n_node_elem;
switch dim
    case 2
         LHS_indices   =  reshape(repmat((1:2:2*n_node_elem_H - 1)',1,2) + repmat([0   2*n_node_elem_H + 1],n_node_elem_H,1),[],1);
         RHS_indices   =  repmat((1:n_node_elem_H)',dim,1);
    case 3
         LHS_indices   =  reshape(repmat((1:3:3*n_node_elem_H - 2)',1,3) + repmat([0   3*n_node_elem_H + 1     2*3*n_node_elem_H + 2],n_node_elem_H,1),[],1);
         RHS_indices   =  repmat((1:n_node_elem_H)',dim,1);        
end
Vectorisation.NH.LHS_indices  =  LHS_indices;
Vectorisation.NH.RHS_indices  =  RHS_indices;
end

% %--------------------------------------------------------------------------
% % This vectorisation is required for boundary integrals related to the
% % linearisation of F^(-T)
% %--------------------------------------------------------------------------
% n_gauss                =  size(Quad.surface.bilinear.Chi,1);
% LHS_indices            =  1:dim^2+1:dim^4;
% RHS_indices            =  reshape(repmat(1:dim,dim,1),[],1);
% LHS_indices_vector     =  zeros(dim^2,n_gauss);
% RHS_indices_vector     =  zeros(dim^2,n_gauss);
% for igauss=1:n_gauss
%     LHS_indices_vector(:,igauss)  =  LHS_indices + dim^4*(igauss - 1);
%     RHS_indices_vector(:,igauss)  =  RHS_indices + dim*(igauss - 1);    
% end
% Vectorisation.DFminusT.LHS_indices  =  LHS_indices_vector(:);
% Vectorisation.DFminusT.RHS_indices  =  RHS_indices_vector(:);

%--------------------------------------------------------------------------
%  Vectorisation for the B matrix for formulation in terms of C
%--------------------------------------------------------------------------
switch dim
    case 2
         %-----------------------------------------------------------------
         % Matrices 1 and 2
         %-----------------------------------------------------------------
         Vectorisation.BC.LHS_matrix1           =  [ 1;   2;   5;  6;...
                                                        11;  12;  15; 16];
         Vectorisation.BC.RHS_matrix1           =  [1;    3;   2;  4;...
                                                        1;    3;   2;  4];
         Vectorisation.BC.LHS_matrix2           =  [1;  3;  5;  7;  10; 12; 14; 16];
         Vectorisation.BC.RHS_matrix2           =  Vectorisation.BC.RHS_matrix1;
         %-----------------------------------------------------------------
         % DNX
         %-----------------------------------------------------------------
         Vectorisation.BC.LHS_DNX               =  zeros(dim^2,n_node_elem);
         Vectorisation.BC.RHS_DNX               =  zeros(dim^2,n_node_elem);
         for inode=1:n_node_elem
             Vectorisation.BC.LHS_DNX(:,inode)  =  [1; 3; 6; 8] + 8*(inode - 1);
             Vectorisation.BC.RHS_DNX(:,inode)  =  [1; 2; 1; 2] + 2*(inode-1);             
         end         
         Vectorisation.BC.LHS_DNX               =  Vectorisation.BC.LHS_DNX(:);
         Vectorisation.BC.RHS_DNX               =  Vectorisation.BC.RHS_DNX(:);
    case 3
         %-----------------------------------------------------------------
         % Matrices 1 and 2
         %-----------------------------------------------------------------
         Vectorisation.BC.LHS_matrix1           =  [ 1;   2;  3;  10;  11;  12;  19; 20; 21;...
                                                        31;  32; 33;  40;  41;  42;  49; 50; 51;...
                                                        61;  62; 63;  70;  71;  72;  79; 80; 81];
         Vectorisation.BC.RHS_matrix1           =  [1;    4;  7;  2; 5; 8;  3;  6;  9;...
                                                        1;    4;  7;  2; 5; 8;  3;  6;  9;...
                                                        1;    4;  7;  2; 5; 8;  3;  6;  9];
         Vectorisation.BC.LHS_matrix2           =  [1; 4; 7;  10; 13; 16; 19; 22; 25;...
                                                       29; 32; 35; 38; 41; 44; 47; 50; 53;...
                                                       57; 60; 63; 66; 69; 72; 75; 78; 81];
         Vectorisation.BC.RHS_matrix2           =  Vectorisation.BC.RHS_matrix1;
         %-----------------------------------------------------------------
         % DNX
         %-----------------------------------------------------------------
         Vectorisation.BC.LHS_DNX               =  zeros(dim^2,n_node_elem);
         Vectorisation.BC.RHS_DNX               =  zeros(dim^2,n_node_elem);
         for inode=1:n_node_elem
             Vectorisation.BC.LHS_DNX(:,inode)  =  [1; 4; 7; 11; 14; 17; 21; 24; 27] + 27*(inode - 1);
             Vectorisation.BC.RHS_DNX(:,inode)  =  [1; 2; 3; 1; 2; 3; 1; 2; 3] + 3*(inode-1);             
         end         
         Vectorisation.BC.LHS_DNX               =  Vectorisation.BC.LHS_DNX(:);
         Vectorisation.BC.RHS_DNX               =  Vectorisation.BC.RHS_DNX(:);
end                   

%--------------------------------------------------------------------------
%  Vectorisation for of Second Piola for the geometric term
%--------------------------------------------------------------------------
switch dim
    case 2
         Vectorisation.S.LHS                    =  [ 1;   2;   5;  6;...
                                                        11;  12;  15; 16];
         Vectorisation.S.RHS1                   =  [1;    3;   2;  4;...
                                                        1;    3;   2;  4];
         Vectorisation.S.RHS2                   =  [1;    2;   3;  4;...
                                                        1;    2;   3;  4];
    case 3
         %-----------------------------------------------------------------
         % Matrices 1 and 2
         %-----------------------------------------------------------------
         Vectorisation.S.LHS                    =  [ 1;   2;  3;  10;  11;  12;  19; 20; 21;...
                                                        31;  32; 33;  40;  41;  42;  49; 50; 51;...
                                                        61;  62; 63;  70;  71;  72;  79; 80; 81];
         Vectorisation.S.RHS1                   =  [1;    4;  7;  2; 5; 8;  3;  6;  9;...
                                                        1;    4;  7;  2; 5; 8;  3;  6;  9;...
                                                        1;    4;  7;  2; 5; 8;  3;  6;  9];
         Vectorisation.S.RHS2                   =  [1;    2;  3;  4; 5; 6;  7;  8;  9;...
                                                        1;    2;  3;  4; 5; 6;  7;  8;  9;...
                                                        1;    2;  3;  4; 5; 6;  7;  8;  9];
end

% %--------------------------------------------------------------------------
% % This is the vectorisation required for the construction of the B matrices
% % for the deformation gradient tensor for all the Gauss points in surface
% % integrals
% %--------------------------------------------------------------------------
% n_gauss                =  size(Quad.surface.bilinear.Chi,1);
% n_node_elem            =  size(Mesh.surface.x.boundary_edges,1);
% LHS_indices_vector     =  zeros(dim^2*n_node_elem,n_gauss);
% RHS_indices_vector     =  zeros(dim^2*n_node_elem,n_gauss);
% for igauss=1:n_gauss
%     switch dim 
%        case 2 
%             LHS_indices   =  repmat([1,2,7,8]',n_node_elem,1)+reshape(repmat(0:8:8*(n_node_elem-1),4,1),[],1);
%             RHS_indices   =  repmat([1,2,1,2]',n_node_elem,1)+reshape(repmat(0:2:2*(n_node_elem-1),4,1),[],1);
%        case 3
%             LHS_indices   =  repmat([1,2,3,13,14,15,25,26,27]',n_node_elem,1) + reshape(repmat(0:27:27*(n_node_elem-1),9,1),[],1);
%             RHS_indices   =  repmat([1,2,3,1,2,3,1,2,3]',n_node_elem,1)+reshape(repmat(0:3:3*(n_node_elem-1),9,1),[],1);
%     end
%     LHS_indices_vector(:,igauss)  =  LHS_indices + (dim^3*n_node_elem)*(igauss - 1);
%     RHS_indices_vector(:,igauss)  =  RHS_indices + dim*n_node_elem*(igauss - 1);    
% end
% Vectorisation.Bx_matrix_boundary.LHS_indices  =  LHS_indices_vector(:);
% Vectorisation.Bx_matrix_boundary.RHS_indices  =  RHS_indices_vector(:);
% %--------------------------------------------------------------------------
% % Vectorisation that transforms a 3x1 vector (in 3D) in a 3x9 matrix
% % following a row-wise vectorisation for all the Gauss points in the 
% % boundary.
% %--------------------------------------------------------------------------
% n_gauss                =  size(Quad.surface.bilinear.Chi,1);
% LHS_indices_vector     =  zeros(dim^2,n_gauss);
% RHS_indices_vector     =  zeros(dim^2,n_gauss);
% for igauss=1:n_gauss
%     switch dim
%         case 2
%              rowwise_LHS_indices        =  [1 3 6 8]';
%              rowwise_RHS_indices        =  [1 2 1 2]';
%         case 3
%              rowwise_LHS_indices        =  [1 4 7 11 14 17 21 24 27]';
%              rowwise_RHS_indices        =  [1 2 3 1 2 3 1 2 3]';
%     end
%     LHS_indices_vector(:,igauss)  =  rowwise_LHS_indices + (dim^3)*(igauss - 1);
%     RHS_indices_vector(:,igauss)  =  rowwise_RHS_indices + dim*(igauss - 1);    
% end
% Vectorisation.vector2matrix_rowwise_Gauss_points_boundary.LHS_indices  =  LHS_indices_vector(:);
% Vectorisation.vector2matrix_rowwise_Gauss_points_boundary.RHS_indices  =  RHS_indices_vector(:);
% %--------------------------------------------------------------------------
% % Vectorisation that transforms a 3x1 vector (in 3D) in a 3x9 matrix
% % following a column-wise vectorisation for all the Gauss points in the
% % boundary
% %--------------------------------------------------------------------------
% LHS_indices_vector     =  zeros(dim^2,n_gauss);
% RHS_indices_vector     =  zeros(dim^2,n_gauss);
% for igauss=1:n_gauss
%     switch dim
%         case 2
%              colwise_LHS_indices        =  [1 3 6 8]';
%              colwise_RHS_indices        =  [1 2 1 2]';
%         case 3
%              colwise_LHS_indices        =  [1 4 7 11 14 17 21 24 27]';
%              colwise_RHS_indices        =  [1 2 3 1 2 3 1 2 3]';
%     end
%     LHS_indices_vector(:,igauss)  =  colwise_LHS_indices + (dim^3)*(igauss - 1);
%     RHS_indices_vector(:,igauss)  =  colwise_RHS_indices + dim*(igauss - 1);    
% end
% Vectorisation.vector2matrix_colwise_Gauss_points_boundary.LHS_indices  =  LHS_indices_vector(:);
% Vectorisation.vector2matrix_colwise_Gauss_points_boundary.RHS_indices  =  RHS_indices_vector(:);


