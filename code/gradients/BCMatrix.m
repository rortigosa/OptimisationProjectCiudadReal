%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  B matrices in the F formulation
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function BC                     =  BCMatrix(ngauss,dim,n_node_elem,F,DNX,vect)

BC                              =  zeros(dim^2,dim*n_node_elem,ngauss);
Fmatrix1                        =  zeros(dim^2,dim^2);
Fmatrix2                        =  zeros(dim^2,dim^2);
DNMatrix                        =  zeros(dim^2,dim*n_node_elem);
for igauss=1:ngauss      
    FGauss                      =  F(:,:,igauss);
    DNXGauss                    =  DNX(:,:,igauss);
    Fmatrix1(vect.LHS_matrix1)  =  FGauss(vect.RHS_matrix1);
    Fmatrix2(vect.LHS_matrix2)  =  FGauss(vect.RHS_matrix2);
    DNMatrix(vect.LHS_DNX)      =  DNXGauss(vect.RHS_DNX);    
    BC(:,:,igauss)              =  (Fmatrix1 + Fmatrix2)*DNMatrix;
end

