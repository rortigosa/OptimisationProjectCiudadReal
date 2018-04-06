
% Inputs
a                   = 5e2;
e                   = 5e1;
b                   = randi(5e6,3,3,5e4);
c                   = randi(5e6,3,3,5e4);
d                   = randi(5e6,3,5e4);

% Initialise outputs
A                   = zeros(3,3,5e4);
B                   = zeros(3,3,5e4);

[A,B]               = func_1(A,B,a,b,c,d,e);


%--------------------------------------------------------------------------
% Compare computational time
%--------------------------------------------------------------------------
% tic;
% for i=1:1e2
% [A,B]               = func_1_mex(A,B,a,b,c,d,e);
% end
% toc
% T_mex               = toc;
% 
% 
% tic
% for i=1:1e2
% [A,B]               = func_1(A,B,a,b,c,d,e);
% end
% toc
% T                   = toc;
% 
% Scale               = T/T_mex