#include "mex.h"
#include "matfunctions.h"
#include "math.h"
/* */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
// void perfomer(mwSize m,
//        double *MatrixReg){
// void perfomer(mwSize NIter,
//               mwSize m,
//               const double *Matrix,
//               double *MatrixReg){
//            BisectionStability(NIter,m,Matrix,MatrixReg);
// }
void perfomer(mwSize m,
              double *alpha_max,
              const double *Matrix,
              double *MatrixReg,){
//           BisectionStability(NIter,m,Matrix,MatrixReg);
             BisectionStability(m,alpha_max[0],Matrix,MatrixReg);
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
    size_t dim, NIter;
    double *dim_, *NIter_;
    double *alpha_max;
    double *Matrix;    
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *MatrixReg;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
//    NIter_             =  mxGetPr(prhs[0]);
//    NIter              =  (size_t)NIter_[0];    
    dim_               =  mxGetPr(prhs[0]);
    dim                =  (size_t)dim_[0];    
    alpha_max          =  mxGetPr(prhs[1]);       
    Matrix             =  mxGetPr(prhs[2]);   
    /*-------------------------------------------------------------------*/
    /* Get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)dim,(mwSize)dim, mxREAL);
    MatrixReg          =  mxGetPr(plhs[0]);    
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
//    perfomer((mwSize)NIter, (mwSize)dim, Matrix, MatrixReg);
    perfomer((mwSize)dim, alpha_max, Matrix, MatrixReg);
//    perfomer((mwSize)dim, MatrixReg);
}


