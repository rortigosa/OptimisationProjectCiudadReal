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
        const double *uGauss,
        const double *IntWeight,
        double *ObjFun)
{
    /*-------------------------------------------------------------------*/
    /*Initialise stiffness matrices*/
    /*-------------------------------------------------------------------*/
    ObjFun  =  0.;
    mwSize igauss;
    /*-------------------------------------------------------------------*/
    /*Loop over Gauss points                                             */
    /*-------------------------------------------------------------------*/
    double uu;
    for (igauss=0; igauss<ngauss; igauss++){
        uu          =  scalar_product(&uGauss[igauss*dim],&uGauss[igauss*dim],dim);
        ObjFunc    +=  sqrt(uu)*IntWeight[igauss];
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
    size_t dim, ngauss;
    const mwSize  *dims_; 
    double *uGauss;  
    double *IntWeight; 
    /*-------------------------------------------------------------------*/
    /* outputs */
    /*-------------------------------------------------------------------*/
    double *ObjFun;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_              =  mxGetDimensions(prhs[0]);
    dim                =  (size_t)dims_[0];    
    ngauss             =  (size_t)dims_[1];    
    uGauss             =  mxGetPr(prhs[0]);
    IntWeight          =  mxGetPr(prhs[1]);
    /*-------------------------------------------------------------------*/
    /* get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)1, (mwSize)1, mxREAL);
    ObjFun             =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim, (mwSize)ngauss, uGauss, IntWeight, ObjFun);
}


