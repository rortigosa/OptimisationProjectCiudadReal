function [N,DN_chi]           =  SymbolicShapeFunctionsTrisTets(degree,dimension)
 
syms chi  eta  iota
%--------------------------------------------------------------------------
% Number of nodes per element in the current mesh.
%--------------------------------------------------------------------------
switch dimension
    case 3
        N_nod_elem            =  0;
        for inode=1:degree+1
            N_nod_elem        =  N_nod_elem + sum(1:inode);
        end
    case 2
        N_nod_elem            =  sum(1:degree);
end
%--------------------------------------------------------------------------
% Creation of nodes and coordinates
%--------------------------------------------------------------------------
xpos                          =   zeros(degree+1,1);
ypos                          =   zeros(degree+1,1);
switch dimension
    case 3
        zpos                  =  zeros(degree+1,1);
end
%--------------------------------------------------------------------------
% Triangular and tetrahedral elements.
%--------------------------------------------------------------------------
t1pos                         =  zeros(1,length(xpos));
for i=1:length(xpos)
    switch degree
        case 0
            xpos(i)           =  1/3;
            ypos(i)           =  1/3;
            t1pos(i)          =  1/3;                  % It is not z coordinate.
        otherwise
            xpos(i)           =  0 + 1/degree*(i-1);
            ypos(i)           =  0 + 1/degree*(i-1);
            t1pos(i)          =  0 + 1/degree*(i-1);   % It is not z coordinate.
    end
    switch dimension
        case 3
            switch degree
                case 0
                    zpos(i)   =  1/3;
                otherwise
                    zpos(i)   =  0 + 1/degree*(i-1);
            end
    end
end
nonordered_x                  =  zeros(N_nod_elem,dimension);
t                             =  0;
acu                           =  0;
switch dimension
    case 2
        %------------------------------------------------------------------
        % Triangular elements.
        %------------------------------------------------------------------
        for j=1:degree + 1
            for i=1:degree + 1 - t
                nonordered_x(i ...
                    + acu,:)  =  [xpos(i) ypos(j)];
            end
            t                 =  t + 1;
            acu               =  acu  +  degree + 2  - t;
        end
    case 3
        %------------------------------------------------------------------
        % Tetrahedral elements.
        %------------------------------------------------------------------
        tz                    =  0;
        for k=1:degree+1
            for j=1:degree+1-tz
                for i=1:degree+1-t-tz
                    nonordered_x(i ...
                    +acu,:)   =  [xpos(i) ypos(j) zpos(k)];
                end
                t             =  t + 1;
                acu           =  acu  +  degree + 2  - t - tz;
            end
            t                 =  0;
            tz                =  tz + 1;
        end
end
%--------------------------------------------------------------------------
% Creation of shape functions.
%--------------------------------------------------------------------------
syms aux
switch dimension
    case 2
        %------------------------------------------------------------------
        % Triangles (2D).
        %------------------------------------------------------------------
        N                     =  aux*ones(1,size(nonordered_x,1));
        for inode = 1:size(nonordered_x,1)
            node              =  nonordered_x(inode,:);
            node              =  [node(1) node(2) (1-node(1)-node(2))];
            for ichi=1:degree+1
                if node(1)-xpos(ichi)>1e-4
                    N(inode)  =  N(inode)*(chi - xpos(ichi))/(node(1) - xpos(ichi));
                end
            end
            for ieta=1:degree+1
                if node(2)-ypos(ieta)>1e-4
                    N(inode)  =  N(inode)*(eta - ypos(ieta))/(node(2) - ypos(ieta));
                end
            end
            for it1=1:degree+1
                if node(3)-t1pos(it1)>1e-4
                    N(inode)  =  N(inode)*(1-chi-eta - t1pos(it1))/(node(3) - t1pos(it1));
                end
            end
        end
    case 3
        %------------------------------------------------------------------
        % Tetrahedral elements (3D).
        %------------------------------------------------------------------
        N                     =  aux*ones(1,size(nonordered_x,1));        
        for inode = 1:size(nonordered_x,1)
            node              =  nonordered_x(inode,:);
            node              =  [node(1) node(2) node(3) (1-node(1)-node(2)-node(3))];
            for ichi=1:degree+1
                if node(1)-xpos(ichi)>1e-4
                    N(inode)  =  N(inode)*(chi - xpos(ichi))/(node(1) - xpos(ichi));
                end
            end
            for ieta=1:degree+1
                if node(2)-ypos(ieta)>1e-4
                    N(inode)  =  N(inode)*(eta - ypos(ieta))/(node(2) - ypos(ieta));
                end
            end
            for iiota=1:degree+1
                if node(3)-zpos(iiota)>1e-4
                    N(inode)  =  N(inode)*(iota - zpos(iiota))/(node(3) - zpos(iiota));
                end
            end
            for it1=1:degree+1
                if node(4)-t1pos(it1)>1e-4
                    N(inode)  =  N(inode)*(1-chi-eta-iota - t1pos(it1))/(node(4) - t1pos(it1));
                end
            end
        end
end
%--------------------------------------------------------------------------
% Derivatives of shape functions. 
%--------------------------------------------------------------------------
syms    chi eta iota
switch dimension
    case 2
        DN_chi                =  [diff(N,chi) ; diff(N,eta)];
    case 3
        DN_chi                =  [diff(N,chi) ; diff(N,eta) ; diff(N,iota)];
end 
aux                           =  1;
N                             =  eval(N);
DN_chi                        =  eval(DN_chi);
