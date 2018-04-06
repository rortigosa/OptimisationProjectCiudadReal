function  stability     =  StiffnessCriterionStability(Kxx)

tol              =  1e-3; % It works for 1e-2 but gives very irregular boundaries
                          % It does not work beyond 1e-1
stability        =  1;
[V,D]            =  eig(Kxx);
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
    lambda_final  =  sort(lambda_final(abs(lambda_final)>tol));
end 
if min(lambda_final)<-tol
    stability     =  0;
end
    

