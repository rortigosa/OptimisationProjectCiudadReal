#include "mex.h"
#include "FastorHelper.h"

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
template<size_t ndim>
void MooneyRivlin(double mu1,
        double mu2,
        double lambda,
        const double *F_m,
        const double *C_m,
        const double *G_m,
        const double detC_m,
        double *Elasticity_m);
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/*2D Piola functions*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
template<>
void MooneyRivlin<2>(double mu1,
        double mu2,
        double lambda,
        const double *F_m,
        const double *C_m,
        const double *G_m,
        const double detC_m,
        double *Elasticity_m)
{
    /*-------------------------------------------------------------------*/
    /*Dimension of the problem*/
    /*-------------------------------------------------------------------*/
    const mwSize  ndim  =  2;
    /*-------------------------------------------------------------------*/
    /*Copy from C to Fastor*/
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim> F;
    copy_matlab(F,F_m);
    Tensor<double,ndim,ndim> C;
    copy_matlab(C,C_m);
    Tensor<double,ndim,ndim> G;
    copy_matlab(G,G_m);
    double detC = detC_m;
    /*-------------------------------------------------------------------*/    
    // IDENTITY SECOND ORDER TENSOR
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim> Imatrix; Imatrix.eye();
    Tensor<double,ndim,ndim,ndim,ndim> I41     =  outer(Imatrix,Imatrix);
    Tensor<double,ndim,ndim,ndim,ndim> Elasticity  =  I41;
    /*-------------------------------------------------------------------*/    
    // Copy back from Fastor to C*
    /*-------------------------------------------------------------------*/    
    copy_fastor(Elasticity_m,Elasticity);
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/*3D Piola functions*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
template<>
void MooneyRivlin<3>(double mu1,
        double mu2,
        double lambda,
        const double *F_m,
        const double *C_m,
        const double *G_m,
        const double detC_m,
        double *Elasticity_m)
{
    const mwSize  ndim  =  3;
    Tensor<double,ndim,ndim> F;
    copy_matlab(F,F_m);
    Tensor<double,ndim,ndim> C;
    copy_matlab(C,C_m);
    Tensor<double,ndim,ndim> G;
    copy_matlab(G,G_m);
    double detC = detC_m;
    /*-------------------------------------------------------------------*/    
    // IDENTITY SECOND ORDER TENSOR
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim> Imatrix; Imatrix.eye();
    Tensor<double,ndim,ndim,ndim,ndim> I41     =  outer(Imatrix,Imatrix);
    Tensor<double,ndim,ndim,ndim,ndim> Elasticity = I41;
    /*-------------------------------------------------------------------*/    
    // Copy back from Fastor to C*
    /*-------------------------------------------------------------------*/    
    copy_fastor(Elasticity_m,Elasticity);
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
    const mwSize  *dims_F;   /* input scalar */   
    double *mu1_, *mu2_, *lambda_;
    double mu1, mu2, lambda;
    double *F;               /* input matrix */
    double *C;               /* input matrix */
    double *G;               /* input matrix */
    double *detC;               /* input matrix */
    /*-------------------------------------------------------------------*/
    /* outputs */
    /*-------------------------------------------------------------------*/
    double *Elasticity;
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
    C                  =  mxGetPr(prhs[4]);
    G                  =  mxGetPr(prhs[5]);
    detC               =  mxGetPr(prhs[6]);
    /*-------------------------------------------------------------------*/
    /* get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    mwSize ElastDims[5]  =  {dim,dim,dim,dim,ngauss};
    plhs[0]              =  mxCreateNumericArray(5, ElastDims, mxDOUBLE_CLASS, mxREAL);   /*P*/
    Elasticity           =  mxGetPr(plhs[0]);
    /*-------------------------------------------------------------------*/
    /* call the computational routine */
    /*-------------------------------------------------------------------*/
    mwSize igauss;
    if (dim==2){
       for (igauss=0; igauss<ngauss; ++igauss){
           MooneyRivlin<2>(mu1,mu2,lambda,&F[dim*dim*igauss],&C[dim*dim*igauss],&G[dim*dim*igauss],detC[igauss],&Elasticity[dim*dim*dim*dim*igauss]);
       }
    }
    else if (dim==3){
       for (igauss=0; igauss<ngauss; ++igauss){
           MooneyRivlin<3>(mu1,mu2,lambda,&F[dim*dim*igauss],&C[dim*dim*igauss],&G[dim*dim*igauss],detC[igauss],&Elasticity[dim*dim*dim*dim*igauss]);
       }    
    }
}


