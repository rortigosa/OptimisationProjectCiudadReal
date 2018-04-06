%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%
%  This function computes the trace of a squared matrix stored at different
%  Gauss points. In reality, the matrix is a third order tensor where the
%  third dimension accounts for the Gauss points.
%
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

function trace_result     =  TraceGauss(Matrix,ngauss)

trace_result              =  zeros(ngauss,1);

for igauss=1:ngauss
    trace_result(igauss)  =  trace(Matrix(:,:,igauss));    
end