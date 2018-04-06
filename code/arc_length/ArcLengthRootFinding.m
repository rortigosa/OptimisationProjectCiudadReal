function NR                             =  ArcLengthRootFinding(NR,AL,uR,uF,bc,solution)

initial_root_criterion                  =  'Feng';        
%initial_root_criterion                 =  'Crisfield';        
%initial_root_criterion                 =  'mine';

radius                                  =  AL.radius;


% uFtot(bc.Dirichlet.freedof)             =  K\F0(bc.Dirichlet.freedof);
% uRtot(bc.Dirichlet.freedof)             =  K\R(bc.Dirichlet.freedof);
Duk                                     =  solution.x.Dxk(bc.Neumann.fixdof);
Dun                                     =  solution.x.Dxn(bc.Neumann.fixdof);
%Duk                                    =  solution.incremental_solution;

%A                                      =  b'*b + T;
A                                       =  uF'*uF;
%B                                      =  2*a'*b + 2*solution.Du'*b + 2*solution.Dw0*(T);
B                                       =  2*(Duk'*uF - uF'*uR);
%C                                      =  a'*a + 2*a'*solution.Du + solution.Du'*solution.Du + (T)*solution.Dw0^2 - radius^2;
C                                       =  Duk'*Duk - 2*Duk'*uR + uR'*uR - radius^2;

                                       a3 = dxdx + 2*uRdx + uRuR - CON.ARCLEN.arcln*CON.ARCLEN.arcln;


DlambdaDu1                              =  real(-B  -  sqrt(B^2 - 4*A*C))/(2*A);
DlambdaDu2                              =  real(-B  +  sqrt(B^2 - 4*A*C))/(2*A); 
switch NR.iteration
    case 0
         %-----------------------------------------------------------------
         % Predictor according to criterion by Feng
         %-----------------------------------------------------------------
         switch initial_root_criterion         
             case {'Feng'}         
                  if norm(Dun)>0
                     %DlambdaDu         =  sign(solution.Du_old'*uF)*radius/sqrt(uF'*uF);
                     DlambdaDu          =  sign(Dun'*uF)*radius/sqrt(uF'*uF);
                  else
                     DlambdaDu          =  radius/sqrt(uF'*uF); 
%                      DlambdaDu1         =  radius/sqrt(uF'*uF);
%                      DlambdaDu2         =  -radius/sqrt(uF'*uF);        
%                      Du1                =  -uR + DlambdaDu1*uF;
%                      Du2                =  -uR + DlambdaDu2*uF;
%                      [maximum,...
%                          identifier]    =  max([Du1 Du2]);
%                      switch identifier
%                          case 1
%                              DlambdaDu  =  DlambdaDu1;
%                          case 2
%                              DlambdaDu  =  DlambdaDu2;
%                      end                            
                  end
             %-------------------------------------------------------------
             % Predictor according to criterion by Crisfield
             %-------------------------------------------------------------
             case 'Crisfield'
                  DlambdaDu1            =  radius/sqrt(uF'*uF);
                  DlambdaDu2            =  -radius/sqrt(uF'*uF);
                  %Res1                  =  R  - DlambdaDu1*F0;
                  %Res2                  =  R  - DlambdaDu2*F0;
                  Res1                  =  R(bc.Neumann.fixdof)  - DlambdaDu1*F0(bc.Neumann.fixdof);
                  Res2                  =  R(bc.Neumann.fixdof)  - DlambdaDu2*F0(bc.Neumann.fixdof);
                  [maximum,identifier]  =  min([norm(Res1) norm(Res2)]);
                  switch identifier
                         case 1
                             DlambdaDu  =  DlambdaDu1;
                         case 2
                             DlambdaDu  =  DlambdaDu2;
                  end                            
         end              
    otherwise 
        Du1                             =  -uR +  DlambdaDu1*uF;  
        Du2                             =  -uR +  DlambdaDu2*uF;
        cos_theta1                      =  (Duk'*(Duk + Du1))/radius^2;
        cos_theta2                      =  (Duk'*(Duk + Du2))/radius^2;
%         theta1                          =  abs(acos(cos_theta1));
%         theta2                          =  abs(acos(cos_theta2));
        [min_theta,...
            root_id]                    =  max([cos_theta1 cos_theta2]);
%         [min_theta,...
%             root_id]                    =  min([theta1 theta2]);
        switch root_id 
            case 1
                 DlambdaDu              =  DlambdaDu1;
            case 2
                 DlambdaDu              =  DlambdaDu2; 
        end    
end     
%--------------------------------------------------------------------------
%  Update acumulated factor   
%--------------------------------------------------------------------------
NR.accumulated_factor                   =  NR.accumulated_factor + DlambdaDu;


