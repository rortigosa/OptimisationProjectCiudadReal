#include "mex.h"
#include "matfunctions.h"

/* */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void perfomer(mwSize dimi,
        mwSize dimj,
        mwSize n_gauss,
        const double *Amatrix,
        double *AmatrixT)
{
    /*-------------------------------------------------------------------*/
    /*The function*/
    /*-------------------------------------------------------------------*/
    mwSize i;
    for (i=0; i<n_gauss; ++i) {
        transpose(&Amatrix[dimi*dimj*i],&AmatrixT[dimi*dimj*i],dimi,dimj);
    }
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The gateway function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    /*-------------------------------------------------------------------*/
    /*Inputs and declaration*/
    /*-------------------------------------------------------------------*/
    size_t dimi, dimj, n_gauss;
    double *dims_dimi;         /* input scalar */
    double *dims_dimj;         /* input scalar */
    double *dims_n_gauss;      /* input scalar */
    double *Amatrix;           /* input matrix */
    /*-------------------------------------------------------------------*/
    /* outputs */
    /*-------------------------------------------------------------------*/
    double *AT;          /* output matrix */
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_dimi          =  mxGetPr(prhs[0]);
    dims_dimj          =  mxGetPr(prhs[1]);
    dims_n_gauss       =  mxGetPr(prhs[2]);
    dimi               =  (size_t)dims_dimi[0];
    dimj               =  (size_t)dims_dimj[0];
    n_gauss            =  (size_t)dims_n_gauss[0];
    Amatrix            =  mxGetPr(prhs[3]);
    /*-------------------------------------------------------------------*/
    /* get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    mwSize ADims[3]    =  {dimj,dimi,n_gauss};            
    plhs[0]            =  mxCreateNumericArray(3, ADims, mxDOUBLE_CLASS, mxREAL);
    AT                 =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dimi,(mwSize)dimj,(mwSize)n_gauss,Amatrix,AT);
}


