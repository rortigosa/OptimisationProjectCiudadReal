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
        const double *H_m,
        double J_m,
        double *P_m,
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
        const double *H_m,
        double J_m,
        double *P_m,
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
    Tensor<double,ndim,ndim> H;
    copy_matlab(H,H_m);
    double J = J_m;
    /*-------------------------------------------------------------------*/    
    // IDENTITY SECOND ORDER TENSOR
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim> Imatrix; Imatrix.eye();
    /*-------------------------------------------------------------------*/
    // COMPUTE FIRST PIOLA STRESS TENSOR    
    /*-------------------------------------------------------------------*/
    Tensor<double,ndim,ndim> P   =  matmul(F,F);    
    /*-------------------------------------------------------------------*/    
    // Auxiliary tensors and variables needed
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim,ndim,ndim> I41     =  outer(Imatrix,Imatrix);
    /*-------------------------------------------------------------------*/    
    // CC  =  4*D2WDdetCDdetC + 4*DWDdetC*DGDC
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim,ndim,ndim> Elasticity4D  = I41;    
    Elasticity4D  =  permutation<Index<3,4,1,2>>(Elasticity4D);
    Tensor<double,ndim*ndim,ndim*ndim> Elasticity  =  reshape<ndim*ndim,ndim*ndim>(Elasticity4D);
    /*-------------------------------------------------------------------*/    
    // Copy back from Fastor to C*
    /*-------------------------------------------------------------------*/    
    copy_fastor(P_m,P);    
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
        const double *H_m,
        double J_m,
        double *P_m,
        double *Elasticity_m)
{
    const mwSize  ndim  =  3;
    Tensor<double,ndim,ndim> F;
    copy_matlab(F,F_m);
    Tensor<double,ndim,ndim> H;
    copy_matlab(H,H_m);
    double J = J_m;
    /*-------------------------------------------------------------------*/    
    // IDENTITY SECOND ORDER TENSOR
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim> Imatrix; Imatrix.eye();
    /*-------------------------------------------------------------------*/
    // COMPUTE FIRST PIOLA STRESS TENSOR    
    /*-------------------------------------------------------------------*/
    //Tensor<double,ndim,ndim> P   =  matmul(F,H);    
    Tensor<double,ndim,ndim> P   =  cross(F,H);    
    /*-------------------------------------------------------------------*/    
    // Auxiliary tensors and variables needed
    /*-------------------------------------------------------------------*/    
//    Tensor<double,ndim,ndim,ndim,ndim> I41     =  outer(Imatrix,Imatrix);
    Tensor<double,ndim,ndim,ndim,ndim> FH     =  outer(F,H);
//    Tensor<double,ndim,ndim,ndim,ndim> FHF    =  cross(F,cross(FH,F));
    Tensor<double,ndim,ndim,ndim,ndim> FHF    =  cross(FH,F);
    //Tensor<double,ndim,ndim,ndim,ndim> crossFHF  =  cross(FH,F);
    Tensor<double,ndim,ndim,ndim,ndim> Elasticity4D  =  FHF;
    Tensor<double,ndim*ndim,ndim*ndim> Elasticity  =  reshape<ndim*ndim,ndim*ndim>(Elasticity4D);
    /*-------------------------------------------------------------------*/    
    // Copy back from Fastor to C*
    /*-------------------------------------------------------------------*/    
    copy_fastor(P_m,P);    
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
    double *H;               /* input matrix */
    double *J;               /* input matrix */
    /*-------------------------------------------------------------------*/
    /* outputs */
    /*-------------------------------------------------------------------*/
    double *P;                /* output matrix */
    double *Elasticity;
    /*-------------------------------------------------------------------*/
    /* create a pointer to the real data in the input matrix  */
    /*-------------------------------------------------------------------*/        
    dims_F               =  mxGetDimensions(prhs[3]);
    dim                  =  (size_t)dims_F[0];    
    ngauss               =  (size_t)dims_F[2];    

    mu1_                 =  mxGetPr(prhs[0]);
    mu2_                 =  mxGetPr(prhs[1]);
    lambda_              =  mxGetPr(prhs[2]);
    mu1                  =  mu1_[0];
    mu2                  =  mu2_[0];
    lambda               =  lambda_[0];
    F                    =  mxGetPr(prhs[3]);  
    H                    =  mxGetPr(prhs[4]);
    J                    =  mxGetPr(prhs[5]);
    /*-------------------------------------------------------------------*/
    /* get a pointer to the real data in the output matrix */
    /*-------------------------------------------------------------------*/
    mwSize PDims[3]      =  {dim,dim,ngauss};            
    mwSize ElastDims[3]  =  {dim*dim,dim*dim,ngauss};
    plhs[0]              =  mxCreateNumericArray(3, PDims, mxDOUBLE_CLASS, mxREAL);   /*P*/
    plhs[1]              =  mxCreateNumericArray(3, ElastDims, mxDOUBLE_CLASS, mxREAL);   /*P*/
    P                    =  mxGetPr(plhs[0]);
    Elasticity           =  mxGetPr(plhs[1]);
    /*-------------------------------------------------------------------*/
    /* call the computational routine */
    /*-------------------------------------------------------------------*/
    mwSize igauss;
    if (dim==2){
       for (igauss=0; igauss<ngauss; ++igauss){
           MooneyRivlin<2>(mu1,mu2,lambda,&F[dim*dim*igauss],&H[dim*dim*igauss],J[igauss],&P[dim*dim*igauss],&Elasticity[dim*dim*dim*dim*igauss]);
       }
    }
    else if (dim==3){
       for (igauss=0; igauss<ngauss; ++igauss){
           MooneyRivlin<3>(mu1,mu2,lambda,&F[dim*dim*igauss],&H[dim*dim*igauss],J[igauss],&P[dim*dim*igauss],&Elasticity[dim*dim*dim*dim*igauss]);
       }    
    }
}


