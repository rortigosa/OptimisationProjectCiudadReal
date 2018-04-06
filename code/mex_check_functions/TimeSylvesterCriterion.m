
N   =  1e4;

%--------------------------------------------------------------------------
% Sylvester MatLab
%--------------------------------------------------------------------------
tic
for i=1:N
det4_  =  zeros(ngauss,1);
det3_  =  zeros(ngauss,1);
det2_  =  zeros(ngauss,1);
det1_  =  zeros(ngauss,1);
cr_eig =  zeros(ngauss,1);
for igauss=1:4
    det4_(igauss)  =  det(Elasticity(:,:,igauss));  
    det3_(igauss)  =  det(Elasticity(1:3,1:3,igauss));  
    det2_(igauss)  =  det(Elasticity(1:2,1:2,igauss));  
    det1_(igauss)  =  det(Elasticity(1,1,igauss));      
    cr             =  min(det4_(igauss),det3_(igauss));
    cr             =  min(cr,det2_(igauss));
    cr             =  min(cr,det1_(igauss));
    cr_eig(igauss) =  cr;
end
end
toc

%--------------------------------------------------------------------------
% Sylvester C
%--------------------------------------------------------------------------
tic 
for i=1:N
    [stb,minimum_gauss,minimum]=SylvesterCriterionElasticity24(dim,ngauss,Elasticity); 
end
toc  

%--------------------------------------------------------------------------
% Eigenvalues MatLab
%--------------------------------------------------------------------------
tic
for i=1:N
eig_  =  zeros(ngauss,1);
for igauss=1:4
    eig_(igauss)   =  min(eig(Elasticity(:,:,igauss)));
end
end
toc



asdf=98