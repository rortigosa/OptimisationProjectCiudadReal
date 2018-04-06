function str       =  InitialisationDerivativesMechanics(dim,n_gauss,str)

%--------------------------------------------------------------------------
% First derivatives of the internal energy when expressed in terms of F, H,
% J, D0 and d
%--------------------------------------------------------------------------
DU.DUDF            =  zeros(dim,dim,n_gauss);
DU.DUDH            =  zeros(dim,dim,n_gauss);
DU.DUDJ            =  zeros(n_gauss,1);
%--------------------------------------------------------------------------
% Second derivatives of the internal energy when expressed in terms of F,
% H, J and D0
%--------------------------------------------------------------------------
D2U.D2UDFDF        =  zeros(dim^2,dim^2,n_gauss);
D2U.D2UDFDH        =  zeros(dim^2,dim^2,n_gauss);
D2U.D2UDFDJ        =  zeros(dim^2,1,n_gauss);
D2U.D2UDHDF        =  zeros(dim^2,dim^2,n_gauss);
D2U.D2UDHDH        =  zeros(dim^2,dim^2,n_gauss);
D2U.D2UDHDJ        =  zeros(dim^2,1,n_gauss);
D2U.D2UDJDF        =  zeros(1,dim^2,n_gauss);
D2U.D2UDJDH        =  zeros(1,dim^2,n_gauss);
D2U.D2UDJDJ        =  zeros(n_gauss,1);
%--------------------------------------------------------------------------
% Store all the derivatives
%--------------------------------------------------------------------------
str.mat_info.derivatives.DU      =  DU;
str.mat_info.derivatives.D2U     =  D2U;
