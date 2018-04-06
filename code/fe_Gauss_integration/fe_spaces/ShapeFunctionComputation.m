%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Shape functions for quads and hexas
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [N,DN_chi]                     =  ShapeFunctionComputation(shape,degree,dimension,quadrature)
 
%--------------------------------------------------------------------------
% Compute symbolic shape functions
%--------------------------------------------------------------------------
[symbN,symbDN_chi]                      =  SymbolicShapeFunctions(shape,degree,dimension);
symbDN_chi                              =  sym(symbDN_chi);
%--------------------------------------------------------------------------
% Compute shape functions at the Gauss points. 
%--------------------------------------------------------------------------
N                                       =  zeros(size(symbN,2),size(quadrature.Chi,1));
DN_chi                                  =  zeros(dimension,size(symbN,2),size(quadrature.Chi,1));
if degree==0
    for iloop = 1:size(quadrature.Chi,1)
        N(:,iloop)                      =  ones(size(symbN,1),size(symbN,2));
        DN_chi(:,1,iloop)               =  zeros(size(symbDN_chi,1),1,size(symbDN_chi,2));
    end
else
    for iloop = 1:size(quadrature.Chi,1)
        switch dimension
            case 1
                chi                     =  quadrature.Chi(iloop,1);
                N(:,iloop)              =  eval(symbN);
                DN_chi(:,:,iloop)       =  eval(symbDN_chi);
            case 2
                chi                     =  quadrature.Chi(iloop,1);
                eta                     =  quadrature.Chi(iloop,2);
                N(:,iloop)              =  eval(symbN);
                DN_chi(:,:,iloop)       =  eval(symbDN_chi); 
            case 3  
                chi                     =  quadrature.Chi(iloop,1);
                eta                     =  quadrature.Chi(iloop,2);
                iota                    =  quadrature.Chi(iloop,3);
                N(:,iloop)              =  eval(symbN);
                DN_chi(:,:,iloop)       =  eval(symbDN_chi);
        end
    end    
end    
    
    
    
    
