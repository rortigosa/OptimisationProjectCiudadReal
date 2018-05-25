function [PiolaMatLab,D0MatLab,...
    ElasticityMatLab,PiezoMatLab]  =  MooneyRivlinIdealDielectricEnthalpyMatLab(dim,ngauss,mu1,mu2,lambda,epsilon,F,H,detF,E0)

%--------------------------------------------------------------------------   
% Second orcer identity matrix
%--------------------------------------------------------------------------   
Imatrix  =  eye(dim);
%--------------------------------------------------------------------------   
% Fourth order Identity matrices
%--------------------------------------------------------------------------   
I_ijIJ  =  zeros(dim,dim,dim,dim);    
I_iIjJ  =  zeros(dim,dim,dim,dim);    
I_iJjI  =  zeros(dim,dim,dim,dim);    
for i=1:dim
    for I=1:dim
        for j=1:dim
            for J=1:dim
                I_ijIJ(i,I,j,J)  =  Imatrix(i,j)*Imatrix(I,J);                
                I_iIjJ(i,I,j,J)  =  Imatrix(i,I)*Imatrix(j,J);                
                I_iJjI(i,I,j,J)  =  Imatrix(i,J)*Imatrix(j,I);                
            end
        end
    end
end
PiolaMatLab       =  zeros(dim,dim,ngauss);
ElasticityMatLab  =  zeros(dim,dim,dim,dim,ngauss);
PiezoMatLab       =  zeros(dim,dim,dim,ngauss);
D0MatLab          =  zeros(dim,ngauss);
for igauss=1:ngauss
%     /*-------------------------------------------------------------------*/
%     // AUXILIARY TENSORS
%     /*-------------------------------------------------------------------*/
    HT                  =  transpose(H(:,:,igauss));
    HE0                 =  H(:,:,igauss)*E0(:,igauss);
    HE0_E0              =  HE0*E0(:,igauss)';
    HTHE0               =  HT*HE0;
    E0_E0               =  E0(:,igauss)*E0(:,igauss)';
    HE0_HE0_invariant   =  HE0'*HE0;
    I4_E0E0             =  IijE0E0IJ(dim,Imatrix,E0_E0);
    %/*-------------------------------------------------------------------*/
    %// COMPUTE FIRST DERIVATIVES OF THE MODEL    
    %/*-------------------------------------------------------------------*/
     WF      =  mu1*F(:,:,igauss);
     WH      =  mu2*H(:,:,igauss) - epsilon/detF(igauss)*HE0_E0;
     PiolaH  =  trace(WH)*eye(dim) - WH';
     WJ      =  -(mu1 + 2*mu2)/detF(igauss) + lambda*(detF(igauss) - 1) + epsilon/(2*detF(igauss)^2)*HE0_HE0_invariant;    
     WE0     =  -epsilon/detF(igauss)*HTHE0;
    %/*-------------------------------------------------------------------*/
    %// COMPUTE FIRST PIOLA AND THE ELECTRIC DISPLACEMENT
    %/*-------------------------------------------------------------------*/    
     PiolaMatLab(:,:,igauss)    =  WF + PiolaH + WJ*H(:,:,igauss);    
     D0MatLab(:,igauss)         =  -WE0;
    %/*-------------------------------------------------------------------*/    
    %// AUXILIARY VARIABLES NEEDED
    %/*-------------------------------------------------------------------*/    
    D2H      =  I_iIjJ - I_iJjI;
    %//     Tensor<double,ndim,ndim,ndim,ndim> I_E0E0   =  outer(E0_E0,Imatrix);                 //delta_iI*(E0xE0)_jJ
    %//     Tensor<double,ndim,ndim,ndim,ndim> E0E0_I   =  outer(Imatrix,E0_E0);                 //(E0xE0)_iI*delta_jJ
    %//     Tensor<double,ndim,ndim,ndim,ndim> E0E0_I4  =  permutation<Index<1,3,2,4>>(E0E0_I);  // (E0xE0)_ij*delta_IJ 
    %/*-------------------------------------------------------------------*/    
    %// ELASTICITY TENSOR
    %/*-------------------------------------------------------------------*/            
    WFF        =  mu1*I_ijIJ;
    WHH        =  mu2*I_ijIJ - epsilon/detF(igauss)*I4_E0E0;
    WHJ        =  epsilon/detF(igauss)^2*HE0_E0;
    WJJ        =  (mu1 + 2*mu2)/(detF(igauss)^2) + lambda - epsilon/detF(igauss)^3*HE0_HE0_invariant;    
    DH_WHH_DH  =  DoubleContraction_4_4(D2H,DoubleContraction_4_4(WHH,D2H));
    H_H        =  outer_2_2(H(:,:,igauss),H(:,:,igauss));
    C_Geom     =  WJ*D2H;  
    DH_WHJ     =  DoubleContraction_4_2(D2H,WHJ);
    WJH_DH     =  DoubleContraction_2_4(WHJ,D2H);
    WHJTerm    =  outer_2_2(DH_WHJ,H) + outer_2_2(H,WJH_DH);
    ElasticityMatLab(:,:,:,:,igauss)  =  WFF + DH_WHH_DH + WJJ*H_H + C_Geom + WHJTerm;
    %//*---------------------------------------------------------------------
    WHE0       =  -(epsilon/detF(igauss))*(HE0iJI(dim,H(:,:,igauss),E0(:,igauss)) + HE0iIJ(dim,HE0));
    WJE0       =  epsilon/detF(igauss)^2*HTHE0;
    PiezoMatLab(:,:,:,igauss)  = DWHE0_DH_Tensor(D2H,WHE0) + DWJE0_H_Tensor(H,WJE0); 
