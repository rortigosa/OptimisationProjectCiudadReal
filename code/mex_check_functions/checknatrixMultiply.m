A  =  rand(300,400);
B  =  rand(300,500);

N  =  1e2;
tic; 
for i=1:N
C=A'*B; 
end
toc

tic; 
for i=1:N
D = matrixMultiply(A,B); 
end
toc

