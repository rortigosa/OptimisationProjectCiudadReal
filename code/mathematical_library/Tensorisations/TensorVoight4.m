%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
% Tensor Voigt notation for fourth order tensors
%
%  Ordering  =  zeros(dim^4,5);
% n  =  0;
% for l=1:dim
%     for k=1:dim
%         for j=1:dim
%             for i=1:dim
%                 n  =  n+1;
%                 Ordering(n,:)  =  [i j k l n];
%             end
%         end
%     end
% end
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
function Tensor_Voigt  =  TensorVoight4(Tensor,dim)  

if dim==2
   %-----------------------------------------------------------------------
   % Voigt notation: 11 22 (12+21). In addition, 
   %-----------------------------------------------------------------------
   %     i     j     k     l  component
   %    ------------------------------
   %     1     1     1     1  //  1
   %     2     1     1     1  //  2
   %     1     2     1     1  //  3
   %     2     2     1     1  //  4
   %     1     1     2     1  //  5
   %     2     1     2     1  //  6
   %     1     2     2     1  //  7
   %     2     2     2     1  //  8
   %     1     1     1     2  //  9
   %     2     1     1     2  // 10
   %     1     2     1     2  // 11
   %     2     2     1     2  // 12
   %     1     1     2     2  // 13
   %     2     1     2     2  // 14
   %     1     2     2     2  // 15
   %     2     2     2     2  // 16   
   %-----------------------------------------------------------------------
   Tensor_Voigt        =  zeros(3,3);

   Tensor_Voigt(1,1)   =  Tensor(1);  
   Tensor_Voigt(1,2)   =  Tensor(13);  
   Tensor_Voigt(1,3)   =  0.5*(Tensor(9) + Tensor(5));
   
   Tensor_Voigt(2,1)   =  Tensor_Voigt(1,2);
   Tensor_Voigt(2,2)   =  Tensor(16);
   Tensor_Voigt(2,3)   =  0.5*(Tensor(12) + Tensor(8));
   
   Tensor_Voigt(3,1)   =  Tensor_Voigt(1,3);
   Tensor_Voigt(3,2)   =  Tensor_Voigt(2,3);
   Tensor_Voigt(3,3)   =  0.5*(Tensor(11) + Tensor(7));

   Tensor_Voigt(1,1)   =  Tensor(1,1,1,1);  
   Tensor_Voigt(1,2)   =  Tensor(1,1,2,2);  
   Tensor_Voigt(1,3)   =  0.5*(Tensor(1,1,1,2) + Tensor(1,1,2,1));
   
   Tensor_Voigt(2,1)   =  Tensor_Voigt(1,2);
   Tensor_Voigt(2,2)   =  Tensor(2,2,2,2);
   Tensor_Voigt(2,3)   =  0.5*(Tensor(2,2,1,2) + Tensor(2,2,2,1));
   
   Tensor_Voigt(3,1)   =  Tensor_Voigt(1,3);
   Tensor_Voigt(3,2)   =  Tensor_Voigt(2,3);
   Tensor_Voigt(3,3)   =  0.5*(Tensor(1,2,1,2) + Tensor(1,2,2,1));
   
   
