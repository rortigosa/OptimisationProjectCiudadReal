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
        double *F,
        double *H,
        double *J)
{
    /*-------------------------------------------------------------------*/
    /*Temporaries within the C function*/
    /*-------------------------------------------------------------------*/
    double *DX_chi      = (double*)malloc(sizeof(double)*(dim*dim));
    double *DN_chiT     = (double*)malloc(sizeof(double)*(dim*n_node_elem));
    double *DX_chiT     = (double*)malloc(sizeof(double)*(dim*dim));
    double *invDX_chiT  = (double*)malloc(sizeof(double)*(dim*dim));
    double *DNX         = (double*)malloc(sizeof(double)*(dim*n_node_elem));
    double *DNXT        = (double*)malloc(sizeof(double)*(dim*n_node_elem));
    /*-------------------------------------------------------------------*/
    /*The function*/
    /*-------------------------------------------------------------------*/
    /* Loop over gauss points*/
    mwSize i;
    for (i=0; i<n_gauss; ++i) {
        /*Compute DNchiT*/
        transpose(&DN_chi[dim*n_node_elem*i],DN_chiT,dim,n_node_elem);
        /*Compute DXchi*/
        matmul(dim,n_node_elem,dim,X_elem,DN_chiT,DX_chi);
        /*Compute DXchiT*/
        transpose(DX_chi,DX_chiT,dim,dim);
        /*Compute inverse of DXchiT*/
        inverse(DX_chiT,invDX_chiT,dim);
        /*Compute DNX*/
        matmul(dim,dim,n_node_elem,invDX_chiT,&DN_chi[dim*n_node_elem*i],DNX);        
        /*Compute DNXT*/
        transpose(DNX,DNXT,dim,n_node_elem);
        /*Compute inverse of F, H, J and detDXChi*/
        matmul(dim,n_node_elem,dim,x_elem,DNXT,&F[dim*dim*i]);
        cofactor(&F[dim*dim*i],&H[dim*dim*i],dim);
        J[i]            =  determinant(&F[dim*dim*i],dim);
    }
    /*-------------------------------------------------------------------*/
    /* Free temporaries*/
    /*-------------------------------------------------------------------*/
    free(DX_chi);
    free(DN_chiT);
    free(DX_chiT);
    free(invDX_chiT);
    free(DNXT);
    free(DNX);
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
    double *F;                    /* output matrix */
    double *H;                    /* output matrix */
    double *J;                    /* output matrix */
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
    mwSize FDims[3]    =  {dim,dim,n_gauss};
            
    plhs[0]            =  mxCreateNumericArray(3, FDims, mxDOUBLE_CLASS, mxREAL);
    plhs[1]            =  mxCreateNumericArray(3, FDims, mxDOUBLE_CLASS, mxREAL);
    plhs[2]            =  mxCreateDoubleMatrix((mwSize)n_gauss,(mwSize)1,mxREAL);
    /*-------------------------------------------------------------------*/
    /* get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    F                  =  mxGetPr(plhs[0]);
    H                  =  mxGetPr(plhs[1]);
    J                  =  mxGetPr(plhs[2]);
    /*-------------------------------------------------------------------*/
    /* call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)n_gauss,(mwSize)n_node_elem,x_elem,X_elem,DN_chi,F,H,J);
}


