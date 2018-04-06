%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function computes the compliance tensor given the matrix form of the
% elasticity tensor. Given the matrix expression for the elasticity tensor,
% we compute its inverse and then we get the matrix form of the compliance
% tensor. Afterward, we create the forth order tensor associated to that
% matrix.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [M]            =  compliance_tensor(CC)
 
%-----------------------------------------
% We invert the elasticity matrix. Thus, we
% get the compliance matrix.
%-----------------------------------------
SS                      =  inv(CC) ;
%-----------------------------------------
% Now we create the forth order tensor give
% the compliance matrix.
%-----------------------------------------
[M]                     =  fourth_order_tensor_creation(SS);


