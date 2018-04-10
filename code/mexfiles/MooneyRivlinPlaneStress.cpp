#include "mex.h"
#include "FastorHelper.h"

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/*C FUNCTION FOR PLANE STRAIN*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
void MooneyRivlin(double mu1,
        double mu2,
        double lambda,
        const double *F_m,
        const double *H_m,
        double J_m,
        double *P_m,
        double *Elasticity_m,
        double *tstretch_m)
{
    /*-------------------------------------------------------------------*/
    /*Dimension of the problem*/
    /*-------------------------------------------------------------------*/
    const mwSize  ndim  =  2;
    /*-------------------------------------------------------------------*/
    /*Copy from C to Fastor*/
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim> F;
    Tensor<double,ndim,ndim> H;
    copy_matlab(F,F_m);
    copy_matlab(H,H_m);
    double J = J_m;
    /*-------------------------------------------------------------------*/    
    // Newton-Raphson to compute the thickness stretch
    /*-------------------------------------------------------------------*/    
    double thickness_stretch, tolerance, residual;
    double DWDlambda, D2WDlambda;
    thickness_stretch  =  1.;
    tolerance          =  1e-8;
    residual           =  1.;
    Tensor<double,ndim,ndim> FTF  =  matmul(F,transpose(F));
    double trace_FTF  =  trace(FTF);
    for (mwSize iter=0; iter<4; iter++){
    //while (residual>tolerance){
          DWDlambda          =  (mu1 + mu2*trace_FTF)*thickness_stretch - (mu1 + 2.*mu2)/thickness_stretch + J*lambda*(J*thickness_stretch - 1);
          D2WDlambda         =  (mu1 + mu2*trace_FTF) + (mu1 + 2.*mu2)/(thickness_stretch*thickness_stretch) + J*J*lambda;
          thickness_stretch  =  thickness_stretch - (1./D2WDlambda)*DWDlambda;
          residual           =  abs(DWDlambda);
    //}
    }
    tstretch_m[0]   =  thickness_stretch;    
    double t2;
    t2    =  thickness_stretch*thickness_stretch;
    /*-------------------------------------------------------------------*/    
    // IDENTITY SECOND ORDER TENSOR
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim> Imatrix; Imatrix.eye();
    /*-------------------------------------------------------------------*/
    // COMPUTE FIRST DERIVATIVES OF THE MODEL    
    /*-------------------------------------------------------------------*/
    Tensor<double,ndim,ndim> WF  =  (mu1 + mu2*t2)*F;
    double WJ =  -(mu1 + 2*mu2)/J + lambda*thickness_stretch*(thickness_stretch*J - 1.) + mu2*J;    
    /*-------------------------------------------------------------------*/
    // COMPUTE FIRST PIOLA STRESS TENSOR    
    /*-------------------------------------------------------------------*/
    Tensor<double,ndim,ndim> P   =  WF + WJ*H;    
    /*-------------------------------------------------------------------*/    
    // SECOND ORDER DERIVATIVES WITH RESPECT TO F2D
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim,ndim,ndim> I_I   =  outer(Imatrix,Imatrix);
    Tensor<double,ndim,ndim,ndim,ndim> I4D   =  permutation<Index<1,3,2,4>>(I_I);    
    Tensor<double,ndim,ndim,ndim,ndim> I4DT  =  permutation<Index<2,3,1,4>>(I_I);    
 
    Tensor<double,ndim,ndim,ndim,ndim> WFF  =  (mu1 + mu2*t2)*I4D;
    double WJJ =  (mu1 + 2*mu2)/(J*J) + lambda*(thickness_stretch*thickness_stretch) + mu2;    
    
    Tensor<double,ndim,ndim,ndim,ndim> H_H  =  outer(H,H);        
    Tensor<double,ndim,ndim,ndim,ndim> C_Geom  =  WJ*(I_I - I4DT); 
    /*-------------------------------------------------------------------*/    
    // CROSS DERIVATIVES WITH RESPECT TO F2D AND THICKNESS STRETCH
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim> WFt    =  2*mu2*thickness_stretch*F;    
    double WJt =  lambda*(2.*thickness_stretch*J - 1.);
    Tensor<double,ndim,ndim> DPDt   =  WFt + WJt*H;    
    Tensor<double,ndim,ndim,ndim,ndim> DPDt_DPDt = -(1./D2WDlambda)*outer(DPDt,DPDt);
    /*-------------------------------------------------------------------*/    
    // TOTAL CONTRIBUTION IN THE ELASTICITY TENSOR
    /*-------------------------------------------------------------------*/        
    Tensor<double,ndim,ndim,ndim,ndim> Elasticity4D  =  WFF + WJJ*H_H + C_Geom + DPDt_DPDt;    
    Tensor<double,ndim*ndim,ndim*ndim> Elasticity    =  reshape<ndim*ndim,ndim*ndim>(Elasticity4D);
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
    double *P;              
    double *Elasticity;
    double *tstretch;
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
    plhs[0]              =  mxCreateNumericArray(3, PDims, mxDOUBLE_CLASS, mxREAL);   
    plhs[1]              =  mxCreateNumericArray(3, ElastDims, mxDOUBLE_CLASS, mxREAL);   
    plhs[2]              =  mxCreateDoubleMatrix((mwSize)ngauss,(mwSize)1, mxREAL);  
    
    P                    =  mxGetPr(plhs[0]);
    Elasticity           =  mxGetPr(plhs[1]);
    tstretch             =  mxGetPr(plhs[2]);
    /*-------------------------------------------------------------------*/
    /* call the computational routine */
    /*-------------------------------------------------------------------*/
    mwSize igauss;
    for (igauss=0; igauss<ngauss; ++igauss){
        MooneyRivlin(mu1,mu2,lambda,&F[dim*dim*igauss],&H[dim*dim*igauss],J[igauss],&P[dim*dim*igauss],&Elasticity[dim*dim*dim*dim*igauss], &tstretch[igauss]);
    }
}


