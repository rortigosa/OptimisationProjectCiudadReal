%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function computes the eigenvalues of the consistent elasticity
%  tensor and then takes those which are negative in order to penalise
%  them as:
%  penalty  =  int_V(rho*sum_i lambda_i^2),
%
%  with rho the density of the material and lambda_i the negative
%  eigenvalues at a Gauss point.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function  [penalty_term,Dpenalty_term]    =  EigenvaluePenaltyBasedTerm(rho,Drho,ConsistenElasticity,IntWeight)

penalty_term      =  0;
Dpenalty_term     =  0;
for igauss=1:size(ConsistenElasticity,3)
    eigenvalues   =  diag(eig(ConsistenElasticity(:,:,igauss)));
    eigenvalues   =  eigenvalues(eigenvalues<0);

    penalty_term  =  penalty_term  + rho*sum(abs(eigenvalues))*IntWeight(igauss);
    Dpenalty_term =  Dpenalty_term + Drho*sum(abs(eigenvalues))*IntWeight(igauss);

    
end

