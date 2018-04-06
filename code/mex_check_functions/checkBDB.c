#if !defined(_WIN32)
#define dgemm dgemm_
#endif

#include "mex.h"
#include "matfunctions.h"
#include "blas.h"

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void perfomer(mwSize dim,
        mwSize n_gauss,
        mwSize n_node_elem,
        const double *BF,
        const double *WFF,
        const double *IntWeight,
        double *K)
{
    mwSize capacityBF    =  dim*n_node_elem*dim*dim;
    mwSize capacity      =  dim*n_node_elem*dim*n_node_elem;
    /*-------------------------------------------------------------------*/
    /*Initialise temperary variables*/
    /*-------------------------------------------------------------------*/
    double *BFT          = (double*)malloc(sizeof(double)*(capacityBF));

    double *BFT_WFF      = (double*)malloc(sizeof(double)*(capacityBF));
    
    double *BFT_WFF_BF   = (double*)malloc(sizeof(double)*(capacity));
    /*-------------------------------------------------------------------*/
    /*Initialise matrix K*/
    /*-------------------------------------------------------------------*/
    mwSize j;
    for (j=0; j<capacity; ++j){
        K[j]          = 0.;
    }    
    /*-------------------------------------------------------------------*/
    /*Compute K matrix*/    
    /*-------------------------------------------------------------------*/
    char *chn = "N";
    char *cht = "T";
    size_t m1  = dim*dim;         /*number of rows of A*/
    size_t n1  = dim*dim;         /*number of columns of B*/
    size_t k1  = dim*n_node_elem; /*number of columns of A*/

    size_t m2  = dim*n_node_elem; /*number of rows of A*/
    size_t n2  = dim*n_node_elem; /*number of columns of B*/
    size_t k2  = dim*dim;         /*number of columns of A*/ 
    /*-------------------------------------------------------------------*/    
    /* scalar values to use in dgemm */
    /*-------------------------------------------------------------------*/
    double one = 1.0, zero = 0.0;
    /*-------------------------------------------------------------------*/
    /* Loop over gauss points                                            */
    /*-------------------------------------------------------------------*/
    mwSize i;
    for (i=0; i<n_gauss; ++i) {
        /*  FF term  */
        dgemm(cht, chn, &k1, &n1, &m1, &one, &BF[dim*n_node_elem*dim*dim*i], &m1, &WFF[dim*dim*dim*dim*i], &m1, &zero, BFT_WFF, &k1);        
        dgemm(chn, chn, &m2, &n2, &k2, &one, BFT_WFF, &m2, &BF[dim*n_node_elem*dim*dim*i], &k2, &zero, BFT_WFF_BF, &m2);                
        for (j=0; j<capacity; ++j){
            K[j]      +=  BFT_WFF_BF[j]*IntWeight[i];
        }
    }
    /*-------------------------------------------------------------------*/
    /*Free temporaries*/     
    /*-------------------------------------------------------------------*/
    free(BFT);
    
    free(BFT_WFF);
    
    free(BFT_WFF_BF);
}

/*-----------------------------------------------------------------------*/
/* The gateway function */
/*-----------------------------------------------------------------------*/
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    /*-------------------------------------------------------------------*/
    /* Inputs */
    /*-------------------------------------------------------------------*/
    size_t dim, n_node_elem, n_gauss;
    double *dims_dim;
    double *dims_n_gauss;
    double *dims_n_node_elem;
    double *BF;               /* input matrix */
    double *WFF;              /* input matrix */
    double *IntWeight;        /* input matrix */
    /*-------------------------------------------------------------------*/
    /* outputs */
    /*-------------------------------------------------------------------*/
    double *K;                    /* output matrix */
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix             */
    /*-------------------------------------------------------------------*/
    dims_dim            =  mxGetPr(prhs[0]);
    dims_n_gauss        =  mxGetPr(prhs[1]);
    dims_n_node_elem    =  mxGetPr(prhs[2]);
    dim                 =  (size_t)dims_dim[0];
    n_gauss             =  (size_t)dims_n_gauss[0];
    n_node_elem         =  (size_t)dims_n_node_elem[0];
    BF                  =  mxGetPr(prhs[3]);
    WFF                 =  mxGetPr(prhs[4]);
    IntWeight           =  mxGetPr(prhs[5]);
    /*-------------------------------------------------------------------*/
    /* create the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]             =  mxCreateDoubleMatrix((mwSize)dim*n_node_elem,(mwSize)dim*n_node_elem,mxREAL);
    /*-------------------------------------------------------------------*/
    /* get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    K                   =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)n_gauss,(mwSize)n_node_elem,BF,WFF,IntWeight,K);
}

