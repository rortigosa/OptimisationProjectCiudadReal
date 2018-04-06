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
        double mu1,
        double mu2,
        double lambda,
        const double *F,
        const double *H,
        const double *J,
        double *W)
{
    /*-------------------------------------------------------------------*/
    /*Temporaries within the C function*/
    /*-------------------------------------------------------------------*/
    double *FT           = (double*)malloc(sizeof(double)*(dim*dim));
    double *FTF          = (double*)malloc(sizeof(double)*(dim*dim));
    double *HT           = (double*)malloc(sizeof(double)*(dim*dim));
    double *HTH          = (double*)malloc(sizeof(double)*(dim*dim));
    /*-------------------------------------------------------------------*/
    /*The C function*/
    /*-------------------------------------------------------------------*/
    mwSize igauss;
    double IIF, IIH;
    if (dim==2){
        for (igauss=0; igauss<ngauss; ++igauss) {
            /*-----------------------------------------------------------*/
            /*Compute FT*/
            /*-----------------------------------------------------------*/
            transpose(&F[dim*dim*igauss],FT,dim,dim);
            matmul(dim,dim,dim,FT,&F[dim*dim*igauss],FTF);
            IIF         =  trace(FTF,dim);
            W[igauss]   =  mu1/2.*IIF - (mu1 + 2.*mu2)*log(J[igauss]) + mu2/2.*pow(J[igauss],2) + lambda/2.*(pow(J[igauss] - 1.),2); 
            }        
    }
    else if (dim==3){
        for (igauss=0; igauss<ngauss; ++igauss) {
            /*-----------------------------------------------------------*/
            /*Compute FT*/
            /*-----------------------------------------------------------*/
            transpose(&F[dim*dim*igauss],FT,dim,dim);
            transpose(&H[dim*dim*igauss],HT,dim,dim);
            matmul(dim,dim,dim,FT,&F[dim*dim*igauss],FTF);
            matmul(dim,dim,dim,HT,&H[dim*dim*igauss],HTH);
            IIF         =  trace(FTF,dim);
            IIH         =  trace(HTH,dim);
            W[igauss]   =  mu1/2.*IIF + mu2/2.*IIH - (mu1 + 2.*mu2)*log(J[igauss]) + lambda/2.*(pow(J[igauss] - 1.),2); 
            }                
    }
    /*-------------------------------------------------------------------*/
    /* Free temporaries*/
    /*-------------------------------------------------------------------*/
    free(FT);
    free(FTF);
    free(HT);
    free(HTH);
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
    size_t dim, ngauss;
    const mwSize  *dims_F;      /* input scalar */
    double *mu1_, *mu2_, *lambda_;
    double mu1, mu2, lambda;
    double *F;    
    double *H;    
    double *J;    
    /*-------------------------------------------------------------------*/
    /* outputs of the C function (computational routine)*/
    /*-------------------------------------------------------------------*/
    double *W;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/
    dims_F             =  mxGetDimensions(prhs[3]);
    dim                =  (size_t)dims_F[0];    
    ngauss             =  (size_t)dims_F[2];    
    mu1_               =  mxGetPr(prhs[0]);
    mu2_               =  mxGetPr(prhs[1]);
    lambda_            =  mxGetPr(prhs[2]);
    mu1                =  mu1_[0];
    mu2                =  mu2_[0];
    lambda             =  lambda_[0];
    F                  =  mxGetPr(prhs[3]);   
    H                  =  mxGetPr(prhs[4]);
    J                  =  mxGetPr(prhs[5]);
    /*-------------------------------------------------------------------*/
    /* Get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    plhs[0]            =  mxCreateDoubleMatrix((mwSize)ngauss,(mwSize)1, mxREAL);   /*J*/
    W                  =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* Call the computational routine */
    /*-------------------------------------------------------------------*/
    perfomer((mwSize)dim,(mwSize)ngauss, mu1, mu2, lambda, F, H, J, W);
}


