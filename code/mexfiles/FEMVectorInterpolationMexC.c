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
        mwSize vector_dim,
        const double *VectorField,
        const double *Nshape,
        double *Interpolation)
{
    /*-------------------------------------------------------------------*/
    /*The C function*/
    /*-------------------------------------------------------------------*/
    mwSize igauss, anode, idim;
    for (idim=0; idim<ngauss*vector_dim; ++idim){        
        Interpolation[idim]  =  0.;
    }
    for (igauss=0; igauss<ngauss; ++igauss) {
        for (anode=0; anode<n_node_elem; ++anode){
            for (idim=0; idim<vector_dim; ++idim){
                Interpolation[idim + vector_dim*igauss]  += VectorField[idim + anode*vector_dim]*Nshape[anode + igauss*n_node_elem];
            }
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
    size_t ngauss, n_node_elem, vector_dim;
    const mwSize  *dims_vector;      /* input scalar */
    const mwSize  *dims_N;      /* input scalar */
    double *VectorField;    
    double *NShape;    
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *Interpolation;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_vector        =  mxGetDimensions(prhs[0]);
    dims_N             =  mxGetDimensions(prhs[1]);
    vector_dim         =  (size_t)dims_vector[0];    
    n_node_elem        =  (size_t)dims_N[0];    
    ngauss             =  (size_t)dims_N[1];    
    VectorField        =  mxGetPr(prhs[0]);   
    NShape             =  mxGetPr(prhs[1]);
    /*-------------------------------------------------------------------*/
    /* Get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)vector_dim,(mwSize)ngauss, mxREAL);   /*J*/
    Interpolation      =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)ngauss, (mwSize)n_node_elem, (mwSize)vector_dim, VectorField, NShape, Interpolation);
}


