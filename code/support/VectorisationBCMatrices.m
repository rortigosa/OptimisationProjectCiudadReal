
syms u1 u2 u3  DN1 DN2 DN3 F11 F12 F13 F21 F22 F23 F31 F32 F33 aux

F                  =  [[F11 F12 F13];[F21 F22 F23];[F31 F32 F33]];
u                  =  [u1;u2;u3];
DN                 =  [DN1;DN2;DN3];
DC                 =  (DN*transpose(u))*F + transpose(F)*(u*transpose(DN));
DCv                =  reshape(DC,[],1);
BC                 =  [[2*DN1*F11           2*DN1*F21            2*DN1*F31];...
                       [DN1*F12 + DN2*F11   DN1*F22 + DN2*F21    DN1*F32 + DN2*F31];...
                       [DN1*F13 + DN3*F11   DN1*F23 + DN3*F21    DN1*F33 + DN3*F31];...
                       [DN1*F12 + DN2*F11   DN1*F22 + DN2*F21    DN1*F32 + DN2*F31];...
                       [2*DN2*F12           2*DN2*F22            2*DN2*F32];...
                       [DN2*F13 + DN3*F12   DN2*F23 + DN3*F22    DN2*F33 + DN3*F32];...
                       [DN1*F13 + DN3*F11   DN1*F23 + DN3*F21    DN1*F33 + DN3*F31];...
                       [DN2*F13 + DN3*F12   DN2*F23 + DN3*F22    DN2*F33 + DN3*F32];...
                       [2*DN3*F13           2*DN3*F23            2*DN3*F33]];
DCv2               =  BC*u;   


FT                 =  transpose(F);
A                  = [DN(1)*FT;DN(2)*FT;DN(3)*FT];
B                  = [DN*reshape(F(:,1),1,3);DN*reshape(F(:,2),1,3);DN*reshape(F(:,3),1,3)];
BC1                =  A + B;
%--------------------------------------------------------------------------
%  A star
%--------------------------------------------------------------------------
Fmatrix1           =  aux*zeros(9,9);
Fmatrix1(1:3,1:3)  =  FT;
Fmatrix1(4:6,4:6)  =  FT;
Fmatrix1(7:9,7:9)  =  FT;
DNMatrix           =  aux*zeros(9,3);
DNMatrix(1:3,:)    =  DN1*eye(3);
DNMatrix(4:6,:)    =  DN2*eye(3);
DNMatrix(7:9,:)    =  DN3*eye(3);
Astar              =  Fmatrix1*DNMatrix;
%--------------------------------------------------------------------------
%  B star
%--------------------------------------------------------------------------
Fmatrix2           =  aux*zeros(9,9);
Fmatrix2(1,1:3)    =  F(:,1);
Fmatrix2(2,4:6)    =  F(:,1);
Fmatrix2(3,7:9)    =  F(:,1);
Fmatrix2(4,1:3)    =  F(:,2);
Fmatrix2(5,4:6)    =  F(:,2);
Fmatrix2(6,7:9)    =  F(:,2);
Fmatrix2(7,1:3)    =  F(:,3);
Fmatrix2(8,4:6)    =  F(:,3);
Fmatrix2(9,7:9)    =  F(:,3);
Bstar              =  Fmatrix2*DNMatrix;
%--------------------------------------------------------------------------
%  BC
%--------------------------------------------------------------------------
BC2                =  Astar + Bstar;






