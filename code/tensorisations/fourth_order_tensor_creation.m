%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function creates a forth order tensor for the given matrix form of
% it.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Tensor]        =  fourth_order_tensor_creation(matrix)

Tensor                   =  zeros(3,3,3,3);
%------------------------------------------
% Mininum number of parameters necessary to 
% create the forth order tensor
% given the matrix.
%------------------------------------------
Tensor(1,1,1,1)          =  matrix(1,1);
Tensor(1,1,2,2)          =  matrix(1,2);
Tensor(1,1,3,3)          =  matrix(1,3);
Tensor(1,1,1,2)          =  matrix(1,4);
Tensor(1,1,1,3)          =  matrix(1,5);
Tensor(1,1,2,3)          =  matrix(1,6);
Tensor(2,2,2,2)          =  matrix(2,2);
Tensor(2,2,3,3)          =  matrix(2,3);
Tensor(2,2,1,2)          =  matrix(2,4);
Tensor(2,2,1,3)          =  matrix(2,5);
Tensor(2,2,2,3)          =  matrix(2,6);
Tensor(3,3,3,3)          =  matrix(3,3);
Tensor(3,3,1,2)          =  matrix(3,4);
Tensor(3,3,1,3)          =  matrix(3,5);
Tensor(3,3,2,3)          =  matrix(3,6);
Tensor(1,2,1,2)          =  matrix(4,4);
Tensor(1,2,1,3)          =  matrix(4,5);
Tensor(1,2,2,3)          =  matrix(4,6);
Tensor(1,3,1,3)          =  matrix(5,5);
Tensor(1,3,2,3)          =  matrix(5,6);
Tensor(2,3,2,3)          =  matrix(6,6);
%------------------------------------------
% Creation of the remaining terms of the 
% tensor based on the symmetries of the 
% forth order tensor.
%------------------------------------------
Tensors                    =  zeros(3,3,3,3,5);
multp                      =  zeros(3,3,3,3,5);
%------------------------------------------
% Tensor i,j,k,l.
%------------------------------------------
Tensors(:,:,:,:,1)         =  Tensor;
for i=1:3
    for j=1:3
        for k=1:3
            for l=1:3
                if Tensors(i,j,k,l,1)
                   multp(i,j,...
                    k,l,1) =  1;
                end                
            end
        end
    end   
end
%------------------------------------------
% Tensor i,j,l,k.
%------------------------------------------
for i=1:3
    for j=1:3
        for k=1:3
            for l=1:3
                Tensors(i,j,...
                    k,l,2) =  Tensor(i,j,l,k);
                if Tensors(i,j,k,l,2)
                   multp(i,j,k,...
                      l,2) =  1;
                end                
            end
        end
    end   
end
%------------------------------------------
% Tensor j,i,k,l.
%------------------------------------------
for i=1:3
    for j=1:3
        for k=1:3
            for l=1:3
                Tensors(i,j,...
                    k,l,3) =  Tensor(j,i,k,l);
                if Tensors(i,j,k,l,3)
                   multp(i,j,k,...
                      l,3) =  1;
                end                
            end
        end
    end   
end
%------------------------------------------
% Tensor j,i,l,k.
%------------------------------------------
for i=1:3
    for j=1:3
        for k=1:3
            for l=1:3
                Tensors(i,j,...
                    k,l,4) =  Tensor(j,i,l,k);
                if Tensors(i,j,k,l,4)
                   multp(i,j,k,...
                      l,4) =  1;
                end                
            end
        end
    end   
end
%------------------------------------------
% Tensor k,l,i,j.
%------------------------------------------
for i=1:3
    for j=1:3
        for k=1:3
            for l=1:3
                Tensors(i,j,...
                    k,l,5) =  Tensor(k,l,i,j);
                if Tensors(i,j,k,l,5)
                   multp(i,j,k,...
                      l,5) =  1;
                end                
            end
        end
    end   
end
%------------------------------------------
% Tensor k,l,j,i.
%------------------------------------------
for i=1:3
    for j=1:3
        for k=1:3
            for l=1:3
                Tensors(i,j,...
                    k,l,6) =  Tensor(k,l,j,i);
                if Tensors(i,j,k,l,6)
                   multp(i,j,k,...
                      l,6) =  1;
                end                
            end
        end
    end   
end
%------------------------------------------
% Tensor l,k,i,j.
%------------------------------------------
for i=1:3
    for j=1:3
        for k=1:3
            for l=1:3
                Tensors(i,j,...
                    k,l,7) =  Tensor(l,k,i,j);
                if Tensors(i,j,k,l,7)
                   multp(i,j,k,...
                      l,7) =  1;
                end                
            end
        end
    end   
end
%------------------------------------------
% Tensor l,k,j,i.
%------------------------------------------
for i=1:3
    for j=1:3
        for k=1:3
            for l=1:3
                Tensors(i,j,...
                    k,l,8) =  Tensor(l,k,j,i);
                if Tensors(i,j,k,l,8)
                   multp(i,j,k,...
                      l,8) =  1;
                end                
            end
        end
    end   
end
%------------------------------------------
% Final tensor including symmetries.
%------------------------------------------
Tensor                     =  zeros(3,3,3,3);
multp_final                =  zeros(3,3,3,3);
for i=1:8
    Tensor                 =  Tensor + Tensors(:,:,:,:,i);  
    multp_final            =  multp_final + multp(:,:,:,:,i);
end
for i=1:3
    for j=1:3
        for k=1:3
            for l=1:3
                if multp_final(i,j,k,l)
                   Tensor(i,j,...
                    k,l)   =  Tensor(i,j,k,l)/multp_final(i,j,k,l);
%                  Tensor(i,j,...
%                   k,l)   =  Tensor(i,j,k,l)/8;
                end                
            end
        end
    end   
end




