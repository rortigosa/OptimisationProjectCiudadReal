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
        mwSize n_node_elem,
        const double *connectivity,
        double *TInternal)
// void perfomer(mwSize dim,
//         mwSize n_node_elem,
//         double *TInternal)
{
    /*-------------------------------------------------------------------*/
    /*Initialisation of the residual*/
    /*-------------------------------------------------------------------*/
    for (mwSize i=0; i<dim*n_node_elem; i++){
       TInternal[(mwSize)connectivity[i]-1]  =  i;
//         TInternal[i]  =  1.;
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
    size_t dim, n_node_elem;
    double *dim_, *n_node_elem_;
    double *connectivity;
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *TInternal;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dim_               =  mxGetPr(prhs[0]);
    n_node_elem_       =  mxGetPr(prhs[1]); 
    connectivity       =  mxGetPr(prhs[2]);
    
    dim                =  dim_[0];
    n_node_elem        =  n_node_elem_[0];
    /*-------------------------------------------------------------------*/
    /* Pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)n_node_elem*dim,(mwSize)1, mxREAL);  
    TInternal          =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)n_node_elem, connectivity, TInternal);
//    perfomer((mwSize)dim,(mwSize)n_node_elem, TInternal);
}

