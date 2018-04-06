function str          =  InitialisationDerivativesElectroMixed(dim,n_gauss,str)

%--------------------------------------------------------------------------
% First derivatives of the internal energy when expressed in terms of F, H,
% J, D0 and d
%--------------------------------------------------------------------------
DU.DUDF               =  zeros(dim,dim,n_gauss);
DU.DUDH               =  zeros(dim,dim,n_gauss);
DU.DUDJ               =  zeros(n_gauss,1);
DU.DUDD0              =  zeros(dim,n_gauss);
DU.DUDd               =  zeros(dim,n_gauss);
%--------------------------------------------------------------------------
% Second derivatives of the internal energy when expressed in terms of F,
% H, J, D0 and d
%--------------------------------------------------------------------------
D2U.D2UDFDF           =  zeros(dim^2,dim^2,n_gauss);
D2U.D2UDFDH           =  zeros(dim^2,dim^2,n_gauss);
D2U.D2UDFDJ           =  zeros(dim^2,1,n_gauss);
D2U.D2UDFDD0          =  zeros(dim^2,dim,n_gauss);
D2U.D2UDFDd           =  zeros(dim^2,dim,n_gauss);
D2U.D2UDHDF           =  zeros(dim^2,dim^2,n_gauss);
D2U.D2UDHDH           =  zeros(dim^2,dim^2,n_gauss);
D2U.D2UDHDJ           =  zeros(dim^2,1,n_gauss);
D2U.D2UDHDD0          =  zeros(dim^2,dim,n_gauss);
D2U.D2UDHDd           =  zeros(dim^2,dim,n_gauss);
D2U.D2UDJDF           =  zeros(1,dim^2,n_gauss);
D2U.D2UDJDH           =  zeros(1,dim^2,n_gauss);
D2U.D2UDJDJ           =  zeros(n_gauss,1);
D2U.D2UDJDD0          =  zeros(1,dim,n_gauss);
D2U.D2UDJDd           =  zeros(1,dim,n_gauss);
D2U.D2UDD0DF          =  zeros(dim,dim^2,n_gauss);
D2U.D2UDD0DH          =  zeros(dim,dim^2,n_gauss);
D2U.D2UDD0DJ          =  zeros(dim,1,n_gauss);
D2U.D2UDD0DD0         =  zeros(dim,dim,n_gauss);
D2U.D2UDD0Dd          =  zeros(dim,dim,n_gauss);
D2U.D2UDdDF           =  zeros(dim,dim^2,n_gauss);
D2U.D2UDdDH           =  zeros(dim,dim^2,n_gauss);
D2U.D2UDdDJ           =  zeros(dim,1,n_gauss);
D2U.D2UDdDD0          =  zeros(dim,dim,n_gauss);
D2U.D2UDdDd           =  zeros(dim,dim,n_gauss);
%--------------------------------------------------------------------------
% Store all the derivatives
%--------------------------------------------------------------------------
str.mat_info.derivatives.DU      =  DU;
str.mat_info.derivatives.D2U     =  D2U;
