#include "mex.h"
#include "FastorHelper.h"

/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
/* The C function */
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
template<size_t ndim>
void MooneyRivlinTI(double mu1,
        double mu2,
        double muani,
        double lambda,
        const double *N0_m,
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
void MooneyRivlinTI<2>(double mu1,
        double mu2,
        double muani,
        double lambda,
        const double *N0_m,
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
    Tensor<double,ndim,1> N0;
    copy_matlab(F,F_m);
    copy_matlab(H,H_m);
    copy_matlab(N0,N0_m);
    double J = J_m;
    /*-------------------------------------------------------------------*/    
    // IDENTITY SECOND ORDER TENSOR
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim> Imatrix; Imatrix.eye();
    /*-------------------------------------------------------------------*/
    // COMPUTE FIRST DERIVATIVES OF THE MODEL    
    /*-------------------------------------------------------------------*/
    Tensor<double,ndim,ndim> N0N0     =  dyadic(N0,N0);
    Tensor<double,ndim,ndim> FN0N0    =  matmul(N0N0,F);   
    Tensor<double,ndim,ndim> FT       =  transpose(F); 
    Tensor<double,ndim,ndim> FN0N0FT  =  matmul(FT,FN0N0);   
    double invariant  =  trace(FN0N0FT) - 1.;
    double traction   =  1.;
    if (invariant<=0.){
        invariant  =  0.;
        traction   =  0.;
    }    
    Tensor<double,ndim,ndim> WF  =  (mu1 + mu2)*F + muani*(invariant*invariant)*FN0N0;
    double WJ =  -(mu1 + 2*mu2)/J +  + mu2*J + lambda*(J - 1.);    
    /*-------------------------------------------------------------------*/
    // COMPUTE FIRST PIOLA STRESS TENSOR    
    /*-------------------------------------------------------------------*/
    Tensor<double,ndim,ndim> P   =  WF + WJ*H;    
    /*-------------------------------------------------------------------*/    
    // Auxiliary tensors and variables needed
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim,ndim,ndim> I_I     =  outer(Imatrix,Imatrix);
    Tensor<double,ndim,ndim,ndim,ndim> I_N0N0  =  outer(N0N0,Imatrix);
    Tensor<double,ndim,ndim,ndim,ndim> I4D     =  permutation<Index<1,3,2,4>>(I_I);    
    Tensor<double,ndim,ndim,ndim,ndim> I4DT    =  permutation<Index<2,3,1,4>>(I_I);    
    Tensor<double,ndim,ndim,ndim,ndim> FN0N0_FN0N0  =  outer(FN0N0,FN0N0);
    Tensor<double,ndim,ndim,ndim,ndim> I4_N0N0      =  permutation<Index<1,3,2,4>>(I_N0N0);    
     
    Tensor<double,ndim,ndim,ndim,ndim> WFF  =  (mu1 + mu2)*I4D + muani*(invariant*invariant)*I4_N0N0 + 4*muani*invariant*FN0N0_FN0N0;
    double WJJ =  (mu1 + mu2)/(J*J) + mu2 + lambda;    
     
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
void MooneyRivlinTI<3>(double mu1,
        double mu2,
        double muani,
        double lambda,
        const double *N0_m,
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
    Tensor<double,ndim,1> N0;
    copy_matlab(F,F_m);
    copy_matlab(H,H_m);
    copy_matlab(N0,N0_m);
    double J   =  J_m;
    /*-------------------------------------------------------------------*/    
    // IDENTITY SECOND ORDER TENSOR
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim> Imatrix; Imatrix.eye();
    /*-------------------------------------------------------------------*/
    // COMPUTE FIRST DERIVATIVES OF THE MODEL    
    /*-------------------------------------------------------------------*/
    Tensor<double,ndim,ndim> N0N0   =  dyadic(N0,N0);
    Tensor<double,ndim,ndim> FN0N0  =  matmul(N0N0,F);   
    Tensor<double,ndim,ndim> FT     =  transpose(F); 
    Tensor<double,ndim,ndim> FN0N0FT =  matmul(FT,FN0N0);   
    double invariant  =  trace(FN0N0FT) - 1.;
    double traction   =  1.;
    if (invariant<=0.){
        invariant  =  0.;
        traction   =  0.;
    }    
    Tensor<double,ndim,ndim> WF  =  mu1*F + muani*(invariant*invariant)*FN0N0;
    Tensor<double,ndim,ndim> WH  =  mu2*H;
    double WJ =  -(mu1 + 2*mu2)/J + lambda*(J - 1.);    
    /*-------------------------------------------------------------------*/
    // COMPUTE FIRST PIOLA STRESS TENSOR    
    /*-------------------------------------------------------------------*/
    Tensor<double,ndim,ndim> P   =  WF + cross(WH,F) + WJ*H;    
    /*-------------------------------------------------------------------*/    
    // Auxiliary tensors and variables needed
    /*-------------------------------------------------------------------*/    
    Tensor<double,ndim,ndim,ndim,ndim> I_I     =  outer(Imatrix,Imatrix);
    Tensor<double,ndim,ndim,ndim,ndim> I_N0N0  =  outer(N0N0,Imatrix);
    Tensor<double,ndim,ndim,ndim,ndim> I4D     =  permutation<Index<1,3,2,4>>(I_I);    
    Tensor<double,ndim,ndim,ndim,ndim> FN0N0_FN0N0  =  outer(FN0N0,FN0N0);
    Tensor<double,ndim,ndim,ndim,ndim> I4_N0N0   =  permutation<Index<1,3,2,4>>(I_N0N0);    

    
    Tensor<double,ndim,ndim,ndim,ndim> WFF  =  mu1*I4D + muani*(invariant*invariant)*I4_N0N0 + 4*muani*invariant*FN0N0_FN0N0;
    Tensor<double,ndim,ndim,ndim,ndim> WHH  =  mu2*I4D;
    double WJJ =  (mu1 + 2.*mu2)/(J*J) + lambda;    
    
    Tensor<double,ndim,ndim,ndim,ndim> F_WHH_F  =  cross(cross(F,WHH),F);
    Tensor<double,ndim,ndim,ndim,ndim> H_H  =  outer(H,H);        
     
    Tensor<double,ndim,ndim>  Geom  =  WH + WJ*F;
    Tensor<double,ndim,ndim,ndim,ndim> C_Geom  =  cross(Geom,I4D); 
     
    Tensor<double,ndim,ndim,ndim,ndim> Elasticity4D  =  WFF + F_WHH_F + WJJ*H_H + C_Geom;    
//    Tensor<double,ndim,ndim,ndim,ndim> Elasticity4D  =  F_WHH_F;    
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
    double *mu1_, *mu2_, *muani_, *lambda_;
    double mu1, mu2, muani, lambda;
    double *N0;
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
    dims_F               =  mxGetDimensions(prhs[5]);
    dim                  =  (size_t)dims_F[0];    
    ngauss               =  (size_t)dims_F[2];    

    mu1_                 =  mxGetPr(prhs[0]);
    mu2_                 =  mxGetPr(prhs[1]);
    muani_               =  mxGetPr(prhs[2]);
    lambda_              =  mxGetPr(prhs[3]);
    mu1                  =  mu1_[0];
    mu2                  =  mu2_[0];
    muani                =  muani_[0];
    lambda               =  lambda_[0];
    N0                   =  mxGetPr(prhs[4]);
    F                    =  mxGetPr(prhs[5]);  
    H                    =  mxGetPr(prhs[6]);
    J                    =  mxGetPr(prhs[7]);
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
           MooneyRivlinTI<2>(mu1,mu2,muani,lambda, &N0[dim*igauss], &F[dim*dim*igauss],&H[dim*dim*igauss],J[igauss],&P[dim*dim*igauss],&Elasticity[dim*dim*dim*dim*igauss]);
       }
    }
    else if (dim==3){
       for (igauss=0; igauss<ngauss; ++igauss){
            MooneyRivlinTI<3>(mu1,mu2,muani,lambda, &N0[dim*igauss], &F[dim*dim*igauss],&H[dim*dim*igauss],J[igauss],&P[dim*dim*igauss],&Elasticity[dim*dim*dim*dim*igauss]);
       }    
    }
}


