%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function  [P]        =  piezoelectric_moduli(Tensor,str)

switch str.data.dim
    case {2,12}        
         dim         =  2;         
    case {3,13,23}
         dim         =  3;
end

switch str.data.dim
    case {2,12}
         P           =  zeros(2,3,size(str.quadrature.Chi,1));
    case {3,13,23}
         P           =  zeros(3,6,size(str.quadrature.Chi,1));
end
switch dim
    case  3
          for igauss=1:size(str.quadrature.Chi,1)
              P(1,1,igauss)    =  Tensor(1,1,1,igauss);
              P(1,2,igauss)    =  Tensor(1,2,2,igauss);
              P(1,3,igauss)    =  Tensor(1,3,3,igauss);
              P(1,4,igauss)    =  0.5*(Tensor(1,1,2,igauss) + Tensor(1,2,1,igauss));
              P(1,5,igauss)    =  0.5*(Tensor(1,1,3,igauss) + Tensor(1,3,1,igauss));
              P(1,6,igauss)    =  0.5*(Tensor(1,2,3,igauss) + Tensor(1,3,2,igauss));
              P(2,1,igauss)    =  Tensor(2,1,1,igauss);
              P(2,2,igauss)    =  Tensor(2,2,2,igauss);
              P(2,3,igauss)    =  Tensor(2,3,3,igauss);
              P(2,4,igauss)    =  0.5*(Tensor(2,1,2,igauss) + Tensor(2,2,1,igauss));
              P(2,5,igauss)    =  0.5*(Tensor(2,1,3,igauss) + Tensor(2,3,1,igauss));
              P(2,6,igauss)    =  0.5*(Tensor(2,2,3,igauss) + Tensor(2,3,2,igauss));
              P(3,1,igauss)    =  Tensor(3,1,1,igauss);
              P(3,2,igauss)    =  Tensor(3,2,2,igauss);
              P(3,3,igauss)    =  Tensor(3,3,3,igauss);
              P(3,4,igauss)    =  0.5*(Tensor(3,1,2,igauss) + Tensor(3,2,1,igauss));
              P(3,5,igauss)    =  0.5*(Tensor(3,1,3,igauss) + Tensor(3,3,1,igauss));
              P(3,6,igauss)    =  0.5*(Tensor(3,2,3,igauss) + Tensor(3,3,2,igauss));
          end 
    case  2
          for igauss=1:size(str.quadrature.Chi,1)
              P(1,1,igauss)    =  Tensor(1,1,1,igauss);
              P(1,2,igauss)    =  Tensor(1,2,2,igauss);
              P(1,3,igauss)    =  0.5*(Tensor(1,1,2,igauss) + Tensor(1,2,1,igauss));
              P(2,1,igauss)    =  Tensor(2,1,1,igauss);
              P(2,2,igauss)    =  Tensor(2,2,2,igauss);
              P(2,3,igauss)    =  0.5*(Tensor(2,1,2,igauss) + Tensor(2,2,1,igauss));
          end
end