function  Normal_vector =  CrossProduct(dim,V1,V2)

switch dim
    case 2
         N              =  cross([V1;0],[V2;0]);
         Normal_vector  =  N(1:2);
    case 3
         Normal_vector  =  cross(V1,V2);
end