end
    
function out  =  DWJE0_H_Tensor(A,B)
    out   =  zeros(dim,dim,dim);
    for i=1:dim
        for I=1:dim
            for J=1:dim
                out(i,I,J) = A(i,I)*B(I);         
            end
        end
    end
end

function out  =  DWHE0_DH_Tensor(A,B)
   out  =  zeros(dim,dim,dim);
   for i=1:dim
       for I=1:dim
           for p=1:dim
               for P=1:dim
                   for J=1:dim
                       out(i,I,J) =  out(i,I,J) + A(p,P,i,I)*B(p,P,J);                 
                   end
               end
           end
       end
   end   
end

function out  =  outer_2_2(A,B)
     for i=1:dim
         for I=1:dim
             for j=1:dim
                 for J=1:dim
                     out(i,I,j,J)  =  A(i,I)*B(j,J);             
                 end
             end
         end
     end
end
function out  =  DoubleContraction_4_4(A,B)    
    out   =  zeros(dim,dim,dim,dim);
     for i=1:dim
         for I=1:dim
             for j=1:dim
                 for J=1:dim
                     for k=1:dim
                         for K=1:dim
                             out(i,I,j,J)  =  out(i,I,j,J) + A(i,I,k,K)*B(k,K,j,J);             
                         end
                     end
                 end
             end
         end
     end
end

function out  =  DoubleContraction_4_2(A,B)    
    out   =  zeros(dim,dim);
     for i=1:dim
         for I=1:dim
             for j=1:dim
                 for J=1:dim
                     out(i,I)  =  out(i,I) + A(i,I,j,J)*B(j,J);             
                 end
             end
         end
     end
end

function out  =  DoubleContraction_2_4(A,B)
    out   =  zeros(dim,dim);
     for i=1:dim
         for I=1:dim
             for j=1:dim
                 for J=1:dim
                     out(i,I)  =  out(i,I) + A(j,J)*B(j,J,i,I);             
                 end
             end
         end
     end
end


function out  =  IijE0E0IJ(dim,Imatrix,A)
   out  =  zeros(dim,dim,dim,dim);
   for i=1:dim
       for I=1:dim
           for j=1:dim
               for J=1:dim
                   out(i,I,j,J)  =  Imatrix(i,j)*A(I,J);             
               end
           end
       end
   end
end
    
function out  =  HE0iJI(dim,H,E0)
   out  =  zeros(dim,dim,dim);
   for i=1:dim
       for I=1:dim
           for J=1:dim
               out(i,I,J)  =  H(i,J)*E0(I);             
           end
       end
   end
end

function out  =  HE0iIJ(dim,HE0)
   out  =  zeros(dim,dim,dim);
   Imatrix  =  eye(dim);
   for i=1:dim
       for I=1:dim
           for J=1:dim
               out(i,I,J)  =  HE0(i)*Imatrix(I,J);             
           end
       end
   end
end

end