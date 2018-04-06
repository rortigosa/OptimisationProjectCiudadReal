%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%  1. This function needs the following information:
%     -str.data.shape             == 1 or 0 depending on if the element is 
%                                    quadrilateral or triangular.
%     -str.data.degree            ==   of the polynomial used in the 
%                                    finite element interpolation.
%
%  2. This function will:
%  2.1 Store the Isoparametric coordinates of the Gauss points.
%  2.2 Store the weights used in the Gauss integration points.
%  In the case of 4 Gauss points, the information would be stored as
%  follows,
%  W  =  W_x_1*W_y_1      Points = chi_1    eta_1
%        W_x_2*W_y_1               chi_2    eta_2
%        W_x_1*W_y_2               chi_1    eta_2
%        W_x_2*W_y_2               chi_2    eta_2
%  
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


function [str]                                =  GaussQuadrature(str,order,dimension)
 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% 1. Data needed 
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

switch dimension
    case 1
         [X,W]                                =  GaussLegendre(order+1,-1,1);
         str.quadrature.Chi                   =  X';
         str.quadrature.W_v                   =  W;
         
    case 2
        %------------------------------------------------------------------
        %------------------------------------------------------------------
        %  2. Quadrilateral and cube elements.
        %------------------------------------------------------------------
        %------------------------------------------------------------------
        [X,W]                                =  GaussLegendre(order+1,-1,1);
        int_points1D                         =  (order+1);
        int_points                           =  int_points1D^(dimension);
        %------------------------------------------------------------------
        %  2.1.1. Weighting factors in the desired format
        %------------------------------------------------------------------
        t                                    =  0;
        W_v                                  =  zeros(int_points,1);
        for iloop1=1:int_points1D
            for iloop2=1:int_points1D
                t                            =  t+1;
                W_v(t)                       =  W(iloop1)*W(iloop2);
            end
        end
        %------------------------------------------------------------------
        %  2.2.2. Points in the desired format
        %------------------------------------------------------------------
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
        %------------------------------------------------------------------
        %  2.2.3. Recovery of data and final format
        %------------------------------------------------------------------
        for i=1:int_points
            str.quadrature.Chi(i,:)          =  [chi_v(i)  eta_v(i)];
        end
        str.quadrature.W_v                   =  W_v;
    case 3
         %-----------------------------------------------------------------
         %-----------------------------------------------------------------
         %  2. Quadrilateral and cube elements.
         %-----------------------------------------------------------------
         %-----------------------------------------------------------------
         [X,W]                                =  GaussLegendre(order+1,-1,1);
         int_points1D                         =  (order+1);
         int_points                           =  int_points1D^(dimension);
         %-----------------------------------------------------------------
         %  2.1.1. Weighting factors in the desired format
         %-----------------------------------------------------------------
         t                                    =  0;
         W_v                                  =  zeros(int_points,1);
         for iloop1=1:int_points1D
             for iloop2=1:int_points1D
                 for iloop3=1:int_points1D
                     t                        =  t+1;
                     W_v(t)                   =  W(iloop1)*W(iloop2)*W(iloop3);
                 end
             end
         end
         %-----------------------------------------------------------------
         %  2.2.2. Points in the desired format
         %-----------------------------------------------------------------
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
         %-----------------------------------------------------------------
         %  2.2.3. Recovery of data and final format
         %-----------------------------------------------------------------
         for i=1:int_points
             str.quadrature.Chi(i,:)          =  [chi_v(i)  eta_v(i)  iota_v(i)];
         end
         str.quadrature.W_v                   =  W_v;         
end

%--------------------------------------------------------------------------
% Number of integration points.
%--------------------------------------------------------------------------
str.data.int_points                           =  size(str.quadrature.Chi,1);


 