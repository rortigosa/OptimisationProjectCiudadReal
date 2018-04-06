%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Given the elasticity tensor, and in general, any forth order tensor, this
% function computes the symmetrised matrix associated to it. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function  [C] =  elasticity_moduli(Tensor)


C(1,1)        =  Tensor(1,1,1,1);
C(1,2)        =  2*Tensor(1,1,2,2);
C(1,3)        =  2*Tensor(1,1,3,3);
C(1,4)        =  (Tensor(1,1,1,2) + Tensor(1,1,2,1));
C(1,5)        =  (Tensor(1,1,1,3) + Tensor(1,1,3,1));
C(1,6)        =  (Tensor(1,1,2,3) + Tensor(1,1,3,2));
C(2,2)        =  Tensor(2,2,2,2);
C(2,3)        =  2*Tensor(2,2,3,3);
C(2,4)        =  (Tensor(2,2,1,2) + Tensor(2,2,2,1));
C(2,5)        =  (Tensor(2,2,1,3) + Tensor(2,2,3,1));
C(2,6)        =  (Tensor(2,2,2,3) + Tensor(2,2,3,2));
C(3,3)        =  Tensor(3,3,3,3);
C(3,4)        =  (Tensor(3,3,1,2) + Tensor(3,3,2,1));
C(3,5)        =  (Tensor(3,3,1,3) + Tensor(3,3,3,1));
C(3,6)        =  (Tensor(3,3,2,3) + Tensor(3,3,3,2));
C(4,4)        =  0.5*(Tensor(1,2,1,2) + Tensor(1,2,2,1));
C(4,5)        =  (Tensor(1,2,1,3) + Tensor(1,2,3,1));
C(4,6)        =  (Tensor(1,2,2,3) + Tensor(1,2,3,2));
C(5,5)        =  0.5*(Tensor(1,3,1,3) + Tensor(1,3,3,1));
C(5,6)        =  (Tensor(1,3,2,3) + Tensor(1,3,3,2));
C(6,6)        =  0.5*(Tensor(2,3,2,3) + Tensor(2,3,2,3));

C             =  0.5*(C + C');
 