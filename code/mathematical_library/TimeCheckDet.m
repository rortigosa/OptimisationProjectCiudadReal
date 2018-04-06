M   =  9;
out =  rand(M,M);
Out  = out;
out =  reshape(out,M,M);

NN  =  1e5;

tic
for ii=1:NN
J  =  det(Out);
end
toc

tic
for ii=1:NN
    out_  =  out;
%-------------------------- 
% Triangular matrix
%--------------------------
for k=2:M  
    for i=k:M
        pivot      =  out_((k-2)*M+i);
        for j=k-1:M
            out_(i+(j-1)*M) = (out_(i+(j-1)*M)*out_((k-2)*M+(k-1))/pivot - out_((k-1) +(j-1)*M))*(pivot/out_((k-2)*M+(k-1)));
        end
    end    
end
%--------------------------
% Compute determinant
%--------------------------
JJ   =  1;
for k=1:M
    JJ  =  JJ*out_(k+M*(k-1));
end
end
toc


tic
for ii=1:NN
    JJJ  =  CheckDet5(M,Out);
end
toc

