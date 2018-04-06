syms aux
%(AxB)_{pPiIqQ} = E_{ijk}E_{IJK}A_{pPjJ}B_{kKqQ}
syms   A0   A1   A2   A3   A4   A5   A6   A7   A8
syms   A9  A10  A11  A12  A13  A14  A15  A16  A17
syms  A18  A19  A20  A21  A22  A23  A24  A25  A26
syms  A27  A28  A29  A30  A31  A32  A33  A34  A35
syms  A36  A37  A38  A39  A40  A41  A42  A43  A44  
syms  A45  A46  A47  A48  A49  A50  A51  A52  A53
syms  A54  A55  A56  A57  A58  A59  A60  A61  A62
syms  A63  A64  A65  A66  A67  A68  A69  A70  A71
syms  A72  A73  A74  A75  A76  A77  A78  A79  A80

syms   B0   B1   B2   B3   B4   B5   B6   B7   B8
syms   B9  B10  B11  B12  B13  B14  B15  B16  B17
syms  B18  B19  B20  B21  B22  B23  B24  B25  B26
syms  B27  B28  B29  B30  B31  B32  B33  B34  B35
syms  B36  B37  B38  B39  B40  B41  B42  B43  B44  
syms  B45  B46  B47  B48  B49  B50  B51  B52  B53
syms  B54  B55  B56  B57  B58  B59  B60  B61  B62
syms  B63  B64  B65  B66  B67  B68  B69  B70  B71
syms  B72  B73  B74  B75  B76  B77  B78  B79  B80

A          =  [A0 A1 A2 A3 A4 A5 A6 A7 A8 A9 A10 A11 A12 A13 A14 A15...
               A16 A17 A18 A19 A20 A21 A22 A23 A24 A25 A26 A27 A28 A29 A30...
               A31 A32 A33 A34 A35 A36 A37 A38 A39 A40 A41 A42 A43 A44 A45...
               A46 A47 A48 A49 A50 A51 A52 A53 A54 A55 A56 A57 A58 A59 A60...
               A61 A62 A63 A64 A65 A66 A67 A68 A69 A70 A71 A72 A73 A74 A75...
               A76 A77 A78 A79 A80];

B          =  [B0 B1 B2 B3 B4 B5 B6 B7 B8 B9 B10 B11 B12 B13 B14 B15...
               B16 B17 B18 B19 B20 B21 B22 B23 B24 B25 B26 B27 B28 B29 B30...
               B31 B32 B33 B34 B35 B36 B37 B38 B39 B40 B41 B42 B43 B44 B45...
               B46 B47 B48 B49 B50 B51 B52 B53 B54 B55 B56 B57 B58 B59 B60...
               B61 B62 B63 B64 B65 B66 B67 B68 B69 B70 B71 B72 B73 B74 B75...
               B76 B77 B78 B79 B80];

A          =  reshape(A,3,3,3,3);           
B          =  reshape(B,3,3,3,3);           


E            =  zeros(3,3,3);
E(1,2,3)     =  1;
E(3,1,2)     =  1;
E(2,3,1)     =  1;
E(2,1,3)     =  -1;
E(1,3,2)     =  -1;
E(3,2,1)     =  -1;

AB            =  aux*zeros(3,3,3,3,3,3);
for p=1:3
    for P=1:3
        for i=1:3
            for I=1:3
                for j=1:3
                    for J=1:3
                        for k=1:3
                            for K=1:3
                                for q=1:3
                                    for Q=1:3
                                        AB(p,P,i,I,q,Q)   =  AB(p,P,i,I,q,Q) + E(i,j,k)*E(I,J,K)*A(p,P,j,J)*B(k,K,q,Q);
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

asdf=98        