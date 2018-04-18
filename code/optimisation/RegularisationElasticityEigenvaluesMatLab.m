function  ElasticityReg          =  RegularisationElasticityEigenvaluesMatLab(ngauss,Elasticity)

ElasticityReg   =  Elasticity;


for igauss=1:ngauss
    %stability     =  SylvesterCriterionElasticityv2(dim,1,Elasticity(:,:,igauss),ElasticityStable(:,:,igauss));  
    %---------------------------------
    [eigvector,eigvalue]          =  eig(Elasticity(:,:,igauss));
    Neg           =  find(eigvalue<0);
    for ineg=1:length(Neg)
        id   =  Neg(ineg);
        ElasticityReg(:,:,igauss)  =  ElasticityReg(:,:,igauss) -  eigvalue(id,id)*(1 + 1e-2)*(eigvector(:,id)*eigvector(:,id)');
    end
    
end