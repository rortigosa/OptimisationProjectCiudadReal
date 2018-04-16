function  ElasticityReg          =  RegularisationElasticityMethodMatLab(dim,ngauss,Elasticity,ElasticityStable)

ElasticityReg   =  zeros(dim^2,dim^2,ngauss);
%--------------------------------------------------------------------------
% Fourth order identity matrix
%--------------------------------------------------------------------------
Imatrix    =  eye(dim^2);
%--------------------------------------------------------------------------
% Bisection for regularisation parameter alpha  
%--------------------------------------------------------------------------
%Scaling              =  max(max(abs(ElasticityStable(:,:,1))));
Scaling              =  max(max(abs(Elasticity(:,:,1))));
% Scaling_vector       =  zeros(dim,1);
% for idim=1:dim^2
%     Scaling_vector(idim)   =  Scaling^idim;
% end 

for igauss=1:ngauss
    %stability     =  SylvesterCriterionElasticityv2(dim,1,Elasticity(:,:,igauss),ElasticityStable(:,:,igauss));  
    %---------------------------------
    eigv          =  eig(Elasticity(:,:,igauss))/Scaling;
    stability     =  1;
    if min(eigv)<-1e-6
       stability  =  0;
    end
    %minors        =  MatLabMinors(dim^2,Elasticity(:,:,igauss));
    %Sminors       =  minors./Scaling_vector;     
    %stability     =  1;
    %if min(Sminors)<1e-6
    %   stability  =  0;
    %end
    %---------------------------------
    if stability
       ElasticityReg(:,:,igauss)  =  Elasticity(:,:,igauss);
    else    
       alpha_min  =  0;
       alpha_max  =  1.2*max(abs(reshape(Elasticity(:,:,igauss),[],1)));
       %-------------------------------------------------------------------
       % Determine upper bound
       %-------------------------------------------------------------------
       Elasticity_  =  Elasticity(:,:,igauss) + alpha_max*Imatrix;
       %stability    =  SylvesterCriterionElasticityv2(dim,1,Elasticity_,ElasticityStable(:,:,igauss));
       %---------------------------------
       %minors        =  MatLabMinors(dim^2,Elasticity_);
       %Sminors       =  minors./Scaling_vector;
       %stability     =  1;
       %if min(Sminors)<1e-6
       %    stability  =  0;
       %end
       eigv          =  eig(Elasticity_)/Scaling;
       stability     =  1;
       if min(eigv)<-1e-6
          stability  =  0;
       end
       %---------------------------------       
       if stability
           ElasticityReg(:,:,igauss) =  BisectionStability(Elasticity(:,:,igauss),Scaling,alpha_max);
       else
           while ~stability
               alpha_max    =  alpha_max*10;
               Elasticity_  =  Elasticity(:,:,igauss) + alpha_max*Imatrix;
               %stability    =  SylvesterCriterionElasticityv2(dim,1,Elasticity_,ElasticityStable(:,:,igauss));
               %---------------------------------
               %minors        =  MatLabMinors(dim^2,Elasticity_);
               %Sminors       =  minors./Scaling_vector;
               %stability     =  1;
               %if min(Sminors)<1e-6
               %    stability  =  0;
               %end
               eigv          =  eig(Elasticity_)/Scaling;
               stability     =  1;
               if min(eigv)<-1e-6
                   stability  =  0;
               end               
               %---------------------------------               
           end
           ElasticityReg(:,:,igauss) =  BisectionStability(Elasticity(:,:,igauss),Scaling,alpha_max);
       end
    end
end

%--------------------------------------------------------------------------
% Bisection algorithm
%--------------------------------------------------------------------------
function Elasticity_ = BisectionStability(Elasticity,Scaling,alpha_max)
 
  %NIter  =  10; 
  alpha_min  =  0; 
  nonconvergence  =  1;
  iter  =  1;
  while nonconvergence
  %for iter=1:NIter
      alpha    =  (alpha_min + alpha_max)/2;
      Elasticity_ = Elasticity + alpha*Imatrix;
      %stability    =  SylvesterCriterionElasticityv2(dim,1,Elasticity_,ElasticityStable);  
      %---------------------------------
      %minors        =  MatLabMinors(dim^2,Elasticity_);
      %Sminors       =  minors./Scaling_vector;
      %stability     =  1;
      %if min(Sminors)<1e-6
      %    stability  =  0;
      %end
      eigv          =  eig(Elasticity_)/Scaling;
      stability     =  1;
      if min(eigv)<-1e-6
         stability  =  0;
      end                     
      %---------------------------------       
      if stability
         alpha_max =  alpha; 
      else
         alpha_min = alpha;
         alpha     =  alpha_max;
         Elasticity_ = Elasticity + alpha*Imatrix;         
      end
      if abs(eigv)>1e-6 
         nonconvergence  =  1;
      else
         nonconvergence  =  0; 
      end
      iter  =  iter + 1;
  end
    
end

end