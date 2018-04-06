function K    =  SparseComputationMatrices(stiff,total_dofs)

stiff_indexi  =  reshape(cell2mat({stiff(1:end).indexi}),[],1);
stiff_indexj  =  reshape(cell2mat({stiff(1:end).indexj}),[],1);
stiff_data    =  reshape(cell2mat({stiff(1:end).data}),[],1);
K             =  sparse(stiff_indexi(:),stiff_indexj(:),stiff_data(:),total_dofs,total_dofs);
