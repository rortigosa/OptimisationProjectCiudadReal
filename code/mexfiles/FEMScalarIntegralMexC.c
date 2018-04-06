#include "mex.h"
#include "matfunctions.h"
#include "math.h"
/* */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void perfomer(mwSize ngauss,
        const double *ScalarField,
        const double *IntWeight,
        double *Integral)
{
    /*-------------------------------------------------------------------*/
    /*The C function*/
    /*-------------------------------------------------------------------*/
    Integral[0] =  0;
    mwSize igauss;
    for (igauss=0; igauss<ngauss; ++igauss) {
        /*---------------------------------------------------------------*/
        /*Compute FT*/
        /*---------------------------------------------------------------*/
        Integral[0]  += ScalarField[igauss]*IntWeight[igauss];
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
    size_t ngauss;
    const mwSize  *dims_;      /* input scalar */
    double *ScalarField;    
    double *IntWeight;    
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *Integral;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_              =  mxGetDimensions(prhs[0]);
    ngauss             =  (size_t)dims_[0];    
    ScalarField        =  mxGetPr(prhs[0]);   
    IntWeight          =  mxGetPr(prhs[1]);
    /*-------------------------------------------------------------------*/
    /* Get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)1,(mwSize)1, mxREAL);   /*J*/
    Integral           =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)ngauss, ScalarField, IntWeight, Integral);
}


