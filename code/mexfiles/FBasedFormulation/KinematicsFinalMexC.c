#include "mex.h"
#include "matfunctions.h"
/* */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void perfomer(mwSize dim,
        mwSize ngauss,
        mwSize n_node_elem,
        const double *x_elem,
        const double *X_elem,
        const double *DN_chi,
        const double *Weight,
        double *F,
        double *H,
        double *J,
        double *DNX,
        double *IntWeight)
{
    /*-------------------------------------------------------------------*/
    /*Temporaries within the C function*/
    /*-------------------------------------------------------------------*/
    double *DX_chi      = (double*)malloc(sizeof(double)*(dim*dim));
    double *DN_chiT     = (double*)malloc(sizeof(double)*(dim*n_node_elem));
    double *DX_chiT     = (double*)malloc(sizeof(double)*(dim*dim));
    double *invDX_chiT  = (double*)malloc(sizeof(double)*(dim*dim));
    double *DNXT        = (double*)malloc(sizeof(double)*(dim*n_node_elem));
    /*-------------------------------------------------------------------*/
    /*The C function*/
    /*-------------------------------------------------------------------*/
    double DetDXChi;
    mwSize igauss;
    for (igauss=0; igauss<ngauss; ++igauss) {
        /*Compute DNchiT*/
        transpose(&DN_chi[dim*n_node_elem*igauss],DN_chiT,dim,n_node_elem);
        /*Compute DXchi*/
        matmul(dim,n_node_elem,dim,X_elem,DN_chiT,DX_chi);
        /*Compute DXchiT*/
        transpose(DX_chi,DX_chiT,dim,dim);
        /*Compute inverse of DXchiT*/
        inverse(DX_chiT,invDX_chiT,dim);
        /*Compute DNX*/
        matmul(dim,dim,n_node_elem,invDX_chiT,&DN_chi[dim*n_node_elem*igauss],&DNX[dim*n_node_elem*igauss]);        
        /*detDXChi*/
        DetDXChi           =  determinant(DX_chi,dim);
        /*Integration weight*/
        IntWeight[igauss]  =  DetDXChi*Weight[igauss];   
        /*Compute DNX*/
        transpose(&DNX[dim*n_node_elem*igauss],DNXT,dim,n_node_elem);
        /*Compute F, H and J*/
        matmul(dim,n_node_elem,dim,x_elem,DNXT,&F[dim*dim*igauss]);
        cofactor(&F[dim*dim*igauss],&H[dim*dim*igauss],dim);
        J[igauss]          =  determinant(&F[dim*dim*igauss],dim);
    }
    /*-------------------------------------------------------------------*/
    /* Free temporaries*/
    /*-------------------------------------------------------------------*/
    free(DX_chi);
    free(DN_chiT);
    free(DX_chiT);
    free(invDX_chiT);
    free(DNXT);
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
    size_t dim, n_node_elem, ngauss;
    const mwSize  *dims_DNchi;      /* input scalar */
    double *x_elem;    
    double *X_elem;    
    double *DN_chi;    
    double *Weight;
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *F;
    double *H;
    double *J;            
    double *DNX; 
    double *IntWeight; 
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_DNchi         =  mxGetDimensions(prhs[2]);
    dim                =  (size_t)dims_DNchi[0];    
    n_node_elem        =  (size_t)dims_DNchi[1];    
    ngauss             =  (size_t)dims_DNchi[2];    
    x_elem             =  mxGetPr(prhs[0]);   
    X_elem             =  mxGetPr(prhs[1]);
    DN_chi             =  mxGetPr(prhs[2]);
    Weight             =  mxGetPr(prhs[3]);
    /*-------------------------------------------------------------------*/
    /* Get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    mwSize FDims[3]    =  {dim,dim,ngauss};            
    mwSize DNXDims[3]  =  {dim,n_node_elem,ngauss};            
    plhs[0]            =  mxCreateNumericArray(3,FDims, mxDOUBLE_CLASS, mxREAL);    /*F*/  
    plhs[1]            =  mxCreateNumericArray(3,FDims, mxDOUBLE_CLASS, mxREAL);    /*H*/
    plhs[2]            =  mxCreateDoubleMatrix((mwSize)ngauss,(mwSize)1, mxREAL);   /*J*/
    plhs[3]            =  mxCreateNumericArray(3, DNXDims, mxDOUBLE_CLASS, mxREAL); /*DNX*/
    plhs[4]            =  mxCreateDoubleMatrix((mwSize)ngauss, (mwSize)1, mxREAL); /*DetDXChi*/

    F                  =  mxGetPr(plhs[0]);
    H                  =  mxGetPr(plhs[1]);
    J                  =  mxGetPr(plhs[2]);
    DNX                =  mxGetPr(plhs[3]);
    IntWeight          =  mxGetPr(plhs[4]);
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)ngauss,(mwSize)n_node_elem,x_elem,X_elem,DN_chi,Weight,F,H,J,DNX,IntWeight);
}