elseif dim==3
   %-----------------------------------------------------------------------
   % Voigt notation: 11 22 33 (12+21) (13+31) (23+32). In addition, 
   %-----------------------------------------------------------------------
   %      i     j     k     l   component
   %   ------------------------------------
   %      1     1     1     1    //  1
   %      2     1     1     1    //  2
   %      3     1     1     1    //  3
   %      1     2     1     1    //  4
   %      2     2     1     1    //  5
   %      3     2     1     1    //  6
   %      1     3     1     1    //  7
   %      2     3     1     1    //  8
   %      3     3     1     1    //  9
   %      1     1     2     1    // 10
   %      2     1     2     1    // 11
   %      3     1     2     1    // 12
   %      1     2     2     1    // 13
   %      2     2     2     1    // 14
   %      3     2     2     1    // 15
   %      1     3     2     1    // 16
   %      2     3     2     1    // 17
   %      3     3     2     1    // 18
   %      1     1     3     1    // 19
   %      2     1     3     1    // 20
   %      3     1     3     1    // 21
   %      1     2     3     1    // 22
   %      2     2     3     1    // 23
   %      3     2     3     1    // 24
   %      1     3     3     1    // 25
   %      2     3     3     1    // 26
   %      3     3     3     1    // 27
   %      1     1     1     2    // 28
   %      2     1     1     2    // 29
   %      3     1     1     2    // 30
   %      1     2     1     2    // 31
   %      2     2     1     2    // 32
   %      3     2     1     2    // 33
   %      1     3     1     2    // 34
   %      2     3     1     2    // 35
   %      3     3     1     2    // 36
   %      1     1     2     2    // 37
   %      2     1     2     2    // 38
   %      3     1     2     2    // 39
   %      1     2     2     2    // 40
   %      2     2     2     2    // 41
   %      3     2     2     2    // 42
   %      1     3     2     2    // 43
   %      2     3     2     2    // 44
   %      3     3     2     2    // 45
   %      1     1     3     2    // 46
   %      2     1     3     2    // 47
   %      3     1     3     2    // 48
   %      1     2     3     2    // 49
   %      2     2     3     2    // 50
   %      3     2     3     2    // 51
   %      1     3     3     2    // 52
   %      2     3     3     2    // 53
   %      3     3     3     2    // 54
   %      1     1     1     3    // 55
   %      2     1     1     3    // 56
   %      3     1     1     3    // 57
   %      1     2     1     3    // 58
   %      2     2     1     3    // 59
   %      3     2     1     3    // 60
   %      1     3     1     3    // 61
   %      2     3     1     3    // 62
   %      3     3     1     3    // 63
   %      1     1     2     3    // 64
   %      2     1     2     3    // 65
   %      3     1     2     3    // 66
   %      1     2     2     3    // 67
   %      2     2     2     3    // 68
   %      3     2     2     3    // 69
   %      1     3     2     3    // 70
   %      2     3     2     3    // 71
   %      3     3     2     3    // 72
   %      1     1     3     3    // 73
   %      2     1     3     3    // 74
   %      3     1     3     3    // 75
   %      1     2     3     3    // 76
   %      2     2     3     3    // 77
   %      3     2     3     3    // 78
   %      1     3     3     3    // 79
   %      2     3     3     3    // 80
   %      3     3     3     3    // 81
   %-----------------------------------------------------------------------
   Tensor_Voigt        =  zeros(6,6);
%    components          =  [1;37;73;28;10;55;19;64;46;41;77;32;14;59;23;68;...
%                            50;81;36;18;63;27;72;54;31;13;58;22;67;49;61;25;...
%                            70;52;71;53];  
   
   Tensor_Voigt(1,1)   =  Tensor(1);
   Tensor_Voigt(1,2)   =  Tensor(37);
   Tensor_Voigt(1,3)   =  Tensor(73);
   Tensor_Voigt(1,4)   =  0.5*(Tensor(28) + Tensor(10));
   Tensor_Voigt(1,5)   =  0.5*(Tensor(55) + Tensor(19));   
   Tensor_Voigt(1,6)   =  0.5*(Tensor(64) + Tensor(46));   

   Tensor_Voigt(2,1)   =  Tensor_Voigt(1,2);
   Tensor_Voigt(2,2)   =  Tensor(41);
   Tensor_Voigt(2,3)   =  Tensor(77);
   Tensor_Voigt(2,4)   =  0.5*(Tensor(32) + Tensor(14));
   Tensor_Voigt(2,5)   =  0.5*(Tensor(59) + Tensor(23));   
   Tensor_Voigt(2,6)   =  0.5*(Tensor(68) + Tensor(50));   
   
   Tensor_Voigt(3,1)   =  Tensor_Voigt(1,3);
   Tensor_Voigt(3,2)   =  Tensor_Voigt(2,3);
   Tensor_Voigt(3,3)   =  Tensor(81);
   Tensor_Voigt(3,4)   =  0.5*(Tensor(36) + Tensor(18));
   Tensor_Voigt(3,5)   =  0.5*(Tensor(63) + Tensor(27));   
   Tensor_Voigt(3,6)   =  0.5*(Tensor(72) + Tensor(54));   

   Tensor_Voigt(4,1)   =  Tensor_Voigt(1,4);
   Tensor_Voigt(4,2)   =  Tensor_Voigt(2,4);
   Tensor_Voigt(4,3)   =  Tensor_Voigt(3,4);
   Tensor_Voigt(4,4)   =  0.5*(Tensor(31) + Tensor(13));
   Tensor_Voigt(4,5)   =  0.5*(Tensor(58) + Tensor(22));   
   Tensor_Voigt(4,6)   =  0.5*(Tensor(67) + Tensor(49));   

   Tensor_Voigt(5,1)   =  Tensor_Voigt(1,5);
   Tensor_Voigt(5,2)   =  Tensor_Voigt(2,5);
   Tensor_Voigt(5,3)   =  Tensor_Voigt(3,5);
   Tensor_Voigt(5,4)   =  Tensor_Voigt(4,5);
   Tensor_Voigt(5,5)   =  0.5*(Tensor(61) + Tensor(25));   
   Tensor_Voigt(5,6)   =  0.5*(Tensor(70) + Tensor(52));   

   Tensor_Voigt(6,1)   =  Tensor_Voigt(1,6);
   Tensor_Voigt(6,2)   =  Tensor_Voigt(2,6);
   Tensor_Voigt(6,3)   =  Tensor_Voigt(3,6);
   Tensor_Voigt(6,4)   =  Tensor_Voigt(4,6);
   Tensor_Voigt(6,5)   =  Tensor_Voigt(5,6);   
   Tensor_Voigt(6,6)   =  0.5*(Tensor(71) + Tensor(53));   
            
