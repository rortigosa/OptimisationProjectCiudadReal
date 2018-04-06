
function Chi      =  NodesIsoparametricSpace(dim,order)

X                                    =  linspace(-1,1,order+1);
int_points1D                         =  (order+1);
int_points                           =  int_points1D^(dim);
Chi                                  =  zeros(int_points,dim);
if dim==2
    t                                    =  0;
    chi_v                                =  zeros(int_points,1);
    eta_v                                =  zeros(int_points,1);
    for iloop1=1:int_points1D
        for iloop2=1:int_points1D
            t                            =  t+1;
            chi_v(t)                     =  X(iloop2);
            eta_v(t)                     =  X(iloop1);
        end
    end
    for i=1:int_points
        Chi(i,:)          =  [chi_v(i)  eta_v(i)];
    end
elseif dim==3
   t                                    =  0;
   chi_v                                =  zeros(int_points,1);
   eta_v                                =  zeros(int_points,1);
   iota_v                               =  zeros(int_points,1);
   for iloop1=1:int_points1D
       for iloop2=1:int_points1D
           for iloop3=1:int_points1D
               t                        =  t+1;
               chi_v(t)                 =  X(iloop3);
               eta_v(t)                 =  X(iloop2);
               iota_v(t)                =  X(iloop1);
           end
       end
   end
   for i=1:int_points
       Chi(i,:)          =  [chi_v(i)  eta_v(i)  iota_v(i)];
   end
end