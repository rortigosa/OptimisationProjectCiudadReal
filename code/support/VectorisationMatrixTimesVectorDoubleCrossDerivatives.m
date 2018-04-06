
symbolic  =  0;
switch symbolic
    case 1
syms E1 E2 E3 H11 H12 H13 H21 H22 H23 H31 H32 H33 aux

E0 =  [E1;E2;E3];
H  =  [[H11 H12 H13];[H21 H22 H23];[H31 H32 H33]];
T1 =  aux*zeros(3,3,3);
T2 =  aux*zeros(3,3,3);
    otherwise
H  =  randi(10,3,3);
E0 =  randi(10,3,1);
T1 =  zeros(3,3,3);
T2 =  zeros(3,3,3);
end
HE0   =  H*E0;
Identity  =  eye(3);
for i=1:3
    for I=1:3
        for J=1:3
            T1(i,I,J)  =  T1(i,I,J) + H(i,J)*E0(I);         
            T2(i,I,J)  =  T2(i,I,J) + HE0(i)*Identity(I,J);
        end
    end
end
vectorisedT1           =  reshape(permute(T1,[2 1 3]),9,3);
vectorisedT2           =  reshape(permute(T2,[2 1 3]),9,3);



Hmatrix  =  [repmat(H(1,:),3,1);...
             repmat(H(2,:),3,1);...
             repmat(H(3,:),3,1)];
Ematrix  =  repmat(E0,3,1);
vectorisedT1_ast  =  bsxfun(@times,Hmatrix,Ematrix);
vectorisedT2_ast  =  [HE0(1)*Identity;...
                      HE0(2)*Identity;...
                      HE0(3)*Identity];


