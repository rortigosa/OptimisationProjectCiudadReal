function Vector  =  Matrix2Vector(dim2,ngauss,Matrix)

Vector           =  reshape(permute(Matrix,[2,1,3]),dim2,ngauss);