#include "mex.h"
#include "matfunctions.h"
#include "math.h"
/* */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void perfomer(mwSize dim,
        mwSize ngauss,
        mwSize n_node_elem,
        const double *Piola,
        const double *p_elem,
        const double *DNX,
        const double *IntWeight,
        double *DIDrho)
{
    /*-------------------------------------------------------------------*/
    /*Temporaries within the C function*/
    /*-------------------------------------------------------------------*/
    double *DpDX           = (double*)malloc(sizeof(double)*(dim*dim));
    double *DNXT           = (double*)malloc(sizeof(double)*(dim*n_node_elem));
    double *PT             = (double*)malloc(sizeof(double)*(dim*dim));    
    double *PT_DpDX        = (double*)malloc(sizeof(double)*(dim*n_node_elem));
    /*-------------------------------------------------------------------*/
    /*The C function*/
    /*-------------------------------------------------------------------*/
    mwSize igauss;
    DIDrho[0]  =  0.;
    for (igauss=0; igauss<ngauss; ++igauss) {
        /*---------------------------------------------------------------*/
        /*Compute DNXT*/
        /*---------------------------------------------------------------*/
        transpose(&DNX[dim*n_node_elem*igauss],DNXT,dim,n_node_elem);
        /*---------------------------------------------------------------*/
        /*Compute DpDX*/
        /*---------------------------------------------------------------*/
        matmul(dim,n_node_elem,dim,p_elem,DNXT,DpDX);
        /*---------------------------------------------------------------*/
        /*Compute transpose of Piola*/
        /*---------------------------------------------------------------*/
        transpose(&Piola[dim*dim*igauss],PT,dim,dim);
        /*---------------------------------------------------------------*/
        /*Compute PT_DpDX*/
        /*---------------------------------------------------------------*/
        matmul(dim,dim,n_node_elem,PT,DpDX,PT_DpDX);
        /*---------------------------------------------------------------*/
        /*Compute Sensitivity*/
        /*---------------------------------------------------------------*/
        DIDrho[0]  +=  trace(PT_DpDX,dim)*IntWeight[igauss];
    }
    /*-------------------------------------------------------------------*/
    /* Free temporaries*/
    /*-------------------------------------------------------------------*/
    free(DpDX);
    free(DNXT);
    free(PT);
    free(PT_DpDX);
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
    /*Inputs of the C function*/
    /*-------------------------------------------------------------------*/
    size_t dim, n_node_elem, ngauss;
    const mwSize  *dims_DNX;      /* input scalar */
    double *Piola;    
    double *p_elem;    
    double *DNX;    
    double *IntWeight;
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *DIDrho;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_DNX           =  mxGetDimensions(prhs[2]);
    dim                =  (size_t)dims_DNX[0];    
    n_node_elem        =  (size_t)dims_DNX[1];    
    ngauss             =  (size_t)dims_DNX[2];    
    Piola              =  mxGetPr(prhs[0]);
    p_elem             =  mxGetPr(prhs[1]);   
    DNX                =  mxGetPr(prhs[2]);
    IntWeight          =  mxGetPr(prhs[3]);
    /*-------------------------------------------------------------------*/
    /* Get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)1, (mwSize)1, mxREAL); /*DetDXChi*/            
    DIDrho             =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)ngauss,(mwSize)n_node_elem, Piola, p_elem, DNX, IntWeight, DIDrho);
}


