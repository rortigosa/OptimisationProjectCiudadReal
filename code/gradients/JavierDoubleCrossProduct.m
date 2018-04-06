%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This function computes the double two point cross product suggested by 
% prof. Javier Bonet. Given two matrices (3D), the double dot product 
% is defined as,
%
%  CiI   =  eijk eIJK  AjJ BkK
%
% For 2D, we must be careful. Thus, if one of the matrices is the
% deformation gradient, we need to add the deformation in the component
% 3,3. For derivatives of shape functions, or any other matrices,
% generally, the component 3,3 is always zero. This is the reason why we
% add the arguments thirdA and thirdB, which refer to the value of the 3,3
% component of A and B.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function C  =   JavierDoubleCrossProduct(A,B)

C           =  [[A(2,2)*B(3,3) - A(2,3)*B(3,2) - A(3,2)*B(2,3) + A(3,3)*B(2,2)        A(2,3)*B(3,1) - A(2,1)*B(3,3) - A(3,3)*B(2,1) + A(3,1)*B(2,3)     A(2,1)*B(3,2) - A(2,2)*B(3,1) - A(3,1)*B(2,2) + A(3,2)*B(2,1)];...
                [A(3,2)*B(1,3) - A(3,3)*B(1,2) - A(1,2)*B(3,3) + A(1,3)*B(3,2)        A(3,3)*B(1,1) - A(3,1)*B(1,3) - A(1,3)*B(3,1) + A(1,1)*B(3,3)     A(3,1)*B(1,2) - A(3,2)*B(1,1) - A(1,1)*B(3,2) + A(1,2)*B(3,1)];...
                [A(1,2)*B(2,3) - A(1,3)*B(2,2) - A(2,2)*B(1,3) + A(2,3)*B(1,2)        A(1,3)*B(2,1) - A(1,1)*B(2,3) - A(2,3)*B(1,1) + A(2,1)*B(1,3)     A(1,1)*B(2,2) - A(1,2)*B(2,1) - A(2,1)*B(1,2) + A(2,2)*B(1,1)]];
                                                        
