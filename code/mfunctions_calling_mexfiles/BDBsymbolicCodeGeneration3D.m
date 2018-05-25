syms DNXa0 DNXa1 DNXa2 DNXb0 DNXb1 DNXb2 aux
syms   H0   H1   H2   H3   H4   H5   H6   H7   H8
syms   H9  H10  H11  H12  H13  H14  H15  H16  H17
syms  H18  H19  H20  H21  H22  H23  H24  H25  H26
syms  H27  H28  H29  H30  H31  H32  H33  H34  H35
syms  H36  H37  H38  H39  H40  H41  H42  H43  H44  
syms  H45  H46  H47  H48  H49  H50  H51  H52  H53
syms  H54  H55  H56  H57  H58  H59  H60  H61  H62
syms  H63  H64  H65  H66  H67  H68  H69  H70  H71
syms  H72  H73  H74  H75  H76  H77  H78  H79  H80

H          =  [H0 H1 H2 H3 H4 H5 H6 H7 H8 H9 H10 H11 H12 H13 H14 H15...
               H16 H17 H18 H19 H20 H21 H22 H23 H24 H25 H26 H27 H28 H29 H30...
               H31 H32 H33 H34 H35 H36 H37 H38 H39 H40 H41 H42 H43 H44 H45...
               H46 H47 H48 H49 H50 H51 H52 H53 H54 H55 H56 H57 H58 H59 H60...
               H61 H62 H63 H64 H65 H66 H67 H68 H69 H70 H71 H72 H73 H74 H75...
               H76 H77 H78 H79 H80];
H          =  reshape(H,9,9);  
DNXa       =  [DNXa0;DNXa1;DNXa2];
DNXb       =  [DNXb0;DNXb1;DNXb2];
Ba         =  aux*zeros(9,3);
Bb         =  aux*zeros(9,3);
Ba(1:3,1)  =  DNXa;
Ba(4:6,2)  =  DNXa;
Ba(7:9,3)  =  DNXa;
Bb(1:3,1)  =  DNXb;
Bb(4:6,2)  =  DNXb;
Bb(7:9,3)  =  DNXb;

K     =  transpose(Ba)*H*Bb;


