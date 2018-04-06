

asmb.Tx                =  zeros(8,1);
asmb.Kxx               =  zeros(8);

DU.DUDF       =  zeros(2,2,4);
DU.DUDH       =  zeros(2,2,4);
DU.DUDJ       =  zeros(4,1);
D2U.D2UDFDF   =  zeros(4,4,4);
D2U.D2UDFDH   =  zeros(4,4,4);
D2U.D2UDFDJ   =  zeros(4,1,4);
D2U.D2UDHDF   =  zeros(4,4,4);
D2U.D2UDHDH   =  zeros(4,4,4);
D2U.D2UDHDJ   =  zeros(4,1,4);
D2U.D2UDJDF   =  zeros(1,4,4);
D2U.D2UDJDH   =  zeros(1,4,4);
D2U.D2UDJDJ   =  zeros(4,1);
Piola_vect  =  zeros(4,4);

vect_kin.BF            =  zeros(4,8,4);
vect_kin.QF            =  zeros(4,4,4);
vect_kin.QSigmaH       =  zeros(4,4,4);

kinematics.F           =  zeros(2,2,4);
kinematics.H           =  zeros(2,2,4);
kinematics.J           =  zeros(4,1);

IntWeight              =  zeros(4,1);
dim                    =  2;
n_node_elem            =  4;
ngauss                 =  4;

asmb          =  ResidualsMatricesUC(asmb,DU,D2U,Piola_vect,vect_kin,kinematics,IntWeight,dim,n_node_elem,ngauss);

