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
        const double *Matrix,
        double *minor)
{
//     for (mwSize i=0; i<dim*dim; ++i){
//         minor[i]  =  Matrix[i];
//     }
    minors_func(dim, Matrix, minor); /*a is a mxm matrix*/
    //trisup(dim, dim, dim, Matrix, Matrix, minor);
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
    size_t dim, ngauss;
    //const mwSize  *dim_, *ngauss_;      /* input scalar */
    double *dim_;
    double *Matrix;    
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *minor;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dim_               =  mxGetPr(prhs[0]);
    dim                =  (size_t)dim_[0];    
    Matrix             =  mxGetPr(prhs[1]);   
    /*-------------------------------------------------------------------*/
    /* Get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)dim,(mwSize)1, mxREAL);
    minor              =  mxGetPr(plhs[0]);    
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim, Matrix, minor);
}


