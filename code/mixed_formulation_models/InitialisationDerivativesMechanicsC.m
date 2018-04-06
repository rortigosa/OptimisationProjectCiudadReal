function str       =  InitialisationDerivativesMechanicsC(dim,n_gauss,str)

%--------------------------------------------------------------------------
% First derivatives of the internal energy when expressed in terms of C,G,c
%--------------------------------------------------------------------------
DU.DUDC            =  zeros(dim,dim,n_gauss);
DU.DUDG            =  zeros(dim,dim,n_gauss);
DU.DUDc            =  zeros(n_gauss,1);
%--------------------------------------------------------------------------
% Second derivatives of the internal energy when expressed in terms of
% C,G,c
%--------------------------------------------------------------------------
D2U.D2UDCDC        =  zeros(dim^2,dim^2,n_gauss);
D2U.D2UDCDG        =  zeros(dim^2,dim^2,n_gauss);
D2U.D2UDCDc        =  zeros(dim^2,1,n_gauss);
D2U.D2UDGDC        =  zeros(dim^2,dim^2,n_gauss);
D2U.D2UDGDG        =  zeros(dim^2,dim^2,n_gauss);
D2U.D2UDGDc        =  zeros(dim^2,1,n_gauss);
D2U.D2UDcDFC       =  zeros(1,dim^2,n_gauss);
D2U.D2UDcDHG       =  zeros(1,dim^2,n_gauss);
D2U.D2UDcDc        =  zeros(n_gauss,1);
%--------------------------------------------------------------------------
% Store all the derivatives
%--------------------------------------------------------------------------
str.mat_info.derivatives.DU      =  DU;
str.mat_info.derivatives.D2U     =  D2U;
