#include "mex.h"
#include "matfunctions.h"
#include "math.h"
/* */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void perfomer(mwSize m,
        mwSize ngauss,
        const double *Matrix,
        const double *Vector,
        double *VectorOut)
{
    /*-------------------------------------------------------------------*/
    /*The C function*/
    /*-------------------------------------------------------------------*/
    mwSize igauss, anode, idim;
    for (igauss=0; igauss<ngauss; ++igauss) {
        MatVectorMul(m, &Matrix[igauss*m*m], &Vector[igauss*m], &VectorOut[igauss*m]);
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
    /*Inputs of the C function*/
    /*-------------------------------------------------------------------*/
    size_t m, ngauss;
    double *m_, *ngauss_;
    double *Vector;    
    double *Matrix;    
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *VectorOut;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    m_                 =  mxGetPr(prhs[0]);
    m                  =  (size_t)m_[0];    
    ngauss_            =  mxGetPr(prhs[1]);
    ngauss             =  (size_t)ngauss_[0];    
    Matrix             =  mxGetPr(prhs[2]);
    Vector             =  mxGetPr(prhs[3]);   
    /*-------------------------------------------------------------------*/
    /* Get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)m,(mwSize)ngauss, mxREAL);   
    VectorOut          =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)m, (mwSize)ngauss, Matrix, Vector, VectorOut);
}


