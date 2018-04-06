%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function creates a forth order tensor for the given matrix form of
% it.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Tensor]        =  third_order_tensor_creation(matrix)

Tensor                   =  zeros(3,3,3);
%------------------------------------------
% Mininum number of parameters necessary to 
% create the forth order tensor
% given the matrix.
%------------------------------------------

Tensor(1,1,1)                =  matrix(1,1);
Tensor(1,2,2)                =  matrix(1,2);
Tensor(1,3,3)                =  matrix(1,3);
Tensor(1,1,2)                =  0.5*matrix(1,4);
Tensor(1,2,1)                =  0.5*matrix(1,4);
Tensor(1,1,3)                =  0.5*matrix(1,5);
Tensor(1,3,1)                =  0.5*matrix(1,5);
Tensor(1,2,3)                =  0.5*matrix(1,6);
Tensor(1,3,2)                =  0.5*matrix(1,6);

Tensor(2,1,1)                =  matrix(2,1);
Tensor(2,2,2)                =  matrix(2,2);
Tensor(2,3,3)                =  matrix(2,3);
Tensor(2,1,2)                =  0.5*matrix(2,4);
Tensor(2,2,1)                =  0.5*matrix(2,4);
Tensor(2,1,3)                =  0.5*matrix(2,5);
Tensor(2,3,1)                =  0.5*matrix(2,5);
Tensor(2,2,3)                =  0.5*matrix(2,6);
Tensor(2,3,2)                =  0.5*matrix(2,6);

Tensor(3,1,1)                =  matrix(3,1);
Tensor(3,2,2)                =  matrix(3,2);
Tensor(3,3,3)                =  matrix(3,3);
Tensor(3,1,2)                =  0.5*matrix(3,4);
Tensor(3,2,1)                =  0.5*matrix(3,4);
Tensor(3,1,3)                =  0.5*matrix(3,5);
Tensor(3,3,1)                =  0.5*matrix(3,5);
Tensor(3,2,3)                =  0.5*matrix(3,6);
Tensor(3,3,2)                =  0.5*matrix(3,6);
