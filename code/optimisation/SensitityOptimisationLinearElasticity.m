function DIDrho     =  SensitityOptimisationLinearElasticity(x_elem,X_elem,...
                             p_elem,density,Klinear,void_factor)

%--------------------------------------------------------------------------
% Compute displacement
%--------------------------------------------------------------------------
u                   =  x_elem - X_elem;
%--------------------------------------------------------------------------
% Derivative
%--------------------------------------------------------------------------
DIDrho             =  density*(p_elem(:)'*Klinear(void_factor - 1)*u(:));

