#include "mex.h"
#include "FastorHelper.h"

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
template<size_t ndim>
void ArrudaBoyce(double mu,
        double m,
        double lambda,
        const double *F_m,
        const double *H_m,
        double J_m,
        double *P_m,
        double *Elasticity_m);
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/*C FUNCTION FOR 2D PROBLEMS*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
template<>
void ArrudaBoyce<2>(double mu,
        double m,
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
    Tensor<double,ndim,ndim> H;
    copy_matlab(F,F_m);
    copy_matlab(H,H_m);
    double J = J_m;
    /*-------------------------------------------------------------------*/    
    // IDENTITY SECOND ORDER TENSOR
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim> Imatrix; Imatrix.eye();
    /*-------------------------------------------------------------------*/
    // COMPUTE FIRST DERIVATIVES OF THE MODEL    
    /*-------------------------------------------------------------------*/
    Tensor<double,ndim,ndim> FTF  =  matmul(F,transpose(F));
    double trace_FTF   =  trace(FTF);
    double WF_scalar   =  (1 + m/5.*(trace_FTF + 1.) + 33.*m*m/525.*(trace_FTF + 1.)*(trace_FTF + 1.))*mu;          
    double WF_scalar2  =  mu*(2*m/5. + 4.*33.*m*m/525.*(trace_FTF + 1.));
    double beta  =  mu*(1 + 6.*m/10. + 297.*m*m/525.);
    
    Tensor<double,ndim,ndim> WF  =  WF_scalar*F;
    double WJ =  -beta/J + lambda*(J - 1.);    
    /*-------------------------------------------------------------------*/
    // COMPUTE FIRST PIOLA STRESS TENSOR    
    /*-------------------------------------------------------------------*/
    Tensor<double,ndim,ndim> P   =  WF + WJ*H;    
    /*-------------------------------------------------------------------*/    
    // Auxiliary tensors and variables needed
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim,ndim,ndim> I_I   =  outer(Imatrix,Imatrix);
    Tensor<double,ndim,ndim,ndim,ndim> I4D   =  permutation<Index<1,3,2,4>>(I_I);    
    Tensor<double,ndim,ndim,ndim,ndim> I4DT  =  permutation<Index<2,3,1,4>>(I_I);    
    Tensor<double,ndim,ndim,ndim,ndim> F_F   =  outer(F,F);    
 
    Tensor<double,ndim,ndim,ndim,ndim> WFF  =  WF_scalar*I4D + WF_scalar2*F_F;
    double WJJ =  beta/(J*J) + lambda;    
    
    Tensor<double,ndim,ndim,ndim,ndim> H_H  =  outer(H,H);        
    Tensor<double,ndim,ndim,ndim,ndim> C_Geom  =  WJ*(I_I - I4DT); 

    Tensor<double,ndim,ndim,ndim,ndim> Elasticity4D  =  WFF + WJJ*H_H + C_Geom;    
    Tensor<double,ndim*ndim,ndim*ndim> Elasticity  =  reshape<ndim*ndim,ndim*ndim>(Elasticity4D);
    /*-------------------------------------------------------------------*/    
    // Copy back from Fastor to C*
    /*-------------------------------------------------------------------*/    
    copy_fastor(P_m,P);    
    copy_fastor(Elasticity_m,Elasticity);
}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/*C FUNCTION FOR 3D PROBLEMS*/
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
template<>
void ArrudaBoyce<3>(double mu,
        double m,
        double lambda,
        const double *F_m,
        const double *H_m,
        double J_m,
        double *P_m,
        double *Elasticity_m)
{
    const mwSize  ndim  =  3;
    /*-------------------------------------------------------------------*/
    /*Copy from C to Fastor*/
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim> F;
    Tensor<double,ndim,ndim> H;
    copy_matlab(F,F_m);
    copy_matlab(H,H_m);
    double J   =  J_m;
    /*-------------------------------------------------------------------*/    
    // IDENTITY SECOND ORDER TENSOR
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim> Imatrix; Imatrix.eye();
    /*-------------------------------------------------------------------*/
    // COMPUTE FIRST DERIVATIVES OF THE MODEL    
    /*-------------------------------------------------------------------*/
    Tensor<double,ndim,ndim> FTF  =  matmul(F,transpose(F));
    double trace_FTF   =  trace(FTF);
    double WF_scalar   =  (1 + m/5.*(trace_FTF) + 33.*m*m/525.*(trace_FTF)*(trace_FTF))*mu;          
    double WF_scalar2  =  mu*(2*m/5. + 4.*33.*m*m/525.*(trace_FTF));
    double beta  =  mu*(1 + 6.*m/10. + 297.*m*m/525.);

    Tensor<double,ndim,ndim> WF  =  WF_scalar*F;
    double WJ =  -beta/J + lambda*(J - 1.);    
    /*-------------------------------------------------------------------*/
    // COMPUTE FIRST PIOLA STRESS TENSOR    
    /*-------------------------------------------------------------------*/
    Tensor<double,ndim,ndim> P   =  WF + WJ*H;    
    /*-------------------------------------------------------------------*/    
    // Auxiliary tensors and variables needed
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim,ndim,ndim> I_I   =  outer(Imatrix,Imatrix);
    Tensor<double,ndim,ndim,ndim,ndim> I4D   =  permutation<Index<1,3,2,4>>(I_I);    
    Tensor<double,ndim,ndim,ndim,ndim> I4DT  =  permutation<Index<2,3,1,4>>(I_I);    
    Tensor<double,ndim,ndim,ndim,ndim> F_F   =  outer(F,F);    
    
    Tensor<double,ndim,ndim,ndim,ndim> WFF  =  WF_scalar*I4D + WF_scalar2*F_F;
    double WJJ =  beta/(J*J) + lambda;    
        
    Tensor<double,ndim,ndim,ndim,ndim> H_H  =  outer(H,H);             
    Tensor<double,ndim,ndim>  Geom  =  WJ*F;
    Tensor<double,ndim,ndim,ndim,ndim> C_Geom  =  cross(Geom,I4D); 
     
    Tensor<double,ndim,ndim,ndim,ndim> Elasticity4D  =  WFF + WJJ*H_H + C_Geom;    
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
           ArrudaBoyce<2>(mu1,mu2,lambda,&F[dim*dim*igauss],&H[dim*dim*igauss],J[igauss],&P[dim*dim*igauss],&Elasticity[dim*dim*dim*dim*igauss]);
       }
    }
    else if (dim==3){
       for (igauss=0; igauss<ngauss; ++igauss){
           ArrudaBoyce<3>(mu1,mu2,lambda,&F[dim*dim*igauss],&H[dim*dim*igauss],J[igauss],&P[dim*dim*igauss],&Elasticity[dim*dim*dim*dim*igauss]);
       }    
    }
}


