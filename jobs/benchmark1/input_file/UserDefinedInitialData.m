
function [data,TimeIntegrator]          =  UserDefinedInitialData

data.formulation       =  'u';
%str.data.formulation  =  'up';
%data.language         =  'MatLab';
data.language          =  'CMex';


TimeIntegrator.type          =  'Static';
%TimeIntegrator.type          =  'ExplicitNewmarkBeta';
%TimeIntegrator.type           =  'CentralDifference';
