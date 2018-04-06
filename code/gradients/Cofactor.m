function H    =  Cofactor(F,dim)

switch dim
    case 2
         H  =  trace(F)*eye(2) - F';
    case 3
         H  =  0.5*JavierDoubleCrossProduct(F,F);
end