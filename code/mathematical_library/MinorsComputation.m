M   =  9;
out =  rand(M,M);
Out  = out;
out =  reshape(out,M,M);
 
% for i=2:M 
%     pivot    =  out(i);
%     for j=1:M  
%         out(i+(j-1)*M) = (out(i+(j-1)*M)*out(1)/pivot - out(1 +(j-1)*M))*(pivot/out(1));
%     end
% end
%     
% for i=3:M
%     pivot      =  out(M+i);
%     for j=2:M 
%         out(i+(j-1)*M) = (out(i+(j-1)*M)*out(M+2)/pivot - out(2 +(j-1)*M))*(pivot/out(M+2));        
%     end
% end
% 
% for i=4:M
%     pivot      =  out(2*M+i);
%     for j=3:M 
%         out(i+(j-1)*M) = (out(i+(j-1)*M)*out(2*M+3)/pivot - out(3 +(j-1)*M))*(pivot/out(2*M+3));        
%     end
% end
% 
% for i=5:M
%     pivot      =  out(3*M+i);
%     for j=4:M 
%         out(i+(j-1)*M) = (out(i+(j-1)*M)*out(3*M+4)/pivot - out(4 +(j-1)*M))*(pivot/out(3*M+4));        
%     end
% end

tic
for ii=1:1e5
J  =  det(Out);
end
toc


tic
for ii=1:1e5
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
% JJ   =  1;
% for k=1:M
%     JJ  =  JJ*out_(k+M*(k-1));
% end
end
toc


tic
for ii=1:1e5
    out__  =  out;
%-------------------------- 
% Triangular matrix
%--------------------------
for k=2:M  
    for j=k-1:M
        for i=k:M
            pivot      =  out__((k-2)*M+i);
            out__(i+(j-1)*M) = (out__(i+(j-1)*M)*out__((k-2)*M+(k-1))/pivot - out__((k-1) +(j-1)*M))*(pivot/out__((k-2)*M+(k-1)));
        end
    end    
end
%--------------------------
% Compute determinant
%--------------------------
% JJ   =  1;
% for k=1:M
%     JJ  =  JJ*out_(k+M*(k-1));
% end
end
toc


tic
for ii=1:1e5
out__ = CheckMinors10(M,Out);
    %--------------------------
% Compute determinant
%--------------------------
% JJ   =  1;
% for k=1:M
%     JJ  =  JJ*out__(k+M*(k-1));
% end
end
toc 


tic
for ii=1:1e5
out___ = CheckMinors11(M,Out);
    %--------------------------
% Compute determinant
%--------------------------
% JJ   =  1;
% for k=1:M
%     JJ  =  JJ*out__(k+M*(k-1));
% end
end
toc 


asdf=98

% for i=0; i<M*M; ++i) {
%        out[i] = 0.;
%     }
%     for (mwSize i=1; i<M; ++i) {
%         for (mwSize j=i-1; j<K; ++j) {
%             out[i+j*M]  =  out[i-1+(j-1)*M]
%                 out[k*M+i] += a[j*M+i]*b[k*K+j];
%             }
%         }
