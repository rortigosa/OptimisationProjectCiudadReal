%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  For an invariant like psi = (Matrix*Vector)'*(Matrix*Vector), this
%  function computes the vectorised derivative: DpsiDMatrixDVector,
%  resulting in a 9x3 matrix in 3D or 4x2 in 2D
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function D_MVMV_DM_DV      =  DiffMatrixVectorMatrixVectorDiffMatrixDiffVector(dim,ngauss,Matrix,Vector)

D_MVMV_DM_DV               =  zeros(dim^2,dim,ngauss);
Imatrix                    =  eye(dim);
switch dim
    case 3
         for igauss=1:ngauss
             Repmatrix     =  [repmat(Matrix(1,:,igauss),3,1);...
                               repmat(Matrix(2,:,igauss),3,1);...
                               repmat(Matrix(3,:,igauss),3,1)];
             E0matrix2     =  repmat(Vector(:,igauss),3,1);
             MatrixVector  =  Matrix(:,:,igauss)*Vector(:,igauss);
             D_MVMV_DM_DV(:,:,...
                 igauss)   =  bsxfun(@times,Repmatrix,E0matrix2) + ...
                                    [MatrixVector(1)*Imatrix;...
                                     MatrixVector(2)*Imatrix;...
                                     MatrixVector(3)*Imatrix];
         end
    case 2
         for igauss=1:ngauss
             Repmatrix     =  [repmat(Matrix(1,:,igauss),2,1);...
                               repmat(Matrix(2,:,igauss),2,1)];
             E0matrix2     =  repmat(Vector(:,igauss),2,1);
             MatrixVector  =  Matrix(:,:,igauss)*Vector(:,igauss);
             D_MVMV_DM_DV(:,:,...
                 igauss)   =  bsxfun(@times,Repmatrix,E0matrix2) + ...
                                    [MatrixVector(1)*Imatrix;...
                                     MatrixVector(2)*Imatrix];
         end
end