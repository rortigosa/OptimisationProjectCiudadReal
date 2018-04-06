#include "mex.h"
#include "matfunctions.h"
#include "TensorAlgebra.h"
#include "math.h"
/* */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void perfomer(mwSize dim,
        const double *A,
        const double *B,
        const double *H,
        double *Tensor)
{
    //FourthOrderIdentity_ijII(dim, Tensor);
    //FourthOrderIdentity_iIjI(dim, Tensor);  
    //FourthOrderIdentity_iJjI(dim, Tensor);
    //Cross_IdentityMatrix_42_(dim, A, Tensor);
    //Outer_22_(dim, A, B, Tensor);     
    //Cross_42_(dim, H, B, Tensor);
   Cross_24_(dim, H, B, Tensor);    
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
    size_t dim;
    double *dim_;
    double *A;    
    double *B;    
    double *H;    
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *Tensor;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dim_               =  mxGetPr(prhs[0]);
    dim                =  (size_t)dim_[0];    
    A                  =  mxGetPr(prhs[1]);   
    B                  =  mxGetPr(prhs[2]);   
    H                  =  mxGetPr(prhs[3]);   
    /*-------------------------------------------------------------------*/
    /* Get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)dim*dim,(mwSize)dim*dim, mxREAL);
    Tensor             =  mxGetPr(plhs[0]);    
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim, A, B, H, Tensor);
}


