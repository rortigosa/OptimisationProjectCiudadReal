function  ElasticityReg          =  RegularisationElasticityMethod1(dim,ngauss,Elasticity)

ElasticityReg   =  zeros(dim^2,dim^2,ngauss);
%--------------------------------------------------------------------------
% Fourth order identity matrix
%--------------------------------------------------------------------------
Imatrix    =  eye(dim^2);
%--------------------------------------------------------------------------
% Bisection for regularisation parameter alpha  
%--------------------------------------------------------------------------
for igauss=1:ngauss
    stability     =  SylvesterCriterionElasticity(dim,1,Elasticity(:,:,igauss));  
    if stability
       ElasticityReg(:,:,igauss)  =  Elasticity(:,:,igauss);
    else    
       alpha_min  =  0;
       alpha_max  =  1.2*max(abs(reshape(Elasticity(:,:,igauss),[],1)));
       %-------------------------------------------------------------------
       % Determine upper bound
       %-------------------------------------------------------------------
       Elasticity_  =  Elasticity(:,:,igauss) + alpha_max*Imatrix;
       stability    =  SylvesterCriterionElasticity(dim,1,Elasticity_);
       if stability
           ElasticityReg(:,:,igauss) =  BisectionStability(Elasticity(:,:,igauss),alpha_max);
       else
           while ~stability
               alpha_max    =  alpha_max*10;
               Elasticity_  =  Elasticity(:,:,igauss) + alpha_max*Imatrix;
               stability    =  SylvesterCriterionElasticity(dim,1,Elasticity_);
           end
           ElasticityReg(:,:,igauss) =  BisectionStability(Elasticity(:,:,igauss),alpha_max);
       end
    end
end

%--------------------------------------------------------------------------
% Bisection algorithm
%--------------------------------------------------------------------------
function Elasticity_ = BisectionStability(Elasticity,alpha_max)
 
  NIter  =  6; 
  alpha_min  =  0; 
  for iter=1:NIter
      alpha    =  (alpha_min + alpha_max)/2;
      Elasticity_ = Elasticity + alpha*Imatrix;
      stability    =  SylvesterCriterionElasticity(dim,1,Elasticity_);  
      if stability
         alpha_max =  alpha; 
      else
         alpha_min = alpha;
         alpha     =  alpha_max;
         Elasticity_ = Elasticity + alpha*Imatrix;         
      end
%      penalty  =  max((1 - alpha/max(abs(reshape(Elasticity,[],1))))^1,0.01);
      penalty  =  1;
      Elasticity_  =  penalty*Elasticity_;
%       if iter==6
%           if penalty<0.5
%              a=2;              
%           end
%       end
  end
    
end

end