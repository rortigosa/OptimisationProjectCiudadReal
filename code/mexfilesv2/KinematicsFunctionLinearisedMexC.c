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
        mwSize n_node_elem,
        const double *x_elem,
        const double *xstar_elem,
        const double *X_elem,
        const double *DNX,
        double *F,
        double *H,
        double *J,
        double *Fstar,
        double *Hstar,
        double *Jstar,
        double *Hstarstar)
{
    /*-------------------------------------------------------------------*/
    /*Temporaries within the C function*/
    /*-------------------------------------------------------------------*/
    double *DNXT           = (double*)malloc(sizeof(double)*(dim*n_node_elem));
    /*-------------------------------------------------------------------*/
    /*The C function*/
    /*-------------------------------------------------------------------*/
    mwSize igauss;
    double Jstar_;
    for (igauss=0; igauss<ngauss; ++igauss) {
        /*---------------------------------------------------------------*/
        /*Compute DNXT*/
        /*---------------------------------------------------------------*/
        transpose(&DNX[dim*n_node_elem*igauss],DNXT,dim,n_node_elem);
        /*---------------------------------------------------------------*/
        /*Compute F, H and J*/
        /*---------------------------------------------------------------*/
        matmul(dim,n_node_elem,dim,x_elem,DNXT,&F[dim*dim*igauss]);
        cofactor(&F[dim*dim*igauss],&H[dim*dim*igauss],dim);
        J[igauss]          =  determinant(&F[dim*dim*igauss],dim);
        /*---------------------------------------------------------------*/
        /*Compute Fstar, Hstar and Jstar*/
        /*---------------------------------------------------------------*/
        matmul(dim,n_node_elem,dim,xstar_elem,DNXT,&Fstar[dim*dim*igauss]);
        /*---------------------------------------------------------------*/
        /*Compute Hstar_star, Hstar and Jstar*/
        /*---------------------------------------------------------------*/
        cofactor(&Fstar[dim*dim*igauss],&Hstarstar[dim*dim*igauss],dim);                
        piolaHFunction(&F[dim*dim*igauss],&Fstar[dim*dim*igauss],&Hstar[dim*dim*igauss],dim);                
        Jstar_         =  scalar_product(&F[dim*dim*igauss],&Hstarstar[dim*dim*igauss],dim*dim);        
        Jstar[igauss]  =  Jstar_/2.;                
    }
    /*-------------------------------------------------------------------*/
    /* Free temporaries*/
    /*-------------------------------------------------------------------*/
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
    const mwSize  *dims_DNX;      /* input scalar */
    double *x_elem;    
    double *xstar_elem;
    double *X_elem;    
    double *DNX;    
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *F;
    double *H;
    double *J;            
    double *Fstar;
    double *Hstar;
    double *Jstar;
    double *Hstarstar;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_DNX           =  mxGetDimensions(prhs[3]);
    dim                =  (size_t)dims_DNX[0];    
    n_node_elem        =  (size_t)dims_DNX[1];    
    ngauss             =  (size_t)dims_DNX[2];    
    x_elem             =  mxGetPr(prhs[0]);   
    xstar_elem         =  mxGetPr(prhs[1]);   
    X_elem             =  mxGetPr(prhs[2]);
    DNX                =  mxGetPr(prhs[3]);
    /*-------------------------------------------------------------------*/
    /* Get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    mwSize FDims[3]    =  {dim,dim,ngauss};            
    mwSize DNXDims[3]  =  {dim,n_node_elem,ngauss};            
    plhs[0]            =  mxCreateNumericArray(3,FDims, mxDOUBLE_CLASS, mxREAL);    /*F*/  
    plhs[1]            =  mxCreateNumericArray(3,FDims, mxDOUBLE_CLASS, mxREAL);    /*H*/
    plhs[2]            =  mxCreateDoubleMatrix((mwSize)ngauss,(mwSize)1, mxREAL);   /*J*/
    plhs[3]            =  mxCreateNumericArray(3,FDims, mxDOUBLE_CLASS, mxREAL);    /*Fstar*/  
    plhs[4]            =  mxCreateNumericArray(3,FDims, mxDOUBLE_CLASS, mxREAL);    /*Hstar*/
    plhs[5]            =  mxCreateDoubleMatrix((mwSize)ngauss,(mwSize)1, mxREAL);   /*Jstar*/
    plhs[6]            =  mxCreateNumericArray(3,FDims, mxDOUBLE_CLASS, mxREAL);    /*Hstar*/
            
    F                  =  mxGetPr(plhs[0]);
    H                  =  mxGetPr(plhs[1]);
    J                  =  mxGetPr(plhs[2]);
    Fstar              =  mxGetPr(plhs[3]);
    Hstar              =  mxGetPr(plhs[4]);
    Jstar              =  mxGetPr(plhs[5]);
    Hstarstar          =  mxGetPr(plhs[6]);
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)ngauss,(mwSize)n_node_elem, x_elem, xstar_elem, X_elem, DNX, F, H, J, Fstar, Hstar, Jstar, Hstarstar);
}


