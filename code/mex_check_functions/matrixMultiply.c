/*=========================================================
 * matrixMultiply.c - Example for illustrating how to use 
 * BLAS within a C MEX-file. matrixMultiply calls the 
 * BLAS function dgemm.
 *
 * C = matrixMultiply(A,B) computes the product of A*B,
 *     where A, B, and C are matrices.
 *
 * This is a MEX-file for MATLAB.
 * Copyright 2009-2010 The MathWorks, Inc.
 *=======================================================*/

#if !defined(_WIN32)
#define dgemm dgemm_
#endif

#include "mex.h"
#include "blas.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    double *A, *B, *C; /* pointers to input & output matrices*/
    size_t m,n,k;      /* matrix dimensions */
    /* form of op(A) & op(B) to use in matrix multiplication */
    char *chn = "N";
    char *cht = "T";
    /* scalar values to use in dgemm */
    double one = 1.0, zero = 0.0;

    A = mxGetPr(prhs[0]); /* first input matrix */
    B = mxGetPr(prhs[1]); /* second input matrix */
    /* dimensions of input matrices */
    m = mxGetM(prhs[0]);  
    k = mxGetN(prhs[0]);
    n = mxGetN(prhs[1]);

    /* create output matrix C */
    plhs[0] = mxCreateDoubleMatrix(k, n, mxREAL);
    C = mxGetPr(plhs[0]);

    /* Pass arguments to Fortran by reference */
//     dgemm(chn, chn, &m, &n, &k, &one, A, &m, B, &k, &zero, C, &m);
//     dgemm(cht, chn, &p, &n, &m, &one, A, &p, B, &m, &zero, C, &p);  
//     dgemm(cht, chn, &k, &n, &m, &one, A, &k, B, &k, &zero, C, &m);  
    dgemm(cht, chn, &k, &n, &m, &one, A, &m, B, &m, &zero, C, &k);
}
