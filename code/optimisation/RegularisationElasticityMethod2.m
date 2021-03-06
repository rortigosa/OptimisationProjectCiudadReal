function  ElasticityReg    =  RegularisationElasticityMethod2(dim,ngauss,Elasticity,ElasticityStable)

ElasticityReg              =  zeros(dim^2,dim^2,ngauss);
%--------------------------------------------------------------------------
% Bisection for regularisation parameter alpha   
%--------------------------------------------------------------------------
for igauss=1:ngauss
    ElasticityVoigt        =  TensorVoight4(Elasticity(:,:,igauss),dim);  
    ElasticityStableVoigt  =  TensorVoight4(ElasticityStable(:,:,igauss),dim);  
    stability              =  SylvesterCriterionElasticitySymmetrised7(dim*2 - (3-dim),1,ElasticityVoigt);  
    if stability
       ElasticityReg(:,:,igauss)  =  Elasticity(:,:,igauss);
    else    
       alpha_min  =  0;
       alpha_max  =  0.1;
       %-------------------------------------------------------------------
       % Determine upper bound
       %-------------------------------------------------------------------
       ElasticityVoigt_    =  ElasticityVoigt + alpha_max*ElasticityStableVoigt;
       stability           =  SylvesterCriterionElasticitySymmetrised7(dim*2 - (3-dim),1,ElasticityVoigt_);
       if stability
           [~,alpha]       =  BisectionStability(Elasticity(:,:,igauss),ElasticityStable(:,:,igauss),alpha_max);
       else
           while ~stability 
               alpha_max         =  alpha_max*10;
               ElasticityVoigt_  =  ElasticityVoigt + alpha_max*ElasticityStableVoigt;
               stability         =  SylvesterCriterionElasticitySymmetrised7(dim*2 - (3-dim),1,ElasticityVoigt_);
           end
           [~,alpha]             =  BisectionStability(ElasticityVoigt,ElasticityStableVoigt,alpha_max);
       end
       ElasticityReg(:,:,igauss) =  Elasticity(:,:,igauss) + alpha*ElasticityStable(:,:,igauss);
    end
end

%--------------------------------------------------------------------------
% Bisection algorithm
%--------------------------------------------------------------------------
function [Elasticity_,alpha] = BisectionStability(Elasticity,ElasticityStable,alpha_max)
 
  NIter      =  10; 
  alpha_min  =  0; 
  alpha__    =  zeros(NIter,1);
  for iter=1:NIter 
      alpha          =  (alpha_min + alpha_max)/2;
      Elasticity_    =  Elasticity + alpha*ElasticityStable;
      stability      =  SylvesterCriterionElasticitySymmetrised7(dim*2 - (3-dim),1,Elasticity_);  
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