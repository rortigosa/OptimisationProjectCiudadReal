function  T  =  SparseComputationResiduals(res)

res_indexi   =  reshape(cell2mat({res(1:end).indexi}),[],1);
res_indexj   =  reshape(cell2mat({res(1:end).indexj}),[],1);
res_data     =  reshape(cell2mat({res(1:end).data}),[],1);
T            =  full(sparse(res_indexi,res_indexj,res_data));
