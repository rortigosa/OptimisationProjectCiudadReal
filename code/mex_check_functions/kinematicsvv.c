#include "mex.h"
#include "matfunctions.h"

/* */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void perfomer(mwSize dim,
        mwSize n_gauss,
        mwSize n_node_elem,
        const double *x_elem,
        const double *X_elem,
        const double *DN_chi,
        double *DXchi)
{
    /*-------------------------------------------------------------------*/
    /*Temporaries within the C function*/
    /*-------------------------------------------------------------------*/
    double *DN_chiT     = (double*)malloc(sizeof(double)*(dim*n_node_elem));
    /*-------------------------------------------------------------------*/
    /*The function*/
    /*-------------------------------------------------------------------*/
    mwSize i;
    /* Loop over gauss points*/
    for (i=0; i<n_gauss; ++i) {
        /*Compute DNchiT*/
        transpose(&DN_chi[dim*n_node_elem*i],DN_chiT,dim,n_node_elem);
        /*Compute DXchi*/
         matmul(dim,n_node_elem,dim,X_elem,DN_chiT,&DXchi[dim*dim*i]);
    }
    /*-------------------------------------------------------------------*/
    /* Free temporaries*/
    /*-------------------------------------------------------------------*/
    free(DN_chiT);
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
    size_t dim, n_node_elem, n_gauss;
    double *dims_dim;             /* input scalar */
    double *dims_n_gauss;         /* input scalar */
    double *x_elem;               /* input matrix */
    double *X_elem;               /* input matrix */
    double *DN_chi;               /* input matrix */
    /*-------------------------------------------------------------------*/
    /* outputs */
    /*-------------------------------------------------------------------*/
     double *DXChi;                  /* output matrix */
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_dim           =  mxGetPr(prhs[0]);
    dims_n_gauss       =  mxGetPr(prhs[1]);
    dim                =  (size_t)dims_dim[0];
    n_gauss            =  (size_t)dims_n_gauss[0];
    n_node_elem        =  mxGetN(prhs[2]);
    x_elem             =  mxGetPr(prhs[2]);
    X_elem             =  mxGetPr(prhs[3]);
    DN_chi             =  mxGetPr(prhs[4]);

      mwSize DXChiDims[3]  =  {dim,dim,n_gauss};            
    plhs[0]            =  mxCreateNumericArray(3, DXChiDims, mxDOUBLE_CLASS, mxREAL);
    /*-------------------------------------------------------------------*/
    /* get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    DXChi                =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)n_gauss,(mwSize)n_node_elem,x_elem,X_elem,DN_chi,DXChi);
}


