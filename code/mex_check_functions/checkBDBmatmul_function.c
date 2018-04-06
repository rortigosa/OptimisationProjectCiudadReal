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
    mwSize capacity      =  dim*n_node_elem*dim*n_node_elem;
    /*-------------------------------------------------------------------*/
    /*Initialise temporary variables*/
    /*-------------------------------------------------------------------*/
    double *BFT          =  (double*)malloc(sizeof(double)*(dim*dim*dim*n_node_elem));

    double *BFT_WFF      =  (double*)malloc(sizeof(double)*(dim*dim*dim*n_node_elem));
    
    double *BFT_WFF_BF   =  (double*)malloc(sizeof(double)*(capacity));
    /*-------------------------------------------------------------------*/
    /*Initialise matrix K*/
    /*-------------------------------------------------------------------*/
    mwSize j;
    for (j=0; j<capacity; ++j){
        K[j]     =  0.;
    }    
    /*-------------------------------------------------------------------*/    
    /* scalar values to use in dgemm */
    /*-------------------------------------------------------------------*/
    double one   =  1.0, zero = 0.0;
    /*-------------------------------------------------------------------*/
    /* Loop over gauss points                                            */
    /*-------------------------------------------------------------------*/
    mwSize igauss;
    for (igauss=0; igauss<n_gauss; ++igauss) {
        /*  FF term  */
        transpose(&BF[dim*dim*dim*n_node_elem*igauss],BFT,dim*dim,dim*n_node_elem);
        matmul(dim*n_node_elem,dim*dim,dim*dim,BFT,&WFF[dim*dim*dim*dim*igauss],BFT_WFF);
        matmul(dim*n_node_elem,dim*dim,dim*n_node_elem,BFT_WFF,&BF[dim*dim*dim*n_node_elem*igauss],BFT_WFF_BF);        
        /*  Constitutive matrix*/       
        for (j=0; j<capacity; ++j){
            K[j]           =  0.5*(BFT_WFF_BF[j])*IntWeight[igauss];
        }        
    }
    /*-------------------------------------------------------------------*/
    /* Symmetrise the constitutive stiffness matrix                      */
    /*-------------------------------------------------------------------*/
    mwSize i;
    for (j=0; j<dim*n_node_elem; j++) {
        for (i=0; i<dim*n_node_elem; i++) {
            K[j*dim*n_node_elem+i]      +=  K[i*dim*n_node_elem+j];
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
    double *K;                /* output matrix */
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

