
function [chi_div,W_v_div]             =  QuadQuadratureSubDivision(Chi,W_v,dim)

n_divisions_half_space                 =  2;
switch n_divisions_half_space
    case 3
         Dchi1                         =  0.1;
         Dchi2                         =  0.3;
         Dchi                          =  [Dchi1;Dchi2;1-(Dchi1+Dchi2)];
    case 4
        Dchi1                          =  0.01;
        Dchi2                          =  0.1;
        Dchi3                          =  0.3;
        Dchi                           =  [Dchi1;Dchi2;Dchi3;1-(Dchi1+Dchi2+Dchi3)];
    otherwise
        Dchi                           =  repmat(1/n_divisions_half_space,n_divisions_half_space,1);
end

accumulated                            =  zeros(length(Dchi),1);
for idiv=2:length(Dchi)
    accumulated(idiv)                  =  accumulated(idiv-1) + Dchi(idiv-1);
end

Dchi                                   =  [Dchi;-Dchi];
accumulated                            =  [accumulated;-accumulated];
chi_div                                =  zeros(dim,size(Chi,1),length(Dchi));
W_v_div                                =  zeros(length(W_v),length(Dchi));
switch dim
    %----------------------------------------------------------------------      
    %----------------------------------------------------------------------      
    case 1
      for idiv=1:length(Dchi)
          chi_center                   =  accumulated(idiv) + Dchi(idiv)/2;  % center of the new integration domain
          chi_div(:,:,idiv)            =  chi_center + Chi'*abs(Dchi(idiv)/2);
          W_v_div(:,idiv)              =  W_v*abs(Dchi(idiv))/2;
      end
    %----------------------------------------------------------------------      
    %----------------------------------------------------------------------      
    case 2
      chi_div                          =  zeros(size(Chi,1),2,n_divisions_half_space);
      W_v_div                          =  zeros(size(W_v,1),n_divisions_half_space);
      for jdiv=2:length(Dchi)
          for idiv=2:length(Dchi)
              chi_center               =  [accumulated(idiv) + Dchi(idiv)/2;...
                                           accumulated(jdiv) + Dchi(jdiv)/2];  % center of the new integration domain
              chi_div(:,:,idiv)        =  chi_center + Chi'*abs(Dchi(idiv)/2);
              W_v_div(:,idiv)          =  W_v*abs(Dchi(idiv))/2;
          end
      end        
    %----------------------------------------------------------------------      
    %----------------------------------------------------------------------      
    case 3
      chi_div                          =  zeros(size(Chi,1),2,n_divisions_half_space);
      W_v_div                          =  zeros(size(W_v,1),n_divisions_half_space);
      for kdi=2:length(Dchi)
          for jdiv=2:length(Dchi)
              for idiv=2:length(Dchi)
                  chi_center           =  [accumulated(idiv) + Dchi(idiv)/2;...
                                           accumulated(jdiv) + Dchi(jdiv)/2;...
                                           accumulated(jdiv) + Dchi(jdiv)/2];  % center of the new integration domain
                  chi_div(:,:,idiv)     =  chi_center + Chi'*abs(Dchi(idiv)/2);
                  W_v_div(:,idiv)       =  W_v*abs(Dchi(idiv))/8;
              end
          end
      end                
end

chi_div                                =  reshape(chi_div,dim,[]);
chi_div                                =  chi_div';
W_v_div                                =  W_v_div(:);


