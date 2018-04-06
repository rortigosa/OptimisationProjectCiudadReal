
Geometry.dim  =  2;
ngauss        =  4;
Elasticity0   =  rand(Geometry.dim^2,Geometry.dim^2,ngauss);
Elasticity0(1,1,1)  =  -1;
  
 
ElasticityMatLab  =  RegularisationElasticityMethod1(Geometry.dim,ngauss,Elasticity0);    
ElasticityC      =  RegularisationElasticity1MexC28(Geometry.dim^2,ngauss,Elasticity0);    

igauss  =  2;
Matrix  =  Elasticity0(:,:,igauss);
minorsC  =  CheckMinors(Geometry.dim^2,Matrix);
minors   =  zeros(Geometry.dim^2,1);
minors(1) = det(Matrix(1,1));
minors(2) = det(Matrix(1:2,1:2));
minors(3) = det(Matrix(1:3,1:3));
minors(4) = det(Matrix(1:4,1:4));

