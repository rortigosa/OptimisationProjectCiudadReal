
syms DNXa0  DNXa1 DNXa2  
syms DNXb0  DNXb1 DNXb2
syms  H0  H1  H2  H3  H4  H5  H6  H7  H8  H9 
syms H10 H11 H12 H13 H14 H15 H16 H17 H18 H19 
syms H20 H21 H22 H23 H24 H25 H26 H27 H28 H29 
syms H30 H31 H32 H33 H34 H35 H36 H37 H38 H39 
syms H40 H41 H42 H43 H44 H45 H46 H47 H48 H49 
syms H50 H51 H52 H53 H54 H55 H56 H57 H58 H59 
syms H60 H61 H62 H63 H64 H65 H66 H67 H68 H69 
syms H70 H71 H72 H73 H74 H75 H76 H77 H78 H79 H80

syms  Q0  Q1  Q2  Q3  Q4  Q5  Q6  Q7  Q8  Q9 
syms Q10 Q11 Q12 Q13 Q14 Q15 Q16 Q17 Q18 Q19 
syms Q20 Q21 Q22 Q23 Q24 Q25 Q26 

syms  A0  A1  A2  A3  A4  A5  A6  A7  A8 


syms aux

dim  =  3;
if dim==2
   H  =  [H0;  H1;  H2;  H3;  H4;  H5;  H6;  H7;  H8;  H9;... 
          H10; H11; H12; H13; H14; H15];
   Q  =  [Q0;  Q1;  Q2;  Q3;  Q4;  Q5;  Q6;  Q7];
   A  =  [A0; A1; A2; A3];
   DNXa  =  [DNXa0;DNXa1];
   DNXb  =  [DNXb0;DNXb1];      
elseif dim==3
   H  =  [H0;  H1;  H2;  H3;  H4;  H5;  H6;  H7;  H8;  H9;... 
          H10; H11; H12; H13; H14; H15; H16; H17; H18; H19;... 
          H20; H21; H22; H23; H24; H25; H26; H27; H28; H29;...
          H30; H31; H32; H33; H34; H35; H36; H37; H38; H39;... 
          H40; H41; H42; H43; H44; H45; H46; H47; H48; H49;... 
          H50; H51; H52; H53; H54; H55; H56; H57; H58; H59;... 
          H60; H61; H62; H63; H64; H65; H66; H67; H68; H69;... 
          H70; H71; H72; H73; H74; H75; H76; H77; H78; H79; H80]; 
   Q  =  [Q0;  Q1;  Q2;  Q3;  Q4;  Q5;  Q6;  Q7;  Q8;  Q9;... 
          Q10; Q11; Q12; Q13; Q14; Q15; Q16; Q17; Q18; Q19;... 
          Q20; Q21; Q22; Q23; Q24; Q25; Q26]; 
   A  =  [A0; A1; A2; A3;  A4; A5; A6; A7; A8];
   DNXa  =  [DNXa0;DNXa1;DNXa2];
   DNXb  =  [DNXb0;DNXb1;DNXb2];
      
end
H  =  reshape(H,dim,dim,dim,dim);
Q  =  reshape(Q,dim,dim,dim);
A  =  reshape(A,dim,dim);
Kuu    =  aux*zeros(dim,dim);   
for i=1:dim
    for I=1:dim
        for j=1:dim
            for J=1:dim
                Kuu(i,j)  =  Kuu(i,j) +  DNXa(I)*DNXb(J)*H(i,I,j,J);               
            end
        end
    end
end

Kuphi  =  aux*zeros(dim,1);   
for i=1:dim
    for I=1:dim
        for J=1:dim
            Kuphi(i)  =  Kuphi(i) +  DNXa(I)*DNXb(J)*Q(i,I,J);               
        end
    end
end

Kphiphi  =  aux*0;   
for I=1:dim
    for J=1:dim
        Kphiphi  =  Kphiphi +  DNXa(I)*A(I,J)*DNXb(J);               
    end
end


 

    