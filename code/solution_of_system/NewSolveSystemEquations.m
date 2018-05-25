%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Incremental solution (for free degrees of freedom)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
function dU                 =  NewSolveSystemEquations(freedof,fixdof,K,R,dU)

reduced_matrix              =  K;
reduced_matrix(fixdof,:)    =  [];
reduced_matrix(:,fixdof)    =  [];
%--------------------------------------------------------------------------
% Incremental solution
%--------------------------------------------------------------------------
% tic
dU(freedof)                 =  reduced_matrix\R(freedof,1); 
% toc
% tic
% eigs(reduced_matrix);
% toc 
% tic
% [v,c]=eigs(reduced_matrix,10,'sm');
% toc
% asdf=98