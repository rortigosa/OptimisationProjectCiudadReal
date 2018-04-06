
function matrix              =  Vector2MatrixVectorisation(vector,n_gauss,indices)

dim                          =  size(vector,1);
matrix                       =  zeros(dim,dim^2,n_gauss);
matrix(indices.LHS_indices)  =  vector(indices.RHS_indices);
