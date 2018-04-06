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
        const double *x0_elem,
        const double *X_elem,
        const double *DNX,
        double *F,
        double *Fx0,
        double *H,
        double *Hx0,
        double *J)
{
    /*-------------------------------------------------------------------*/
    /*Temporaries within the C function*/
    /*-------------------------------------------------------------------*/
    double *DNXT           = (double*)malloc(sizeof(double)*(dim*n_node_elem));
    double *DF             = (double*)malloc(sizeof(double)*(dim*dim));
    /*-------------------------------------------------------------------*/
    /*The C function*/
    /*-------------------------------------------------------------------*/
    mwSize igauss, iloop;
    double J0, DJ;
    for (igauss=0; igauss<ngauss; ++igauss) {
        /*---------------------------------------------------------------*/
        /*Compute DNXT*/
        /*---------------------------------------------------------------*/
        transpose(&DNX[dim*n_node_elem*igauss],DNXT,dim,n_node_elem);
        /*---------------------------------------------------------------*/
        /*Compute F, Fx0 and DF*/
        /*---------------------------------------------------------------*/
        matmul(dim,n_node_elem,dim,x_elem,DNXT,&F[dim*dim*igauss]);
        matmul(dim,n_node_elem,dim,x0_elem,DNXT,&Fx0[dim*dim*igauss]);
        for (iloop=0; iloop<dim*dim; ++iloop){
            DF[iloop]    =  F[dim*dim*igauss + iloop] - Fx0[dim*dim*igauss + iloop];
        }
        /*---------------------------------------------------------------*/
        /*Compute H and Hx0*/
        /*---------------------------------------------------------------*/
        cofactor(&F[dim*dim*igauss],&H[dim*dim*igauss],dim);        
        cofactor(&Fx0[dim*dim*igauss],&Hx0[dim*dim*igauss],dim);        
        /*---------------------------------------------------------------*/
        /*Compute J*/
        /*---------------------------------------------------------------*/
        J0                 =  determinant(&Fx0[dim*dim*igauss],dim);
        DJ                 =  scalar_product(&Hx0[dim*dim*igauss],DF,dim*dim);        
        J[igauss]          =  J0 + DJ;
    }
    /*-------------------------------------------------------------------*/
    /* Free temporaries*/
    /*-------------------------------------------------------------------*/
    free(DNXT);    
    free(DF);    
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
    double *x0_elem;
    double *X_elem;    
    double *DNX;    
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *F;
    double *Fx0;
    double *H;
    double *Hx0;
    double *J;            
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_DNX           =  mxGetDimensions(prhs[3]);
    dim                =  (size_t)dims_DNX[0];    
    n_node_elem        =  (size_t)dims_DNX[1];    
    ngauss             =  (size_t)dims_DNX[2];    
    x_elem             =  mxGetPr(prhs[0]);   
    x0_elem            =  mxGetPr(prhs[1]);   
    X_elem             =  mxGetPr(prhs[2]);
    DNX                =  mxGetPr(prhs[3]);
    /*-------------------------------------------------------------------*/
    /* Get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    mwSize FDims[3]    =  {dim,dim,ngauss};            
    mwSize DNXDims[3]  =  {dim,n_node_elem,ngauss};            
    plhs[0]            =  mxCreateNumericArray(3,FDims, mxDOUBLE_CLASS, mxREAL);    /*F*/  
    plhs[1]            =  mxCreateNumericArray(3,FDims, mxDOUBLE_CLASS, mxREAL);    /*Fx0*/  
    plhs[2]            =  mxCreateNumericArray(3,FDims, mxDOUBLE_CLASS, mxREAL);    /*H*/
    plhs[3]            =  mxCreateNumericArray(3,FDims, mxDOUBLE_CLASS, mxREAL);    /*Hx0*/  
    plhs[4]            =  mxCreateDoubleMatrix((mwSize)ngauss,(mwSize)1, mxREAL);   /*J*/
            
    F                  =  mxGetPr(plhs[0]);
    Fx0                =  mxGetPr(plhs[1]);
    H                  =  mxGetPr(plhs[2]);
    Hx0                =  mxGetPr(plhs[3]);
    J                  =  mxGetPr(plhs[4]);
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)ngauss,(mwSize)n_node_elem, x_elem, x0_elem, X_elem, DNX, F, Fx0, H, Hx0, J);
}


