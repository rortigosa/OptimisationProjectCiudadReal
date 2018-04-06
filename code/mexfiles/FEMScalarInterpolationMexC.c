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
        mwSize n_node_elem,
        const double *ScalarField,
        const double *Nshape,
        double *Interpolation)
{
    /*-------------------------------------------------------------------*/
    /*The C function*/
    /*-------------------------------------------------------------------*/
    mwSize igauss, anode;
    for (igauss=0; igauss<ngauss; ++igauss){
        Interpolation[igauss]  =  0.;
    }
    for (igauss=0; igauss<ngauss; ++igauss) {
        for (anode=0; anode<n_node_elem; ++anode){
            Interpolation[igauss]  += ScalarField[anode]*Nshape[anode + igauss*n_node_elem];
        }        
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
    size_t ngauss, n_node_elem;
    const mwSize  *dims_;      /* input scalar */
    double *ScalarField;    
    double *NShape;    
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *Interpolation;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_              =  mxGetDimensions(prhs[1]);
    n_node_elem        =  (size_t)dims_[0];    
    ngauss             =  (size_t)dims_[1];    
    ScalarField        =  mxGetPr(prhs[0]);   
    NShape             =  mxGetPr(prhs[1]);
    /*-------------------------------------------------------------------*/
    /* Get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)ngauss,(mwSize)1, mxREAL);   /*J*/
    Interpolation      =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)ngauss, (mwSize)n_node_elem, ScalarField, NShape, Interpolation);
}


