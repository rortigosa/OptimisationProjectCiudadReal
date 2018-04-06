%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Symbolic tensorisation of shape functions for quads and hexas
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [N,DN_chi]            =  SymbolicTensorisationShapeFunctions(degree,dimension,iso_coordinates,oneD_isocoordinates)                     

syms aux chi eta iota
N_nod_elem                     =  (degree+1)^(dimension);
N                              =  aux*ones(1,N_nod_elem);
for inode = 1:size(iso_coordinates,1)
    node                       =  iso_coordinates(inode,:);
    %----------------------------------------------------------------------
    % 1D shape functions
    %----------------------------------------------------------------------
    for chidim=1:degree+1
        if abs(node(1)-oneD_isocoordinates(chidim))>1e-4
            N(inode)           =  N(inode)*(chi - oneD_isocoordinates(chidim))/(node(1) - oneD_isocoordinates(chidim));
        end
    end
    DN_chi                     =  diff(N,chi);
    switch dimension
        %------------------------------------------------------------------
        % Tensorisation for the 2D case
        %------------------------------------------------------------------
        case 2
            for etadim=1:degree+1
                if abs(node(2)-oneD_isocoordinates(etadim))>1e-4
                    N(inode)   =  N(inode)*(eta - oneD_isocoordinates(etadim))/(node(2) - oneD_isocoordinates(etadim));
                end
            end
            DN_chi             =  [diff(N,chi) ; diff(N,eta)];
        %------------------------------------------------------------------
        % Tensorisation for the 3D case
        %------------------------------------------------------------------
        case 3
            for etadim=1:degree+1
                if abs(node(2)-oneD_isocoordinates(etadim))>1e-4
                    N(inode)   =  N(inode)*(eta - oneD_isocoordinates(etadim))/(node(2) - oneD_isocoordinates(etadim));
                end
            end
            for iotadim=1:degree+1
                if abs(node(3)-oneD_isocoordinates(iotadim))>1e-4
                    N(inode)   =  N(inode)*(iota - oneD_isocoordinates(iotadim))/(node(3) - oneD_isocoordinates(iotadim));
                end
            end
            DN_chi             =  [diff(N,chi);  diff(N,eta);  diff(N,iota)];
    end
end

aux                            =  1;
N                              =  eval(N);
DN_chi                         =  eval(DN_chi);


