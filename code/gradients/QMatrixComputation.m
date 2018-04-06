%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function computes the Q matrix for the co-factor
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function Qmatrix                   =  QMatrixComputation(Amatrix,dim,n_gauss)

switch dim
    case 2
         Qmatrix                   =  repmat([[0 0 0 1];[0 0 -1 0];[0 -1 0 0 ];[1 0 0 0]],1,1,n_gauss);
    case 3
         Qmatrix                   =  zeros(9,9,n_gauss);
         for igauss=1:n_gauss
             A                     =  Amatrix(:,:,igauss);
             Qmatrix(1,:,igauss)   =  [0  0  0  0  A(3,3) -A(3,2) 0 -A(2,3) A(2,2)];
             Qmatrix(2,:,igauss)   =  [0  0  0  -A(3,3)  0  A(3,1)  A(2,3)  0  -A(2,1)];
             Qmatrix(3,:,igauss)   =  [0  0  0  A(3,2)   -A(3,1)  0  -A(2,2)  A(2,1)  0];
             Qmatrix(4,:,igauss)   =  [0  -A(3,3)  A(3,2)  0  0  0  0  A(1,3)  -A(1,2)];
             Qmatrix(5,:,igauss)   =  [A(3,3)  0  -A(3,1)  0  0  0  -A(1,3)  0  A(1,1)];
             Qmatrix(6,:,igauss)   =  [-A(3,2)  A(3,1)  0  0  0  0  A(1,2)  -A(1,1)  0];
             Qmatrix(7,:,igauss)   =  [0  A(2,3)  -A(2,2)  0  -A(1,3)  A(1,2)  0  0  0];
             Qmatrix(8,:,igauss)   =  [-A(2,3)  0  A(2,1)  A(1,3)  0  -A(1,1)  0  0  0];
             Qmatrix(9,:,igauss)   =  [A(2,2)  -A(2,1)  0  -A(1,2)  A(1,1)  0  0  0  0];
         end
end
