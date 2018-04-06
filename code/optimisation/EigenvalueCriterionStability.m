function  stability     =  EigenvalueCriterionStability(ngauss,Elasticity_total)

stability            =  1;
tol                  =  0;
for igauss=1:ngauss
    [V,D]            =  eig(Elasticity_total(:,:,igauss));
    lambda           =  sort(diag(D));
    lambda_pos       =  lambda(lambda>=0);
    lambda_pos_max   =  max(lambda_pos);
    lambda_neg       =  lambda(lambda<0);

    if isempty(lambda_pos)
       lambda_final  =  lambda_neg/lambda_pos_max;    
       lambda_final  =  lambda_final(lambda_final<-tol);
    else
       lambda_pos    =  lambda_pos/lambda_pos_max;
       lambda_neg    =  lambda_neg/lambda_pos_max;    
       lambda_final  =  [lambda_pos;lambda_neg];
       lambda_final  =  lambda_final(abs(lambda_final)>tol);
    end
    if min(lambda_final)<-tol
       stability     =  0;
    end
end 
    

