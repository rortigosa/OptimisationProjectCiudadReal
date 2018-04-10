function  ElasticityReg    =  RegularisationElasticityMethod3(dim,ngauss,Elasticity,ElasticityStable)

ElasticityReg              =  zeros(dim^2,dim^2,ngauss);
%--------------------------------------------------------------------------
% Bisection for regularisation parameter alpha   
%--------------------------------------------------------------------------
for igauss=1:ngauss
    stability              =  SylvesterCriterionElasticity36(dim,1,Elasticity(:,:,igauss),ElasticityStable(:,:,igauss));  
    if stability
       ElasticityReg(:,:,igauss)  =  Elasticity(:,:,igauss);
    else     
       alpha_min  =  0;
       alpha_max  =  0.1; 
       %-------------------------------------------------------------------
       % Determine upper bound
       %-------------------------------------------------------------------
       Elasticity_         =  Elasticity(:,:,igauss) + alpha_max*ElasticityStable(:,:,igauss);
       stability           =  SylvesterCriterionElasticity36(dim,1,Elasticity_,ElasticityStable(:,:,igauss));
       if stability
          ElasticityReg(:,:,igauss)  =  BisectionStability(Elasticity(:,:,igauss),ElasticityStable(:,:,igauss),alpha_max);
       else
           while ~stability 
               alpha_max    =  alpha_max*10;
               Elasticity_  =  Elasticity(:,:,igauss) + alpha_max*ElasticityStable(:,:,igauss);
               stability    =  SylvesterCriterionElasticity36(dim,1,Elasticity_,ElasticityStable(:,:,igauss));
           end
           ElasticityReg(:,:,igauss)  =  BisectionStability(Elasticity(:,:,igauss),ElasticityStable(:,:,igauss),alpha_max);
       end
    end
end

%--------------------------------------------------------------------------
% Bisection algorithm
%--------------------------------------------------------------------------
function Elasticity_ = BisectionStability(Elasticity,ElasticityStable,alpha_max) 
  NIter      =  6; 
  alpha_min  =  0; 
  alpha__    =  zeros(NIter,1);
  for iter=1:NIter 
      alpha          =  (alpha_min + alpha_max)/2;
      Elasticity_    =  Elasticity + alpha*ElasticityStable;
      stability      =  SylvesterCriterionElasticity36(dim,1,Elasticity_,ElasticityStable);  
      if stability
         alpha_max   =  alpha; 
      else 
         alpha_min   = alpha;
         alpha       =  alpha_max;
         Elasticity_ = Elasticity + alpha*ElasticityStable;         
      end
      alpha__(iter)  =  alpha;
  end
    
end

end