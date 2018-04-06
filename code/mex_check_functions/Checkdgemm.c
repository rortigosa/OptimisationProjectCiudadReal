#include "mex.h"
#include "cblas.h"

/* */

// /* The C function */
// void perfomer(mwSize dim,
//         mwSize n_gauss,
//         mwSize n_node_elem,
//         const double *BF,
//         const double *WFF,
//         const double *IntWeight,
//         double *K)
// {
//     mwSize capacity   =  dim*n_node_elem*dim*n_node_elem;
//     /*Initialise temperary variables*/
//     double *BFT       = (double*)malloc(sizeof(double)*(dim*n_node_elem*dim*dim));
//     double *BFTD      = (double*)malloc(sizeof(double)*(dim*n_node_elem*dim*dim));
//     double *BDB       = (double*)malloc(sizeof(double)*(capacity));
//     /*Initialise matrix K*/
//     mwSize j;
//     for (j=0; j<capacity; ++j){
//         K[j]          = 0.;
//     }    
//     /*Compute K matrix*/    
//     mwSize i;
//     // Loop over gauss points
//     for (i=0; i<n_gauss; ++i) {
//         transpose(&BF[dim*n_node_elem*dim*dim*i],BFT,dim*n_node_elem,dim*dim);
//         matmul(dim*n_node_elem,dim*dim,dim*dim,BFT,&WFF[dim*dim*dim*dim*i],BFTD);
//         matmul(dim*n_node_elem,dim*dim,dim*n_node_elem,BFTD,&BF[dim*n_node_elem*dim*dim*i],BDB);
//         for (j=0; j<capacity; ++j){
//             K[j]      += BDB[j]*IntWeight[i];
//         }
//     }
//     /*Compulsary free of temporaries*/     
//     free(BFT);
//     free(BFTD);
//     free(BDB);
// }

/* The gateway function */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    size_t M, K, N;
    double *A;
    double *B;

    /* outputs */
    double *out;                    /* output matrix */

    /* create a pointer to the real data in the input matrix  */
    A        = mxGetPr(prhs[0]);
    B        = mxGetPr(prhs[1]);
    M =  mxGetM(prhs[0]);
    K =  mxGetN(prhs[0]);
    N =  mxGetN(prhs[1]);

    /* create the output matrix */
    plhs[0] = mxCreateDoubleMatrix((mwSize)M,(mwSize)N,mxREAL);

    /* get a pointer to the real data in the output matrix */
    out = mxGetPr(plhs[0]);

    /* call the computational routine */
//     dgemm_caller((mwSize)M,(mwSize)K,(mwSize)N,A,B,out);
    
    
//     dgemm_cblas(CblasColumnMajor,CblasNoTrans,CblasNoTrans,M,N,K,1.0,A,M,B,K,0.0,out,M);
    dgemm_cblas(CblasNoTrans,CblasNoTrans,M,N,K,1.0,A,M,B,K,0.0,out,M);
}

