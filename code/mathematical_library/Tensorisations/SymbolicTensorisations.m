syms A0 A1 A2 A3 A4 A5 A6 A7 A8
syms B0 B1 B2 B3 B4 B5 B6 B7 B8
syms V0 V1 V2 U0 U1 U2

syms H10 H11 H12 H13 H14 H15 H16 H17 H18 H19
syms H20 H21 H22 H23 H24 H25 H26 H27 H28 H29
syms H30 H31 H32 H33 H34 H35 H36 H37 H38 H39
syms H40 H41 H42 H43 H44 H45 H46 H47 H48 H49
syms H50 H51 H52 H53 H54 H55 H56 H57 H58 H59
syms H60 H61 H62 H63 H64 H65 H66 H67 H68 H69
syms H70 H71 H72 H73 H74 H75 H76 H77 H78 H79 H80

syms D0   D1  D2  D3  D4  D5  D6  D7  D8  D9
syms D10 D11 D12 D13 D14 D15 D16 D17 D18 D19
syms D20 D21 D22 D23 D24 D25 D26

dim  =  3;
if dim==3
    %----------------------------------------------------------------------
    % 3D
    %----------------------------------------------------------------------
    A  =  reshape([A0; A1; A2; A3; A4; A5; A6; A7; A8],3,3);
    B  =  reshape([B0; B1; B2; B3; B4; B5; B6; B7; B8],3,3);
    V  =  [V0;V1;V2];
    U  =  [U0;U1;U2];
    H  =  reshape([H0   H1  H2  H3  H4  H5  H6  H7  H8  H9...
                   H10 H11 H12 H13 H14 H15 H16 H17 H18 H19...
                   H20 H21 H22 H23 H24 H25 H26 H27 H28 H29...
                   H30 H31 H32 H33 H34 H35 H36 H37 H38 H39...
                   H40 H41 H42 H43 H44 H45 H46 H47 H48 H49...
                   H50 H51 H52 H53 H54 H55 H56 H57 H58 H59...
                   H60 H61 H62 H63 H64 H65 H66 H67 H68 H69...
                   H70 H71 H72 H73 H74 H75 H76 H77 H78 H79 H80],3,3,3,3);
    D  =  reshape([D0   D1  D2  D3  D4  D5  D6  D7  D8  D9...
        D10 D11 D12 D13 D14 D15 D16 D17 D18 D19...
        D20 D21 D22 D23 D24 D25 D26],3,3,3);
elseif dim==2
    %----------------------------------------------------------------------
    % 2D
    %----------------------------------------------------------------------
    A  =  reshape([A0; A1; A2; A3;],2,2);
    B  =  reshape([B0; B1; B2; B3;],2,2);
    V  =  [V0;V1];
    U  =  [U0;U1];
    H  =  reshape([H0   H1  H2  H3  H4  H5  H6  H7  H8  H9...
                   H10 H11 H12 H13 H14 H15],2,2,2,2);
    D  =  reshape([D0   D1  D2  D3  D4  D5  D6  D7],2,2,2);
end

           
E         =  zeros(3,3,3);
E(1,2,3)  =  1;
E(3,1,2)  =  1;
E(2,3,1)  =  1;
E(2,1,3)  =  -1;
E(1,3,2)  =  -1;
E(3,2,1)  =  -1;
Tensor    =  c*zeros(3,3,3,3);    

for i=1:3
    for I=1:3
        for j=1:3
            for J=1:3
                Tensor(i,I,j,J)  =  Tensor(i,I,j,J) + A(i,I)*B(j,J);                            
            end
        end
    end
end

Tensor42    =  c*zeros(3,3,3,3);    
Tensor24    =  c*zeros(3,3,3,3);    
for i=1:3
    for I=1:3
        for j=1:3
            for J=1:3
                for p=1:3
                    for P=1:3
                        for q=1:3
                            for Q=1:3
                                Tensor42(i,I,j,J)  =  Tensor42(i,I,j,J) + H(i,I,p,P)*B(q,Q)*E(j,p,q)*E(J,P,Q);                            
                                Tensor24(i,I,j,J)  =  Tensor24(i,I,j,J) + E(i,p,q)*E(I,P,Q)*B(p,P)*H(q,Q,j,J);                            
                            end
                        end
                    end
                end
            end
        end
    end
end

Tensor1  =  c*zeros(dim,dim,dim,dim);
Tensor2  =  c*zeros(dim,dim,dim,dim);

for i=1:dim
    for I=1:dim
        for j=1:dim
            for J=1:dim
                Tensor1(i,I,j,J)  =  D(i,I,j)*V(J);
                Tensor2(i,I,j,J)  =  D(i,j,J)*V(I);
            end
        end
    end
end
                
Tensor1  =  zeros(dim,dim,dim,dim)*c;
for i=1:dim
    for I=1:dim
        for j=1:dim
            for J=1:dim
                Tensor1(i,I,j,J)  =  A(i,j)*U(I)*V(J);                
            end
        end
    end
end

Tensor1  =  zeros(3,3,3)*c;
for i=1:3
    for I=1:3
        for J=1:3
            for p=1:3
                for P=1:3
                    for q=1:3
                        for Q=1:3
                            Tensor1(i,I,J)  =  Tensor1(i,I,J) + E(i,p,q)*E(I,P,Q)*A(p,P)*D(q,Q,J);
                        end
                    end
                end
            end
        end
    end
end
            

