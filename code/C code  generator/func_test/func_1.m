function [A,B] = func_1(A,B,a,b,c,d,e)
 
for i = 1:a
aa         = b(1,1,i) * c(1,1,i) +  b(1,2,i) * c(1,2,i) + b(1,3,i) * c(1,3,i)...
           + b(2,1,i) * c(2,1,i) +  b(2,2,i) * c(2,2,i) + b(2,3,i) * c(2,3,i)...
           + b(3,1,i) * c(3,1,i) +  b(3,2,i) * c(3,2,i) + b(3,3,i) * c(3,3,i);

bb         = aa * (d(1,i) * d(1,i) + d(2,i) * d(2,i) + d(3,i) * d(3,i));
A(:,:,i)   = bb * c(:,:,i);

end


for i=1:e

dT         = d(:,i)';    
cc         = [c(1,1,i) * d(1,i) +  c(1,2,i) * d(1,i) + c(1,3,i) * d(1,i);...
              c(2,1,i) * d(2,i) +  c(2,2,i) * d(2,i) + c(2,3,i) * d(2,i);...
              c(3,1,i) * d(3,i) +  c(3,2,i) * d(3,i) + c(3,3,i) * d(3,i)];

dd         = dT * cc;
B(:,:,i)   = dd * b(:,:,i);

end