syms DNXa0 DNXa1 DNXb0 DNXb1 aux
syms  H0  H1  H2  H3 
syms  H4  H5  H6  H7 
syms  H8  H9 H10 H11
syms H12 H13 H14 H15

H          =  [H0 H1 H2 H3 H4 H5 H6 H7 H8 H9 H10 H11 H12 H13 H14 H15];
H          =  reshape(H,4,4);  
DNXa       =  [DNXa0;DNXa1];
DNXb       =  [DNXb0;DNXb1];
Ba         =  aux*zeros(4,2);
Bb         =  aux*zeros(4,2);
Ba(1:2,1)  =  DNXa;
Ba(3:4,2)  =  DNXa;
Bb(1:2,1)  =  DNXb;
Bb(3:4,2)  =  DNXb;

K     =  transpose(Ba)*H*Bb;


