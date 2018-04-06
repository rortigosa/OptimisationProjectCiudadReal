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
        const double *x_elem,
        const double *X_elem,
        const double *DNX,
        double *F,
        double *H,
        double *J)
{
    /*-------------------------------------------------------------------*/
    /*Temporaries within the C function*/
    /*-------------------------------------------------------------------*/
    double *DNXT           = (double*)malloc(sizeof(double)*(dim*n_node_elem));
    /*-------------------------------------------------------------------*/
    /*The C function*/
    /*-------------------------------------------------------------------*/
    mwSize igauss;
    for (igauss=0; igauss<ngauss; ++igauss) {
        /*---------------------------------------------------------------*/
        /*Compute DNXT*/
        /*---------------------------------------------------------------*/
        transpose(&DNX[dim*n_node_elem*igauss],DNXT,dim,n_node_elem);
        /*---------------------------------------------------------------*/
        /*Compute F, H and J*/
        /*---------------------------------------------------------------*/
        matmul(dim,n_node_elem,dim,x_elem,DNXT,&F[dim*dim*igauss]);
        cofactor(&F[dim*dim*igauss],&H[dim*dim*igauss],dim);
        J[igauss]          =  determinant(&F[dim*dim*igauss],dim);
    }
    /*-------------------------------------------------------------------*/
    /* Free temporaries*/
    /*-------------------------------------------------------------------*/
    free(DNXT);
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
    double *x_elem;    
    double *X_elem;    
    double *DNX;    
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *F;
    double *H;
    double *J;            
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_DNX           =  mxGetDimensions(prhs[2]);
    dim                =  (size_t)dims_DNX[0];    
    n_node_elem        =  (size_t)dims_DNX[1];    
    ngauss             =  (size_t)dims_DNX[2];    
    x_elem             =  mxGetPr(prhs[0]);   
    X_elem             =  mxGetPr(prhs[1]);
    DNX                =  mxGetPr(prhs[2]);
    /*-------------------------------------------------------------------*/
    /* Get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    mwSize FDims[3]    =  {dim,dim,ngauss};            
    mwSize DNXDims[3]  =  {dim,n_node_elem,ngauss};            
    plhs[0]            =  mxCreateNumericArray(3,FDims, mxDOUBLE_CLASS, mxREAL);    /*F*/  
    plhs[1]            =  mxCreateNumericArray(3,FDims, mxDOUBLE_CLASS, mxREAL);    /*H*/
    plhs[2]            =  mxCreateDoubleMatrix((mwSize)ngauss,(mwSize)1, mxREAL);   /*J*/
            
    F                  =  mxGetPr(plhs[0]);
    H                  =  mxGetPr(plhs[1]);
    J                  =  mxGetPr(plhs[2]);
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)ngauss,(mwSize)n_node_elem, x_elem, X_elem, DNX, F, H, J);
}