%    Tensor_Voigt(1,1)   =  Tensor(1,1,1,1);
%    Tensor_Voigt(1,2)   =  Tensor(1,1,2,2);
%    Tensor_Voigt(1,3)   =  Tensor(1,1,3,3);
%    Tensor_Voigt(1,4)   =  0.5*(Tensor(1,1,1,2) + Tensor(1,1,2,1));
%    Tensor_Voigt(1,5)   =  0.5*(Tensor(1,1,1,3) + Tensor(1,1,3,1));   
%    Tensor_Voigt(1,6)   =  0.5*(Tensor(1,1,2,3) + Tensor(1,1,3,2));   
% 
%    Tensor_Voigt(2,1)   =  Tensor_Voigt(1,2);
%    Tensor_Voigt(2,2)   =  Tensor(2,2,2,2);
%    Tensor_Voigt(2,3)   =  Tensor(2,2,3,3);
%    Tensor_Voigt(2,4)   =  0.5*(Tensor(2,2,1,2) + Tensor(2,2,2,1));
%    Tensor_Voigt(2,5)   =  0.5*(Tensor(2,2,1,3) + Tensor(2,2,3,1));   
%    Tensor_Voigt(2,6)   =  0.5*(Tensor(2,2,2,3) + Tensor(2,2,3,2));   
%    
%    Tensor_Voigt(3,1)   =  Tensor_Voigt(1,3);
%    Tensor_Voigt(3,2)   =  Tensor_Voigt(2,3);
%    Tensor_Voigt(3,3)   =  Tensor(3,3,3,3);
%    Tensor_Voigt(3,4)   =  0.5*(Tensor(3,3,1,2) + Tensor(3,3,2,1));
%    Tensor_Voigt(3,5)   =  0.5*(Tensor(3,3,1,3) + Tensor(3,3,3,1));   
%    Tensor_Voigt(3,6)   =  0.5*(Tensor(3,3,2,3) + Tensor(3,3,3,2));   
% 
%    Tensor_Voigt(4,1)   =  Tensor_Voigt(1,4);
%    Tensor_Voigt(4,2)   =  Tensor_Voigt(2,4);
%    Tensor_Voigt(4,3)   =  Tensor_Voigt(3,4);
%    Tensor_Voigt(4,4)   =  0.5*(Tensor(1,2,1,2) + Tensor(1,2,2,1));
%    Tensor_Voigt(4,5)   =  0.5*(Tensor(1,2,1,3) + Tensor(1,2,3,1));   
%    Tensor_Voigt(4,6)   =  0.5*(Tensor(1,2,2,3) + Tensor(1,2,3,2));   
% 
%    Tensor_Voigt(5,1)   =  Tensor_Voigt(1,5);
%    Tensor_Voigt(5,2)   =  Tensor_Voigt(2,5);
%    Tensor_Voigt(5,3)   =  Tensor_Voigt(3,5);
%    Tensor_Voigt(5,4)   =  Tensor_Voigt(4,5);
%    Tensor_Voigt(5,5)   =  0.5*(Tensor(1,3,1,3) + Tensor(1,3,3,1));   
%    Tensor_Voigt(5,6)   =  0.5*(Tensor(1,3,2,3) + Tensor(1,3,3,2));   
% 
%    Tensor_Voigt(6,1)   =  Tensor_Voigt(1,6);
%    Tensor_Voigt(6,2)   =  Tensor_Voigt(2,6);
%    Tensor_Voigt(6,3)   =  Tensor_Voigt(3,6);
%    Tensor_Voigt(6,4)   =  Tensor_Voigt(4,6);
%    Tensor_Voigt(6,5)   =  Tensor_Voigt(5,6);   
%    Tensor_Voigt(6,6)   =  0.5*(Tensor(2,3,2,3) + Tensor(2,3,3,2));   
   
end
